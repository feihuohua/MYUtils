//
//  MYProgressHUD.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

typedef NS_ENUM(NSInteger, MYProgressHUDStatus) {
    MYProgressHUDStatusSuccess, /** 成功 */
    MYProgressHUDStatusError,   /** 失败 */
    MYProgressHUDStatusMessage, /** 提示 */
    MYProgressHUDStatusWaitting /** 等待 */
};

@interface MYProgressHUD : MBProgressHUD

/**
 *  是否正在显示
 */
@property (nonatomic, assign, getter=isShowNow) BOOL showNow;

/**
 *  返回一个 HUD 的单例
 */
+ (instancetype)sharedHUD;

/**
 *  在 window 上添加一个提示`等待`的 HUD, 需要手动关闭
 */
+ (void)showLoadingMessage:(NSString *)text;

/**
 *  在 window 上添加一个只显示文字的 HUD
 */
+ (void)showMessage:(NSString *)text;

/**
 *  在 toView 上添加一个只显示文字的 HUD
 */
+ (void)showMessage:(NSString *)text toView:(UIView *)view;

/**
 *  在 toView 上添加一个显示文字和图片的 HUD
 */
+ (void)showMessage:(NSString *)text hudImage:(NSString *)image toView:(UIView *)view;

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view;

/**
 *  手动隐藏 HUD
 */
+ (void)hide;
+ (void)hideHUDForView:(UIView *)view;

@end
