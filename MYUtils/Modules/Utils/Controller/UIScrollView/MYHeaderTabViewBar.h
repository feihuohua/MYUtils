//
//  MYHeaderTabViewBar.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYTabViewBar.h"
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

- (id)tabViewBar:(MYHeaderTabViewBar *)tabViewBar titleForIndex:(NSInteger)index;

@optional

- (void)tabViewBar:(MYHeaderTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index;

@end

@interface MYHeaderTabViewBar : MYTabViewBar

@property (nonatomic, weak) id<MYHeaderTabViewBarDelegate> delegate;

/** 标题文字字号大小，默认 14 号字体 */
@property (nonatomic, strong) UIFont *titleFont;
/** 普通状态下标题按钮文字的颜色，默认为灰色 */
@property (nonatomic, strong) UIColor *titleNormalColor;
/** 选中状态下标题按钮文字的颜色，默认为蓝色 */
@property (nonatomic, strong) UIColor *titleSelectedColor;
/** 指示器颜色，默认为蓝色 */
@property (nonatomic, strong) UIColor *indicatorColor;
/** 按钮之间的间距，默认为 20.0f */
@property (nonatomic, assign) CGFloat itemSpacing;
/** 指示器样式，默认为 HJIndicatorStyleDefault */
@property (nonatomic, assign) MYIndicatorStyle indicatorStyle;
/** 指示器高度，默认为 2.0f */
@property (nonatomic, assign) CGFloat indicatorHeight;
/** 指示器遮盖样式下的圆角大小，默认为 0.1f */
@property (nonatomic, assign) CGFloat indicatorCornerRadius;
/** 指示器遮盖样式下的边框宽度，默认为 0.0f */
@property (nonatomic, assign) CGFloat indicatorBorderWidth;
/** 指示器遮盖样式下的边框颜色，默认为 clearColor */
@property (nonatomic, strong) UIColor *indicatorBorderColor;
/** 指示器的额外宽度，介于按钮文字宽度与按钮宽度之间 */
@property (nonatomic, assign) CGFloat indicatorAdditionalWidth;
/** 底部分割线隐藏，默认显示 */
@property (nonatomic, assign) BOOL seperatorViewHidden;

@end
