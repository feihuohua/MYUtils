//
//  MYCountDownManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYCountDownManager.h"
#import "MYCountDownTimeIntervalModel.h"
#import <YYWeakProxy.h>

NSString *const kMYCountDownNotification = @"MYCountDownNotification";

@interface MYCountDownManager()

@property (nonatomic, strong) NSTimer *timer;

/// 时间差字典(单位:秒)(使用字典来存放, 支持多列表或多页面使用)
@property (nonatomic, strong) NSMutableDictionary<NSString *, MYCountDownTimeIntervalModel *> *timeIntervalDictionary;

/// 后台模式使用, 记录进入后台的本地时间
@property (nonatomic, assign) BOOL backgroudRecord;
@property (nonatomic, assign) CFAbsoluteTime lastTime;

@end

@implementation MYCountDownManager

+ (instancetype)manager {
    static MYCountDownManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[MYCountDownManager alloc] init];
    });
    return manager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        // 监听进入前台与进入后台的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidEnterBackgroundNotification) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillEnterForegroundNotification) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
    return self;
}

- (void)dealloc {
    
}

- (void)start {
    // 启动定时器
    [self timer];
}

- (void)reload {
    // 刷新只要让时间差为0即可
    _timeInterval = 0;
}

- (void)invalidate {
    [self.timer invalidate];
    self.timer = nil;
}

- (void)timerAction {
    // 定时器每次加1
    [self timerActionWithTimeInterval:1];
}

- (void)timerActionWithTimeInterval:(NSInteger)timeInterval {
    // 时间差+
    self.timeInterval += timeInterval;
    [self.timeIntervalDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, MYCountDownTimeIntervalModel * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.timeInterval += timeInterval;
    }];
    // 发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kMYCountDownNotification object:nil userInfo:nil];
}

- (void)addSourceWithIdentifier:(NSString *)identifier {
    MYCountDownTimeIntervalModel *timeInterval = self.timeIntervalDictionary[identifier];
    if (timeInterval) {
        timeInterval.timeInterval = 0;
    } else {
        [self.timeIntervalDictionary setObject:[MYCountDownTimeIntervalModel timeInterval:0] forKey:identifier];
    }
}

- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier {
    return self.timeIntervalDictionary[identifier].timeInterval;
}

- (void)reloadSourceWithIdentifier:(NSString *)identifier {
    self.timeIntervalDictionary[identifier].timeInterval = 0;
}

- (void)reloadAllSource {
    [self.timeIntervalDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, MYCountDownTimeIntervalModel * _Nonnull obj, BOOL * _Nonnull stop) {
        obj.timeInterval = 0;
    }];
}

- (void)removeSourceWithIdentifier:(NSString *)identifier {
    [self.timeIntervalDictionary removeObjectForKey:identifier];
}

- (void)removeAllSource {
    [self.timeIntervalDictionary removeAllObjects];
}

- (void)applicationDidEnterBackgroundNotification {
    self.backgroudRecord = (_timer != nil);
    if (self.backgroudRecord) {
        self.lastTime = CFAbsoluteTimeGetCurrent();
        [self invalidate];
    }
}

- (void)applicationWillEnterForegroundNotification {
    if (self.backgroudRecord) {
        CFAbsoluteTime timeInterval = CFAbsoluteTimeGetCurrent() - self.lastTime;
        // 取整
        [self timerActionWithTimeInterval:(NSInteger)timeInterval];
        [self start];
    }
}

- (NSTimer *)timer {
    if (!_timer) {
        YYWeakProxy *prx = [YYWeakProxy proxyWithTarget:self];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:prx selector:@selector(timerAction) userInfo:nil repeats:YES];
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

- (NSMutableDictionary *)timeIntervalDictionary {
    if (!_timeIntervalDictionary) {
        _timeIntervalDictionary = [NSMutableDictionary dictionary];
    }
    return _timeIntervalDictionary;
}

@end
