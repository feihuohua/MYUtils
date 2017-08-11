//
//  UIView+Extension.h
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/7/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^GestureActionBlock)(UIGestureRecognizer *gestureRecoginzer);

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat bottom;

+ (UIViewController *)viewController:(UIView *)view;
+ (UINavigationController *)navigationController:(UIView *)view;

- (UIViewController *)viewController;

- (UINavigationController *)navigationController;

@end

NS_ASSUME_NONNULL_END
