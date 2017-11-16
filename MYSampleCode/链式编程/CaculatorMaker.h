//
//  CaculatorMaker.h
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/16.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaculatorMaker : NSObject

@property (nonatomic, assign) int result;

/// 加法
- (CaculatorMaker *(^)(int))add;
/// 减法
- (CaculatorMaker *(^)(int))subtraction;
/// 乘法
- (CaculatorMaker *(^)(int))muilt;
/// 除法
- (CaculatorMaker *(^)(int))divide;

@end
