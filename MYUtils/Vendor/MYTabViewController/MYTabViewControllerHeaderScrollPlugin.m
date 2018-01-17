//
//  MYTabViewControllerHeaderScrollPlugin.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYTabViewControllerHeaderScrollPlugin.h"
#import "UIViewController+MYTabViewController.h"
#import "MYTabViewController.h"

@interface MYTabViewControllerHeaderScrollPlugin ()

@property (nonatomic, assign) NSInteger index;

@end

@implementation MYTabViewControllerHeaderScrollPlugin

- (void)removePlugin {
    [self removePanGestureForIndex:self.tabViewController.curIndex];
}

- (void)loadPlugin {
    [self addPanGestureForIndex:self.tabViewController.curIndex];
    self.index = self.tabViewController.curIndex;
}

- (void)scrollViewWillScrollFromIndex:(NSInteger)index offsetX:(CGFloat)contentOffsetX {
    self.index = index;
}

- (void)scrollViewDidScrollToIndex:(NSInteger)index {
    if (self.index == index) {
        return;
    }
    [self removePanGestureForIndex:self.index];
    [self addPanGestureForIndex:index];
    self.index = index;
}

#pragma mark -

- (void)addPanGestureForIndex:(NSInteger)index {
    UIViewController *vc = [self.tabViewController viewControllerForIndex:index];
    UIScrollView *tabContentScrollView = vc.tabContentScrollView;
    if (tabContentScrollView) {
        [self.tabViewController.view addGestureRecognizer:tabContentScrollView.panGestureRecognizer];
    }
}

- (void)removePanGestureForIndex:(NSInteger)index {
    UIViewController *vc = [self.tabViewController viewControllerForIndex:index];
    UIScrollView *tabContentScrollView = vc.tabContentScrollView;
    if (tabContentScrollView) {
        [self.tabViewController.view removeGestureRecognizer:tabContentScrollView.panGestureRecognizer];
    }
}

@end
