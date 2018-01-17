//
//  MYTabViewControllerTabViewBarPlugin.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYTabViewControllerTabViewBarPlugin.h"
#import "MYTabViewController.h"
#import "MYTabViewBar.h"

@interface MYTabViewControllerTabViewBarPlugin ()  {
    BOOL _loadFlag;
    NSInteger _tabCount;
    CGFloat _maxIndicatorX;
}

@property (nonatomic, weak) id<MYTabViewBarPluginDelagate> delegate;
@property (nonatomic, strong) MYTabViewBar *tabViewBar;

@end

@implementation MYTabViewControllerTabViewBarPlugin

- (instancetype)initWithTabViewBar:(MYTabViewBar *)tabViewBar
                          delegate:(id<MYTabViewBarPluginDelagate>)delegate {
    if (self = [super init]) {
        self.tabViewBar = tabViewBar;
        self.delegate = delegate;
    }
    return self;
}

- (void)removePlugin {
    [self.tabViewBar removeFromSuperview];
    _loadFlag = NO;
}

- (void)initPlugin {
    if (CGRectGetHeight(self.tabViewBar.frame) == 0) {
        self.tabViewBar.frame = CGRectMake(0, 0, 0, MYTabViewBarDefaultHeight);
    }
}

- (void)loadPlugin {
    _tabCount = [self.tabViewController.tabDataSource numberOfViewControllerForTabViewController:self.tabViewController];
    _maxIndicatorX = CGRectGetWidth(self.tabViewController.scrollView.frame) * (_tabCount - 1);
    
    [self layoutTabViewBar];
    [self.tabViewBar reloadTabBar];
    
    if ([self.delegate respondsToSelector:@selector(tabViewController:tabViewBarDidLoad:)]) {
        [self.delegate tabViewController:self.tabViewController tabViewBarDidLoad:self.tabViewBar];
    }
}

- (void)layoutTabViewBar {
    if (_loadFlag) {
        return;
    }
    _loadFlag = YES;
    CGFloat tabBarHeight = CGRectGetHeight(self.tabViewBar.frame);
    if (!self.tabViewController.tabHeaderView) {
        self.tabViewBar.frame = CGRectMake(0, 0, CGRectGetWidth(self.tabViewController.scrollView.frame), tabBarHeight);
        self.tabViewController.tabHeaderView = self.tabViewBar;
        return;
    }
    
    CGFloat tabBarFrameMinY = CGRectGetHeight(self.tabViewController.tabHeaderView.frame) - tabBarHeight;
    self.tabViewBar.frame = CGRectMake(0, tabBarFrameMinY, CGRectGetWidth(self.tabViewController.scrollView.frame), tabBarHeight);
    self.tabViewBar.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.tabViewController.tabHeaderView addSubview:self.tabViewBar];
}

#pragma mark -

- (void)scrollViewHorizontalScroll:(CGFloat)contentOffsetX {
    if ([self.tabViewBar respondsToSelector:@selector(tabScrollXOffset:)]) {
        [self.tabViewBar tabScrollXOffset:contentOffsetX];
    }
    CGFloat percent = contentOffsetX / _maxIndicatorX;
    if ([self.tabViewBar respondsToSelector:@selector(tabScrollXPercent:)]) {
        [self.tabViewBar tabScrollXPercent:percent];
    }
}

- (void)scrollViewDidScrollToIndex:(NSInteger)index {
    if ([self.tabViewBar respondsToSelector:@selector(tabDidScrollToIndex:)]) {
        [self.tabViewBar tabDidScrollToIndex:index];
    }
}

- (void)scrollViewWillScrollFromIndex:(NSInteger)index offsetX:(CGFloat)contentOffsetX {
    
    if ([self.tabViewBar respondsToSelector:@selector(tabWillScrollFromIndex:offsetX:)]) {
        [self.tabViewBar tabWillScrollFromIndex:index offsetX:contentOffsetX];
    }
}

@end
