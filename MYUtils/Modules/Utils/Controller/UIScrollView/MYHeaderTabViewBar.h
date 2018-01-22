//
//  MYHeaderTabViewBar.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "QMTabViewBar.h"
@class MYHeaderTabViewBar;

typedef NS_ENUM(NSInteger, MYIndicatorStyle) {
    /// 下划线样式
    MYIndicatorStyleDefault,
    /// 遮盖样式
    MYIndicatorStyleCover,
};

@class MYHeaderTabViewBar;

@protocol MYHeaderTabViewBarDelegate <NSObject>

- (NSInteger)numberOfTabForTabViewBar:(MYHeaderTabViewBar *)tabViewBar;

- (NSString *)tabViewBar:(MYHeaderTabViewBar *)tabViewBar titleForIndex:(NSInteger)index;

@optional

- (void)tabViewBar:(MYHeaderTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index;

@end

@interface MYHeaderTabViewBar : QMTabViewBar

@property (nonatomic, weak) id<MYHeaderTabViewBarDelegate> delegate;

/**
 * 指示器样式，默认为 MYIndicatorStyleDefault
 */
@property (nonatomic, assign) MYIndicatorStyle indicatorStyle;

/**
 * 底部分割线隐藏，默认不显示
 */
@property (nonatomic, assign) BOOL seperatorViewHidden;

/**
 * 标题文字字号大小，默认 12 号字体
 */
@property (nonatomic, strong) UIFont *titleFont;

/**
 * 普通状态下标题按钮文字的颜色，默认为#666666
 */
@property (nonatomic, strong) UIColor *titleNormalColor;

/**
 * 选中状态下标题按钮文字的颜色，默认为#ed1c56
 */
@property (nonatomic, strong) UIColor *titleSelectedColor;

/**
 * 按钮之间的间距，默认为 12.0f
 */
@property (nonatomic, assign) CGFloat margin;

/**
 * 按钮的额外边距，默认为 12.0f
 */
@property (nonatomic, assign) CGFloat padding;

/**
 * 圆角大小，默认为 14.0f
 */
@property (nonatomic, assign) CGFloat cornerRadius;


@end
