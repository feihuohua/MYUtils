//
//  QMTabHeaderScrollViewPlugin.m
//  QuanMinTV
//
//  Created by sunjinshuai on 2018/1/19.
//  Copyright © 2018年 QMTV. All rights reserved.
//

#import "QMTabHeaderScrollViewPlugin.h"
#import "UIViewController+QMTabViewController.h"
#import "QMTabViewController.h"

@interface QMTabHeaderScrollViewPlugin ()

@property (nonatomic, assign) NSInteger index;

@end

@implementation QMTabHeaderScrollViewPlugin

- (void)removePlugin {
    [self removePanGestureForIndex:self.tabViewController.currentIndex];
}

- (void)loadPlugin {
    [self addPanGestureForIndex:self.tabViewController.currentIndex];
    self.index = self.tabViewController.currentIndex;
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
