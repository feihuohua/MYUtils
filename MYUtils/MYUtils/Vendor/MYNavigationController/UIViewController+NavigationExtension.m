//
//  UIViewController+NavigationExtension.m
//  FXVIP
//
//  Created by sunjinshuai on 2017/8/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UIViewController+NavigationExtension.h"
#import <objc/runtime.h>

@implementation UIViewController (NavigationExtension)

- (BOOL)enablePopGestureRecognizer {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setEnablePopGestureRecognizer:(BOOL)enablePopGestureRecognizer {
    objc_setAssociatedObject(self, @selector(enablePopGestureRecognizer), @(enablePopGestureRecognizer), OBJC_ASSOCIATION_RETAIN);
}

- (HKNavigationController *)hk_navigationController {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setHk_navigationController:(HKNavigationController *)hk_navigationController {
    objc_setAssociatedObject(self, @selector(hk_navigationController), hk_navigationController, OBJC_ASSOCIATION_RETAIN);
}

@end
