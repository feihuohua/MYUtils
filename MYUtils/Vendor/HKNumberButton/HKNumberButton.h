//
//  HKNumberButton.h
//  FXVIP
//
//  Created by sunjinshuai on 2017/9/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HKNumberButton;

typedef void(^HKNumberButtonEditCompletion)(NSInteger number, BOOL increaseStatus);

@protocol HKNumberButtonDelegate <NSObject>

@optional

/**
 加减代理回调
 
 @param numberButton 按钮
 @param number 结果
 @param increaseStatus 是否为加状态
 */
- (void)numberButton:(HKNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus;

@end

@interface HKNumberButton : UIView

@property (nonatomic, copy) HKNumberButtonEditCompletion editCompletion;
@property (nonatomic, weak) id<HKNumberButtonDelegate> delegate;

/**
 是否开启抖动动画, default is NO
 */
@property (nonatomic, assign) BOOL shakeAnimation;

/**
 为YES时,初始化时减号按钮隐藏(饿了么/百度外卖/美团外卖按钮模式),default is NO
 */
@property (nonatomic, assign) BOOL decreaseHide;

/**
 是否可以使用键盘输入,default is YES
 */
@property (nonatomic, assign, getter=isEditing) BOOL editing;

/**
 设置边框的颜色,如果没有设置颜色,就没有边框
 */
@property (nonatomic, strong) UIColor *borderColor;

/**
 输入框中的内容
 */
@property (nonatomic, assign) NSInteger currentNumber;

/**
 输入框中的字体大小
 */
@property (nonatomic, assign) CGFloat inputFieldFont;

/**
 长按加减的时间间隔,默认0.1s,设置为 CGFLOAT_MAX 则关闭长按加减功能
 */
@property (nonatomic, assign) CGFloat longPressSpaceTime;

/**
 加减按钮的字体大小
 */
@property (nonatomic, assign) CGFloat buttonTitleFont;

/**
 加按钮背景图片
 */
@property (nonatomic, strong) UIImage *increaseImage;
/**
 减按钮背景图片
 */
@property (nonatomic, strong) UIImage *decreaseImage;

/**
 加按钮标题
 */
@property (nonatomic, copy) NSString *increaseTitle;

/**
 减按钮标题
 */
@property (nonatomic, copy) NSString *decreaseTitle;

/**
 最小值, default is 1
 */
@property (nonatomic, assign) NSInteger minValue;

/**
 最大值
 */
@property (nonatomic, assign) NSInteger maxValue;

@end

@interface NSString (NumberButton)
/**
 字符串 nil, @"", @"  ", @"\n" Returns NO;
 其他 Returns YES.
 */
- (BOOL)isNotBlank;
@end
