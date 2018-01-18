//
//  MYTabViewController.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYTabViewController;
@class MYTabViewControllerBasePlugin;

@protocol MYTabViewControllerDelagate <NSObject>

@optional

- (void)tabViewController:(MYTabViewController *)tabViewController scrollViewVerticalScroll:(CGFloat)contentPercentY;

- (void)tabViewController:(MYTabViewController *)tabViewController scrollViewHorizontalScroll:(CGFloat)contentOffsetX;

- (void)tabViewController:(MYTabViewController *)tabViewController scrollViewWillScrollFromIndex:(NSInteger)index offsetX:(CGFloat)contentOffsetX;

- (void)tabViewController:(MYTabViewController *)tabViewController scrollViewDidScrollToIndex:(NSInteger)index;

@end

@protocol MYTabViewControllerDataSource <NSObject>

@required

- (NSInteger)numberOfViewControllerForTabViewController:(MYTabViewController *)tabViewController;

- (UIViewController *)tabViewController:(MYTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index;

@optional

- (UIView *)tabHeaderViewForTabViewController:(MYTabViewController *)tabViewController;

- (CGFloat)tabHeaderBottomInsetForTabViewController:(MYTabViewController *)tabViewController;

- (UIEdgeInsets)containerInsetsForTabViewController:(MYTabViewController *)tabViewController;

@end

@interface MYTabViewController : UIViewController

@property (nonatomic, weak) id<MYTabViewControllerDataSource>  tabDataSource;
@property (nonatomic, weak) id<MYTabViewControllerDelagate>    tabDelegate;

// Default is YES when headerView not nil
@property (nonatomic, assign) BOOL headerZoomIn;
/**
 *  是否允许页面左右滑动，默认YES
 */
@property (nonatomic, assign, getter=isScrollEnabled) BOOL scrollEnabled;
@property (nonatomic, readonly) UIScrollView  *scrollView;
@property (nonatomic, readonly) NSArray       *viewControllers;
@property (nonatomic, strong)   UIView        *tabHeaderView;

@property (nonatomic, readonly) NSInteger  curIndex;

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated;

- (UIViewController *)viewControllerForIndex:(NSInteger)index;

- (void)reloadData;

/*
 Plugin
 */
- (void)enablePlugin:(MYTabViewControllerBasePlugin *)plugin;

- (void)removePlugin:(MYTabViewControllerBasePlugin *)plugin;

@end
