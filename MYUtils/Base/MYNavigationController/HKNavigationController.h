//
//  HKNavigationController.h
//  FXVIP
//
//  Created by sunjinshuai on 2017/8/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HKWrapViewController : UIViewController

@property (nonatomic, strong, readonly) UIViewController *rootViewController;

+ (HKWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController;

@end

@interface HKNavigationController : UINavigationController

@property (nonatomic, strong) UIImage *backButtonImage;
@property (nonatomic, strong, readonly) NSArray *hk_viewControllers;

@end
