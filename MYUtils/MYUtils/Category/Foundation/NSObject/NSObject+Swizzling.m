//
//  NSObject+Swizzling.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSObject+Swizzling.h"
#import <objc/runtime.h>

@implementation NSObject (Swizzling)

+ (void)instanceSwizzle:(Class)cls
            oldSelector:(SEL)oldSelector
            newSelector:(SEL)newSelector {
    Method oldMethod = class_getInstanceMethod(cls, oldSelector);
    Method newMethod = class_getInstanceMethod(cls, newSelector);
    
    if (class_addMethod(cls, oldSelector, method_getImplementation(newMethod),
                        method_getTypeEncoding(newMethod))) {
        class_replaceMethod(cls, newSelector, method_getImplementation(oldMethod),
                            method_getTypeEncoding(oldMethod));
    } else {
        method_exchangeImplementations(oldMethod, newMethod);
    }
}

+ (void)classSwizzle:(Class)cls
         oldSelector:(SEL)oldSelector
         newSelector:(SEL)newSelector {
    cls = object_getClass(cls);
    [NSObject instanceSwizzle:cls
                  oldSelector:oldSelector
                  newSelector:newSelector];
}

- (void)instanceSwizzle:(SEL)oldSelector newSelector:(SEL)newSElector {
    [NSObject instanceSwizzle:[self class]
                  oldSelector:oldSelector
                  newSelector:newSElector];
}

- (void)classSwizzle:(SEL)oldSelector newSelector:(SEL)newSelector {
    [NSObject classSwizzle:[self class]
               oldSelector:oldSelector
               newSelector:newSelector];
}

@end
