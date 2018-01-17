//
//  MYTabViewControllerBottomInsetPlugin.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYTabViewControllerBottomInsetPlugin.h"
#import "UIViewController+MYTabViewController.h"
#import "MYTabViewController.h"
#import <objc/runtime.h>

@implementation UIScrollView (TabBottomInset)

- (CGFloat)tabBottomInset {
    return [objc_getAssociatedObject(self, @selector(tabBottomInset)) floatValue];
}

- (void)setTabBottomInset:(CGFloat)tabBottomInset {
    objc_setAssociatedObject(self, @selector(tabBottomInset), @(tabBottomInset), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

@implementation MYTabViewControllerBottomInsetPlugin

- (void)removePlugin {
    [self.tabViewController.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        UIScrollView *scrollView = viewController.tabContentScrollView;
        [scrollView removeObserver:self forKeyPath:@"contentSize"];
    }];
}

- (void)loadPlugin {
    if (!self.tabViewController.tabHeaderView) {
        return;
    }
    [self.tabViewController.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        UIScrollView *scrollView = viewController.tabContentScrollView;
        if (scrollView.tabBottomInset == 0 && scrollView.contentInset.bottom > 0) {
            scrollView.tabBottomInset = scrollView.contentInset.bottom;
        }
        if (scrollView) {
            [self autoFitBottomInset:scrollView];
            [scrollView addObserver:self forKeyPath:@"contentSize" options:NSKeyValueObservingOptionNew context:nil];
        }
    }];
}

- (void)observeValueForKeyPath:(nullable NSString *)keyPath ofObject:(nullable id)object change:(nullable NSDictionary<NSKeyValueChangeKey, id> *)change context:(nullable void *)context {
    if (![keyPath isEqualToString:@"contentSize"]) {
        return;
    }
    [self autoFitBottomInset:object];
}

- (void)autoFitBottomInset:(UIScrollView *)scrollView {
    CGFloat barHeight = 0;
    if ([self.tabViewController.tabDataSource respondsToSelector:@selector(tabHeaderBottomInsetForTabViewController:)]) {
        barHeight = [self.tabViewController.tabDataSource tabHeaderBottomInsetForTabViewController:self.tabViewController];
    }
    
    CGFloat minBottom = scrollView.contentSize.height + barHeight - CGRectGetHeight(scrollView.frame);
    if (minBottom >= 0) {
        if (scrollView.contentInset.bottom == scrollView.tabBottomInset) {
            return;
        }
        minBottom = scrollView.tabBottomInset;
    } else {
        minBottom = MAX(-minBottom, scrollView.tabBottomInset);
    }
    
    UIEdgeInsets insets = scrollView.contentInset;
    insets.bottom = minBottom;
    scrollView.contentInset = insets;
}

@end
