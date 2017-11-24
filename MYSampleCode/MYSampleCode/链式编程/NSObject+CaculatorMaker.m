//
//  NSObject+CaculatorMaker.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/16.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "NSObject+CaculatorMaker.h"
#import "CaculatorMaker.h"

@implementation NSObject (CaculatorMaker)

+ (int)makeCaculators:(void(^)(CaculatorMaker *make))block {
    CaculatorMaker *mgr = [[CaculatorMaker alloc] init];
    block(mgr);
    return mgr.result;
}

@end
