//
//  MYNavigaionBar.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/2/26.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYNavigaionBar : UIView

@property (nonatomic, copy) void(^onClickLeftButton)(void);
@property (nonatomic, copy) void(^onClickRightButton)(void);

@property (nonatomic, copy)   NSString *title;
@property (nonatomic, strong) UIColor  *titleLabelColor;
@property (nonatomic, strong) UIFont   *titleLabelFont;
@property (nonatomic, strong) UIColor  *barBackgroundColor;
@property (nonatomic, strong) UIImage  *barBackgroundImage;

+ (instancetype)CustomNavigationBar;

- (void)wr_setBottomLineHidden:(BOOL)hidden;
- (void)wr_setBackgroundAlpha:(CGFloat)alpha;
- (void)wr_setTintColor:(UIColor *)color;

// 默认返回事件
//- (void)wr_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)wr_setLeftButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)wr_setLeftButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)wr_setLeftButtonWithImage:(UIImage *)image;
- (void)wr_setLeftButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;

//- (void)wr_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted title:(NSString *)title titleColor:(UIColor *)titleColor;
//- (void)wr_setRightButtonWithImage:(UIImage *)image title:(NSString *)title titleColor:(UIColor *)titleColor;
- (void)wr_setRightButtonWithNormal:(UIImage *)normal highlighted:(UIImage *)highlighted;
- (void)wr_setRightButtonWithImage:(UIImage *)image;
- (void)wr_setRightButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor;



@end