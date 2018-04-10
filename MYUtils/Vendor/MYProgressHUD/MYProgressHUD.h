//
//  MYProgressHUD.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;

typedef NS_ENUM(NSInteger, MYProgressHUDStatus) {
    MYProgressHUDStatusSuccess, /** 成功 */
    MYProgressHUDStatusError,   /** 失败 */
    MYProgressHUDStatusMessage, /** 提示 */
    MYProgressHUDStatusWaitting /** 等待 */
};

@interface MYProgressHUD : NSObject

/**
 *  在 window 上添加一个只显示文字的 HUD
 */
+ (void)showMessage:(NSString *)text;

/**
 *  在 toView 上添加一个只显示文字的 HUD
 */
+ (void)showMessage:(NSString *)text toView:(UIView *)view;

/**
 *  在 toView 上添加一个只显示文字的 HUD yOffset 偏移量
 */
+ (void)showMessage:(NSString *)text toView:(UIView *)view yOffset:(CGFloat)yOffset;

/**
 *  在 toView 上添加一个只显示文字的 HUD
 */
+ (void)showStatus:(MYProgressHUDStatus)status text:(NSString *)text toView:(UIView *)view;

/**
 *  在 window 上添加一个提示`等待`的 HUD, 需要手动关闭
 */
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message;

/**
 *  在 toView 上添加一个提示`等待`的 HUD, 需要手动关闭
 */
+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view;

/**
 *  手动隐藏 HUD
 */
+ (void)hide;
+ (void)hideHUDForView:(UIView *)view;

@end
