//
//  UIViewController+MYTabViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "UIViewController+MYTabViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (MYTabViewController)
@dynamic tabViewController, tabContentScrollView;

- (MYTabViewController *)tabViewController {
    return objc_getAssociatedObject(self, @selector(tabViewController));
}

- (void)setTabViewController:(MYTabViewController *)tabViewController {
    objc_setAssociatedObject(self, @selector(tabViewController), tabViewController, OBJC_ASSOCIATION_ASSIGN);
}

- (UIScrollView *)tabContentScrollView {
    UIScrollView *scrollView = objc_getAssociatedObject(self, @selector(tabContentScrollView));
    if (scrollView) {
        return scrollView;
    }
    if ([self.view isKindOfClass:[UIScrollView class]]) {
        [self setTabContentScrollView:(UIScrollView *)self.view];
    } else {
        for (UIScrollView *subview in self.view.subviews) {
            if ([subview isKindOfClass:[UIScrollView class]] && CGSizeEqualToSize(subview.frame.size, self.view.frame.size)) {
                [self setTabContentScrollView:subview];
                break;
            }
        }
    }
    return objc_getAssociatedObject(self, @selector(tabContentScrollView));
}

- (void)setTabContentScrollView:(UIScrollView *)tabContentScrollView {
    objc_setAssociatedObject(self, @selector(tabContentScrollView), tabContentScrollView, OBJC_ASSOCIATION_ASSIGN);
}

@end
