//
//  MYPopupView.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/2.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *
 *  @brief  实现从当前ViewController底部上滑的View
 */
@interface MYPopupView : UIView

/**
 *  @brief  需要上滑的View
 */
@property (nonatomic, strong, readonly) UIView *contentView;

/**
 *  @brief  content view showing.
 */
@property (nonatomic, assign, getter=isShowing) BOOL showing;

/**
 *  @brief  上滑显示View
 *
 *  @param contentView
 */
+ (void)show:(UIView *)contentView;

/**
 *  @brief  下滑隐藏View
 */
+ (void)hide;

@end
