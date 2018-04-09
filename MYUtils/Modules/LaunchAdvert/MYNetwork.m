//
//  MYNetwork.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/4/9.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYNetwork.h"

@implementation MYNetwork

/**
 *  此处模拟广告数据请求,实际项目中请做真实请求
 */
+ (void)getLaunchAdImageDataSuccess:(NetworkSucess)success failure:(NetworkFailure)failure {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LaunchImageAd" ofType:@"json"]];
        NSDictionary *json =  [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        if(success) success(json);
        
    });
}

/**
 *  此处模拟广告数据请求,实际项目中请做真实请求
 */
+ (void)getLaunchAdVideoDataSuccess:(NetworkSucess)success failure:(NetworkFailure)failure {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"LaunchVideoAd" ofType:@"json"]];
        NSDictionary *json =  [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        if(success) success(json);
        
    });
}

@end
