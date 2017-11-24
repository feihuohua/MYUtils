//
//  NSObject+CaculatorMaker.h
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/16.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CaculatorMaker;

@interface NSObject (CaculatorMaker)

/// 计算
+ (int)makeCaculators:(void(^)(CaculatorMaker *make))caculatorMaker;

@end
