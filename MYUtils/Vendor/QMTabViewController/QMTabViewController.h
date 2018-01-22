//
//  QMTabViewController.h
//  QuanMinTV
//
//  Created by sunjinshuai on 2018/1/19.
//  Copyright © 2018年 QMTV. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QMTabViewController;
@class QMTabBaseViewPlugin;

@protocol QMTabViewControllerDelagate <NSObject>

@optional

- (void)tabViewController:(QMTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY;

- (void)tabViewController:(QMTabViewController *)tabViewController scrollViewHorizontalScroll:(CGFloat)contentOffsetX;

- (void)tabViewController:(QMTabViewController *)tabViewController scrollViewWillScrollFromIndex:(NSInteger)index offsetX:(CGFloat)contentOffsetX;

- (void)tabViewController:(QMTabViewController *)tabViewController scrollViewDidScrollToIndex:(NSInteger)index;

@end

@protocol QMTabViewControllerDataSource <NSObject>

@required

- (NSInteger)numberOfViewControllerForTabViewController:(QMTabViewController *)tabViewController;

- (UIViewController *)tabViewController:(QMTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index;

@optional

- (UIView *)tabHeaderViewForTabViewController:(QMTabViewController *)tabViewController;

- (CGFloat)tabHeaderBottomInsetForTabViewController:(QMTabViewController *)tabViewController;

- (UIEdgeInsets)containerInsetsForTabViewController:(QMTabViewController *)tabViewController;

@end

@interface QMTabViewController : UIViewController

@property (nonatomic, weak) id<QMTabViewControllerDataSource>  tabDataSource;
@property (nonatomic, weak) id<QMTabViewControllerDelagate>    tabDelegate;

/**
 *  是否允许header放大suo'xiao，默认YES
 */
@property (nonatomic, assign) BOOL headerZoomIn;

/**
 *  是否允许页面左右滑动，默认YES
 */
@property (nonatomic, assign, getter=isScrollEnabled) BOOL scrollEnabled;
@property (nonatomic, readonly) UIScrollView  *scrollView;
@property (nonatomic, readonly) NSArray       *viewControllers;

/**
 *  tabHeaderView
 */
@property (nonatomic, strong)   UIView        *tabHeaderView;

/**
 *  当前滑动的索引
 */
@property (nonatomic, readonly) NSInteger  currentIndex;

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

- (UIViewController *)viewControllerForIndex:(NSInteger)index;

- (void)reloadData;

/*
 Plugin
 */
- (void)enablePlugin:(QMTabBaseViewPlugin *)plugin;

- (void)removePlugin:(QMTabBaseViewPlugin *)plugin;

@end
