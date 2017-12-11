//
//  MYRunLoopOperationManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYRunLoopOperationManager.h"

@interface MYRunLoopOperationManager()

@property (nonatomic, strong) NSMutableArray *tasks;
@property (nonatomic, strong) NSMutableArray *tasksKeys;
@property (nonatomic, strong) NSTimer *timer;


@end

@implementation MYRunLoopOperationManager

- (instancetype)init {
    if ((self = [super init])) {
        _maximumQueueLength = 30;
        _tasks = [NSMutableArray array];
        _tasksKeys = [NSMutableArray array];
    }
    return self;
}

+ (instancetype)sharedManager {
    static MYRunLoopOperationManager *_manager;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        _manager = [[MYRunLoopOperationManager alloc] init];
        [self _registerRunLoopWorkDistributionAsMainRunloopObserver:_manager];
    });
    return _manager;
}

- (void)removeAllTasks {
    [self.tasks removeAllObjects];
    [self.tasksKeys removeAllObjects];
}

- (void)addTask:(MYRunLoopOperation)operation withKey:(id)key {
    [self.tasks addObject:operation];
    [self.tasksKeys addObject:key];
    if (self.tasks.count > self.maximumQueueLength) {
        [self.tasks removeObjectAtIndex:0];
        [self.tasksKeys removeObjectAtIndex:0];
    }
}

+ (void)_registerRunLoopWorkDistributionAsMainRunloopObserver:(MYRunLoopOperationManager *)operationManager {
    static CFRunLoopObserverRef defaultModeObserver;
    _registerObserver(kCFRunLoopBeforeWaiting,
                      defaultModeObserver,
                      NSIntegerMax,
                      kCFRunLoopDefaultMode,
                      (__bridge void *)operationManager,
                      &_defaultModeRunLoopWorkDistributionCallback);
}

static void _registerObserver(CFOptionFlags activities, CFRunLoopObserverRef observer, CFIndex order, CFStringRef mode, void *info, CFRunLoopObserverCallBack callback) {
    CFRunLoopRef runLoop = CFRunLoopGetCurrent();
    CFRunLoopObserverContext context = {
        0,
        info,
        &CFRetain,
        &CFRelease,
        NULL
    };
    observer = CFRunLoopObserverCreate(NULL,
                                       activities,
                                       YES,
                                       order,
                                       callback,
                                       &context);
    CFRunLoopAddObserver(runLoop, observer, mode);
    CFRelease(observer);
}

static void _runLoopWorkDistributionCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    MYRunLoopOperationManager *operationManager = (__bridge MYRunLoopOperationManager *)info;
    if (operationManager.tasks.count == 0) {
        return;
    }
    BOOL result = NO;
    while (result == NO && operationManager.tasks.count) {
        MYRunLoopOperation operation = operationManager.tasks.firstObject;
        result = operation();
        [operationManager.tasks removeObjectAtIndex:0];
        [operationManager.tasksKeys removeObjectAtIndex:0];
    }
}

static void _defaultModeRunLoopWorkDistributionCallback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    _runLoopWorkDistributionCallback(observer, activity, info);
}

@end
