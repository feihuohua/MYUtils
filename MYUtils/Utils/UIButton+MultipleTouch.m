//
//  UIButton+MultipleTouch.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/12.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UIButton+MultipleTouch.h"
#import <objc/runtime.h>

#define defaultInterval 0.5f  // 默认时间间隔

@interface UIButton()

@property (nonatomic, assign) BOOL isIgnoreEvent;

@end

@implementation UIButton (MultipleTouch)

static char timeIntervalKey;

BOOL my_ClassMethodSwizzle(Class aClass, SEL originalSelector, SEL swizzleSelector) {
    Method originalMethod = class_getInstanceMethod(aClass, originalSelector);
    Method swizzleMethod = class_getInstanceMethod(aClass, swizzleSelector);
    BOOL didAddMethod = class_addMethod(aClass,
                                        originalSelector,
                                        method_getImplementation(swizzleMethod),
                                        method_getTypeEncoding(swizzleMethod));
    if (didAddMethod) {
        class_replaceMethod(aClass,
                            swizzleSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzleMethod);
    }
    return YES;
}

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        my_ClassMethodSwizzle([self class], @selector(sendAction:to:forEvent:), @selector(my_sendAction:to:forEvent:));
    });
}

- (void)my_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
    
    if ([NSStringFromClass(self.class) isEqualToString:@"UIButton"]) {
        
        if (self.isIgnoreEvent) {
            return;
        }
        self.timeInterval = self.timeInterval == 0 ? defaultInterval : self.timeInterval;
        
        self.isIgnoreEvent = YES;
        
        [self performSelector:@selector(setIsIgnoreEvent:) withObject:nil afterDelay:self.timeInterval];
    }
    [self my_sendAction:action to:target forEvent:event];
}

- (void)setIsIgnoreEvent:(BOOL)isIgnoreEvent {
    objc_setAssociatedObject(self, @selector(isIgnoreEvent), @(isIgnoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isIgnoreEvent {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (NSTimeInterval)timeInterval {
    return [objc_getAssociatedObject(self, &timeIntervalKey) boolValue];
}

- (void)setTimeInterval:(NSTimeInterval)timeInterval {
    objc_setAssociatedObject(self, &timeIntervalKey, @(timeInterval), OBJC_ASSOCIATION_ASSIGN);
}

@end
