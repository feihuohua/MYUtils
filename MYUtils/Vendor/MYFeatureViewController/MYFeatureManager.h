//
//  MYFeatureManager.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/20.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYFeatureManager : NSObject

+ (instancetype)shareManager;

/**
 *  是否显示新特性视图控制器, 对比版本号得知
 */
- (BOOL)shouldShowNewFeature;

@end
