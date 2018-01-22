//
//  UIViewController+QMTabViewController.m
//  QuanMinTV
//
//  Created by sunjinshuai on 2018/1/19.
//  Copyright © 2018年 QMTV. All rights reserved.
//

#import "UIViewController+QMTabViewController.h"
#import <objc/runtime.h>

@implementation UIViewController (QMTabViewController)
@dynamic tabViewController, tabContentScrollView;

- (QMTabViewController *)tabViewController {
    return objc_getAssociatedObject(self, @selector(tabViewController));
}

- (void)setTabViewController:(QMTabViewController *)tabViewController {
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
