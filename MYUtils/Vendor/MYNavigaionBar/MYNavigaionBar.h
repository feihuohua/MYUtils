//
//  MYNavigaionBar.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/2/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYNavigaionBar : UIView

+ (BOOL)isIphoneX;
+ (CGFloat)navBarBottom;
+ (CGFloat)tabBarHeight;
+ (CGFloat)screenWidth;
+ (CGFloat)screenHeight;

@end

#pragma mark - Default
@interface MYNavigaionBar (Default)

/** set default barTintColor of UINavigationBar */
+ (void)setDefaultNavBarBarTintColor:(UIColor *)color;

/** set default tintColor of UINavigationBar */
+ (void)setDefaultNavBarTintColor:(UIColor *)color;

/** set default titleColor of UINavigationBar */
+ (void)setDefaultNavBarTitleColor:(UIColor *)color;

/** set default statusBarStyle of UIStatusBar */
+ (void)setDefaultStatusBarStyle:(UIStatusBarStyle)style;

/** set default shadowImage isHidden of UINavigationBar */
+ (void)setDefaultNavBarShadowImageHidden:(BOOL)hidden;

@end

