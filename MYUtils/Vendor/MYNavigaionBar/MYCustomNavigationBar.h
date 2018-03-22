//
//  MYCustomNavigationBar.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/3/22.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYCustomNavigationBar : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)customNavigationBar;

- (void)my_setBottomLineHidden:(BOOL)hidden;
- (void)my_setBackgroundAlpha:(CGFloat)alpha;
- (void)my_setTintColor:(UIColor *)color;

// 默认返回事件
- (void)my_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)my_setLeftButtonWithImage:(UIImage *)image;
- (void)my_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

- (void)my_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)my_setRightButtonWithImage:(UIImage *)image;
- (void)my_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

@end
