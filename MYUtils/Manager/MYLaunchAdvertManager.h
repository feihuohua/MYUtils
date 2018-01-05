//
//  MYLaunchAdvertManager.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYLaunchAdvertManager : NSObject

+ (instancetype)shareManager;

/// 加载本地视频资源
- (void)showSplashScreenLocalVideo;

/// 加载本地图片资源
- (void)showSplashScreenLocalImage;

/// 加载网络图片资源
- (void)showSplashScreenNetWorkImage;

@end
