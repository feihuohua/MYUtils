//
//  MYCountDownTimeIntervalModel.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYCountDownTimeIntervalModel.h"

@implementation MYCountDownTimeIntervalModel

+ (instancetype)timeInterval:(NSInteger)timeInterval {
    MYCountDownTimeIntervalModel *object = [[MYCountDownTimeIntervalModel alloc] init];
    object.timeInterval = timeInterval;
    return object;
}

@end
