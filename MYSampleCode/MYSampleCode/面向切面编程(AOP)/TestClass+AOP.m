//
//  TestClass+AOP.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/27.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "TestClass+AOP.h"
#import "Runtime.h"

@implementation TestClass (AOP)

+ (void)load {
    [Runtime methodSwap:[self class] firstMethod:@selector(method1) secondMethod:@selector(method2)];
}

- (void)method2 {
    [self before];
    [self method2];
    [self after];
}

- (void)before {
    NSLog(@"调用方法之前要做的事情");
}

- (void)after {
    NSLog(@"调用方法之后要做的事情");
}

@end
