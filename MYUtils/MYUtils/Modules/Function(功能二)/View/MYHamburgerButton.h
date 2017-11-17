//
//  MYHamburgerButton.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, MYHamburgerButtonMode) {
    MYHamburgerButtonModeHamburger,
    MYHamburgerButtonModeArrow,
    MYHamburgerButtonModeCross
};

@interface MYHamburgerButton : UIButton

@property (nonatomic, assign) CGFloat lineHeight;
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, assign) CGFloat lineSpacing;
@property (nonatomic, assign) UIColor *lineColor;

@property (nonatomic, assign) CGFloat animationDuration;

@property (nonatomic, assign) MYHamburgerButtonMode currentMode;

- (void)setCurrentModeWithAnimation:(MYHamburgerButtonMode)currentMode;
- (void)setCurrentModeWithAnimation:(MYHamburgerButtonMode)currentMode duration:(CGFloat)duration;

- (void)updateAppearance;

@end
