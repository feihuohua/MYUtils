//
//  MYFeatureViewController.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/20.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 状态栏样式
 */
typedef NS_ENUM(NSInteger, MYStatusBarStyle) {
    MYStatusBarStyleBlack,  // 黑色
    MYStatusBarStyleWhite,  // 白色
    MYStatusBarStyleNone,   // 隐藏
};

/**
 设备型号
 */
typedef NS_ENUM(NSInteger, DeviceModel) {
    DeviceModelUnknow,      // 未知设备
    DeviceModeliPhone4,     // iPhone 4 / 4s
    DeviceModeliPhone56,    // iPhone 5 / 5s / 6 / 6 p / 6s / 6s p
    DeviceModeliPad,        // iPad
};

/**
 *  完成新特性界面展示后的block回调
 */
typedef void (^MYNewFeatureFinishBlock)();

@interface MYFeatureViewController : UIViewController

/**
 *  当前点(分页控制器)的颜色
 */
@property (nonatomic, strong) UIColor *pointCurrentColor;

/**
 *  其他点(分页控制器)的颜色
 */
@property (nonatomic, strong) UIColor *pointOtherColor;

/**
 *  状态栏样式, 请先参考`必读`第3条设置
 */
@property (nonatomic, assign) MYStatusBarStyle statusBarStyle;

/**
 *  是否显示跳过按钮, 默认不显示
 */
@property (nonatomic, assign) BOOL showSkip;

/**
 *  点击跳过按钮的 block
 */
@property (nonatomic, copy) MYNewFeatureFinishBlock skipBlock;

/**
 *  是否显示新特性视图控制器, 对比版本号得知
 */
+ (BOOL)shouldShowNewFeature;

/**
 *  初始化新特性视图控制器, 类方法
 *
 *  @param imageName 图片名, 请将原图名称修改为该格式: `<imageName>_1`, `<imageName>_2`... 如: `NewFeature_1@2x.png`
 *
 *  @param imageCount 图片个数
 *
 *  @param showPageControl 是否显示分页控制器
 *
 *  @return 初始化的控制器实例
 */
+ (instancetype)newFeatureWithImageName:(NSString *)imageName
                             imageCount:(NSInteger)imageCount
                        showPageControl:(BOOL)showPageControl;

/**
 *  初始化新特性视图控制器, 实例方法
 *
 *  @param imageName 图片名, 请将原图名称修改为该格式: `<imageName>_1`, `<imageName>_2`... 如: `NewFeature_1@2x.png`
 *
 *  @param imageCount 图片个数
 *
 *  @param showPageControl 是否显示分页控制器
 *
 *  @return 初始化的控制器实例
 */
- (instancetype)initWithImageName:(NSString *)imageName
                       imageCount:(NSInteger)imageCount
                  showPageControl:(BOOL)showPageControl;

/**
 *  初始化新特性视图控制器, 类方法
 *
 *  @param imageName 图片名, 请将原图名称修改为该格式: `<imageName>_1`, `<imageName>_2`... 如: `NewFeature_1@2x.png`
 *
 *  @param imageCount 图片个数
 *
 *  @param showPageControl 是否显示分页控制器
 *
 *  @param finishBlock 完成新特性界面展示后的回调
 *
 *  @return 初始化的控制器实例
 */
+ (instancetype)newFeatureWithImageName:(NSString *)imageName
                             imageCount:(NSInteger)imageCount
                        showPageControl:(BOOL)showPageControl
                            finishBlock:(MYNewFeatureFinishBlock)finishBlock;

/**
 *  初始化新特性视图控制器, 实例方法
 *
 *  @param imageName 图片名, 请将原图名称修改为该格式: `<imageName>_1`, `<imageName>_2`... 如: `NewFeature_1@2x.png`
 *
 *  @param imageCount 图片个数
 *
 *  @param showPageControl 是否显示分页控制器
 *
 *  @param finishBlock 完成新特性界面展示后的回调
 *
 *  @return 初始化的控制器实例
 */
- (instancetype)initWithImageName:(NSString *)imageName
                       imageCount:(NSInteger)imageCount
                  showPageControl:(BOOL)showPageControl
                      finishBlock:(MYNewFeatureFinishBlock)finishBlock;

@end
