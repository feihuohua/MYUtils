//
//  MYNetwork.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/4/9.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^NetworkSucess) (NSDictionary * response);
typedef void(^NetworkFailure) (NSError *error);

@interface MYNetwork : NSObject

/**
 *  此处用于模拟广告数据请求,实际项目中请做真实请求
 */
+ (void)getLaunchAdImageDataSuccess:(NetworkSucess)success failure:(NetworkFailure)failure;
+ (void)getLaunchAdVideoDataSuccess:(NetworkSucess)success failure:(NetworkFailure)failure;

@end
