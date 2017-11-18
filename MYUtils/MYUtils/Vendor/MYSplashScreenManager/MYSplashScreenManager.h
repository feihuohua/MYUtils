//
//  MYSplashScreenManager.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/18.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYSplashScreenManager : NSObject

+ (MYSplashScreenManager *)sharedManager;
- (void)showSplashScreenWithDuration:(CGFloat)time;
- (void)startDownLoadNewImageWithUrl:(NSString *)imageUrl;

@end
