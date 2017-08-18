//
//  UIViewController+NavigationExtension.h
//  FXVIP
//
//  Created by sunjinshuai on 2017/8/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HKNavigationController.h"

@interface UIViewController (NavigationExtension)

@property (nonatomic, assign) BOOL enablePopGestureRecognizer;
@property (nonatomic, strong) HKNavigationController *hk_navigationController;

@end

