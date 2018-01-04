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

- (void)showSplashScreenLocalImage;

@end
