//
//  QMTabViewController.m
//  QuanMinTV
//
//  Created by sunjinshuai on 2018/1/19.
//  Copyright © 2018年 QMTV. All rights reserved.
//

#import "QMTabViewController.h"
#import "UIViewController+QMTabViewController.h"
#import "QMTabBaseViewPlugin.h"

@interface QMTabViewController () <UIScrollViewDelegate> {
    struct {
        CGFloat headHeight;
        CGFloat bottomInset;
        CGFloat minHeadFrameOriginY;
    } _headParameter;
    
    struct {
        BOOL tabViewLoadFlag;
        BOOL pluginsLoadFlag;
    } _loadParameter;
    
    CGFloat  _contentOffsetY;
    BOOL     _headViewScrollEnable;
    BOOL     _viewDidAppearIsCalledBefore;
}

/**
 *  containerView
 */
@property (nonatomic, strong) UIView           *containerView;
@property (nonatomic, strong) UIScrollView     *scrollView;
/**
 *  子控件
 */
@property (nonatomic, strong) NSArray          *viewControllers;
/**
 *  当前滑动的索引
 */
@property (nonatomic, assign) NSInteger        currentIndex;
@property (nonatomic, assign) NSInteger        showIndexAfterAppear;

@property (nonatomic, strong) NSMutableArray   *plugins;

@end

@implementation QMTabViewController

- (void)dealloc {
    [self removeKVOObserver];
    for (QMTabBaseViewPlugin *plugin in self.plugins.objectEnumerator) {
        [plugin removePlugin];
    }
    for (UIViewController *viewController in self.viewControllers.objectEnumerator) {
        viewController.tabViewController = nil;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.currentIndex != self.scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame)) {
        [self scrollViewDidEndDecelerating:self.scrollView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /// 加载containerView
    [self loadContainerView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self loadContentView];
    [self layoutSubViewWhenScrollViewFrameChange];
    if (self.showIndexAfterAppear > 0) {
        [self scrollToIndex:self.showIndexAfterAppear animated:NO];
        self.showIndexAfterAppear = 0;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_viewDidAppearIsCalledBefore) {
        _viewDidAppearIsCalledBefore = YES;
        [self viewDidScrollToIndex:self.currentIndex];
        if (_headViewScrollEnable) {
            [self tabDelegateScrollViewVerticalScroll:0];
        }
    }
}

#pragma mark - Action

- (UIViewController *)viewControllerForIndex:(NSInteger)index {
    if (index < 0 || index >= self.viewControllers.count) {
        return nil;
    }
    return self.viewControllers[index];
}

- (void)scrollToIndex:(NSInteger)index animated:(BOOL)animated {
    if (!_loadParameter.tabViewLoadFlag) {
        self.showIndexAfterAppear = index;
        return;
    }
    if (index < 0 || index >= self.viewControllers.count || index == self.currentIndex) {
        return;
    }
    [self enableCurScrollViewScrollToTop:NO];
    [self viewControllersAutoFitToScrollToIndex:index];
    if ([self.tabDelegate respondsToSelector:@selector(tabViewController:scrollViewWillScrollFromIndex:offsetX:)]) {
        [self.tabDelegate tabViewController:self scrollViewWillScrollFromIndex:self.currentIndex offsetX:self.scrollView.contentOffset.x];
    }
    [self.plugins enumerateObjectsUsingBlock:^(QMTabBaseViewPlugin *plugin, NSUInteger idx, BOOL *stop) {
        [plugin scrollViewWillScrollFromIndex:self.currentIndex offsetX:self.scrollView.contentOffset.x];
    }];
    [self.scrollView setContentOffset:CGPointMake(index * CGRectGetWidth(self.scrollView.bounds), 0) animated:animated];
    if (!animated) {
        [self scrollViewDidEndDecelerating:self.scrollView];
    }
}

- (void)enableCurScrollViewScrollToTop:(BOOL)enable {
    UIViewController *viewController = [self viewControllerForIndex:self.currentIndex];
    viewController.tabContentScrollView.scrollsToTop = enable;
}

- (void)viewControllersAutoFitToScrollToIndex:(NSInteger)index {
    if (index < 0 || index >= self.viewControllers.count) {
        return;
    }
    NSInteger minIndex = 0;
    NSInteger maxIndex = self.viewControllers.count;
    if (index < self.currentIndex) {
        minIndex = index;
        maxIndex = self.currentIndex - 1;
    } else {
        minIndex = self.currentIndex + 1;
        maxIndex = index;
    }
    for (NSInteger index = minIndex; index <= maxIndex; index++) {
        UIViewController *viewController = self.viewControllers[index];
        [self autoFitToViewController:viewController];
    }
}

- (void)autoFitToViewController:(UIViewController *)viewController {
    UIScrollView *scrollView = viewController.tabContentScrollView;
    if (!scrollView) {
        return;
    }
    CGFloat maxY = -MIN(CGRectGetMaxY(self.tabHeaderView.frame), _headParameter.headHeight);
    if (scrollView.contentOffset.y < maxY) {
        CGRect tempRect = self.tabHeaderView.frame;
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, maxY);
        self.tabHeaderView.frame = tempRect;
    }
    CGFloat minY = scrollView.contentSize.height - CGRectGetHeight(scrollView.frame);
    if (scrollView.contentOffset.y > minY) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, -CGRectGetMaxY(self.tabHeaderView.frame));
    }
}

#pragma mark - LoadView

- (void)reloadData {
    for (QMTabBaseViewPlugin *plugin in self.plugins.objectEnumerator) {
        [plugin removePlugin];
    }
    [self.tabHeaderView removeFromSuperview];
    self.tabHeaderView = nil;
    
    [self removeKVOObserver];
    for (UIViewController *viewController in self.viewControllers.objectEnumerator) {
        viewController.tabViewController = nil;
        [viewController.view removeFromSuperview];
    }
    self.viewControllers = nil;
    self.scrollView.contentOffset = CGPointZero;
    self.currentIndex = 0;
    _contentOffsetY = 0;
    _headViewScrollEnable = NO;
    
    _loadParameter.pluginsLoadFlag = NO;
    _loadParameter.tabViewLoadFlag = NO;
    [self loadContentView];
}

- (void)loadContentView {
    if (_loadParameter.tabViewLoadFlag) {
        return;
    }
    _loadParameter.tabViewLoadFlag = YES;
    [self layoutContainerView];
    [self loadViewControllersDateSource];
    [self loadHeadViewDateSource];
    [self loadPlugins];
    [self loadGeneralParam];
    [self loadControllerView];
    [self layoutHeaderView];
    [self layoutControllerView];
    [self enableCurScrollViewScrollToTop:YES];
    if (_headViewScrollEnable) {
        [self tabDelegateScrollViewVerticalScroll:0];
    }
}

- (void)loadViewControllersDateSource {
    NSInteger count = [self.tabDataSource numberOfViewControllerForTabViewController:self];
    NSMutableArray *viewControllers = [NSMutableArray arrayWithCapacity:count];
    for (NSInteger i = 0; i < count; i++) {
        UIViewController *vc = [self.tabDataSource tabViewController:self viewControllerForIndex:i];
        vc.automaticallyAdjustsScrollViewInsets = NO;
        [viewControllers addObject:vc];
    }
    self.viewControllers = viewControllers;
}

- (void)loadHeadViewDateSource {
    if ([self.tabDataSource respondsToSelector:@selector(tabHeaderViewForTabViewController:)]) {
        self.tabHeaderView = [self.tabDataSource tabHeaderViewForTabViewController:self];
        self.tabHeaderView.clipsToBounds = YES;
        _headViewScrollEnable = YES;
    }
}

- (void)loadGeneralParam {
    if ([self.tabDataSource respondsToSelector:@selector(tabHeaderBottomInsetForTabViewController:)]) {
        _headParameter.bottomInset = [self.tabDataSource tabHeaderBottomInsetForTabViewController:self];
    }
    if (self.tabHeaderView) {
        _headParameter.headHeight = CGRectGetHeight(self.tabHeaderView.frame);
    } else {
        _headParameter.headHeight = _headParameter.bottomInset;
    }
    _headParameter.minHeadFrameOriginY = -_headParameter.headHeight + _headParameter.bottomInset;
}

- (void)layoutContainerView {
    if (![self.tabDataSource respondsToSelector:@selector(containerInsetsForTabViewController:)]) {
        return;
    }
    UIEdgeInsets insets = [self.tabDataSource containerInsetsForTabViewController:self];
    self.containerView.frame = UIEdgeInsetsInsetRect(self.view.bounds, insets);
}

- (void)loadControllerView {
    NSInteger count = self.viewControllers.count;
    CGFloat width = CGRectGetWidth(self.scrollView.bounds);
    CGFloat height = CGRectGetHeight(self.scrollView.bounds);
    self.scrollView.contentSize = CGSizeMake(width * count, height);
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        viewController.view.frame = CGRectMake(width * idx, 0, width, height);
        viewController.tabViewController = self;
        
        UIScrollView *scrollView = viewController.tabContentScrollView;
        UIEdgeInsets inset = scrollView.contentInset;
        inset.top += _headParameter.headHeight;
        scrollView.contentInset = inset;
        scrollView.scrollIndicatorInsets = inset;
        scrollView.contentOffset = CGPointMake(0, -inset.top);
        scrollView.scrollsToTop = NO;
        if (@available(iOS 11.0, *)) {
            scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        [scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionOld context:nil];
    }];
}

- (void)layoutHeaderView {
    if (!self.tabHeaderView) {
        return;
    }
    self.tabHeaderView.clipsToBounds = YES;
    self.tabHeaderView.frame = CGRectMake(0, 0, CGRectGetWidth(self.containerView.bounds), _headParameter.headHeight);
    [self.containerView insertSubview:self.tabHeaderView aboveSubview:self.scrollView];
}

- (void)layoutControllerView {
    CGFloat width = CGRectGetWidth(self.scrollView.bounds);
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *childController, NSUInteger idx, BOOL *stop) {
        CGFloat pageOffsetForChild = idx * width;
        if (fabs(self.scrollView.contentOffset.x - pageOffsetForChild) < width) {
            if (!childController.parentViewController) {
                [childController willMoveToParentViewController:self];
                [self addChildViewController:childController];
                [childController beginAppearanceTransition:YES animated:YES];
                [self.scrollView addSubview:childController.view];
                [childController didMoveToParentViewController:self];
                if (_viewDidAppearIsCalledBefore) {
                    [childController endAppearanceTransition];
                }
                [self autoFitLayoutControllerView:childController];
            }
        } else {
            if (childController.parentViewController) {
                [childController willMoveToParentViewController:nil];
                [childController beginAppearanceTransition:NO animated:YES];
                [childController.view removeFromSuperview];
                [childController removeFromParentViewController];
                [childController endAppearanceTransition];
            }
        }
    }];
}

- (void)autoFitLayoutControllerView:(UIViewController *)viewController {
    UIScrollView *scrollView = viewController.tabContentScrollView;
    if (!scrollView) {
        return;
    }
    CGFloat maxY = -MIN(CGRectGetMaxY(self.tabHeaderView.frame), _headParameter.headHeight);
    if (scrollView.contentOffset.y < maxY) {
        scrollView.contentOffset = CGPointMake(scrollView.contentOffset.x, maxY);
    }
}

#pragma mark - VerticalScroll

- (void)removeKVOObserver {
    for (UIViewController *viewController in self.viewControllers) {
        @try {
            [viewController.tabContentScrollView removeObserver:self forKeyPath:@"contentOffset"];
        } @catch (NSException *exception) {
            
        } @finally {
            
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (![keyPath isEqualToString:@"contentOffset"]) {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        return;
    }
    if (!_headViewScrollEnable) {
        return;
    }
    UIViewController *viewController = self.viewControllers[self.currentIndex];
    UIScrollView *scrollView = viewController.tabContentScrollView;
    if (scrollView != object) {
        return;
    }
    CGFloat disY = _contentOffsetY - scrollView.contentOffset.y;
    _contentOffsetY = scrollView.contentOffset.y;
    if (disY > 0 && _contentOffsetY > -CGRectGetMaxY(self.tabHeaderView.frame)) {
        return;
    }
    CGRect headRect = self.tabHeaderView.frame;
    if (_contentOffsetY > -_headParameter.headHeight) {
        headRect.size.height = _headParameter.headHeight;
        headRect.origin.y += disY;
        headRect.origin.y = MIN(CGRectGetMinY(headRect), 0);
        headRect.origin.y = MAX(CGRectGetMinY(headRect), _headParameter.minHeadFrameOriginY);
        headRect.origin.y = MAX(CGRectGetMinY(headRect), -_contentOffsetY - _headParameter.headHeight);
    } else {
        headRect.origin.y = 0;
        headRect.size.height = self.headerZoomIn ? -scrollView.contentOffset.y : _headParameter.headHeight;
    }
    self.tabHeaderView.frame = headRect;
    
    CGFloat percent = 1;
    if (_headParameter.minHeadFrameOriginY != 0) {
        percent = MAX(0, CGRectGetMinY(headRect) / _headParameter.minHeadFrameOriginY);
        percent = MIN(1, percent);
    }
    [self tabDelegateScrollViewVerticalScroll:percent];
}

- (void)tabDelegateScrollViewVerticalScroll:(float)percent {
    if ([self.tabDelegate respondsToSelector:@selector(tabViewController:scrollViewVerticalScroll:)]) {
        [self.tabDelegate tabViewController:self scrollViewVerticalScroll:percent];
    }
    [self.plugins enumerateObjectsUsingBlock:^(QMTabBaseViewPlugin *plugin, NSUInteger idx, BOOL *stop) {
        [plugin scrollViewVerticalScroll:percent];
    }];
}

#pragma mark - HorizontalScroll

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self enableCurScrollViewScrollToTop:NO];
    [self viewControllersAutoFitToScrollToIndex:self.currentIndex - 1];
    [self viewControllersAutoFitToScrollToIndex:self.currentIndex + 1];
    if ([self.tabDelegate respondsToSelector:@selector(tabViewController:scrollViewWillScrollFromIndex:offsetX:)]) {
        [self.tabDelegate tabViewController:self scrollViewWillScrollFromIndex:self.currentIndex offsetX:scrollView.contentOffset.x];
    }
    [self.plugins enumerateObjectsUsingBlock:^(QMTabBaseViewPlugin *plugin, NSUInteger idx, BOOL *stop) {
        [plugin scrollViewWillScrollFromIndex:self.currentIndex offsetX:scrollView.contentOffset.x];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self layoutControllerView];
    if ([self.tabDelegate respondsToSelector:@selector(tabViewController:scrollViewHorizontalScroll:)]) {
        [self.tabDelegate tabViewController:self scrollViewHorizontalScroll:scrollView.contentOffset.x];
    }
    [self.plugins enumerateObjectsUsingBlock:^(QMTabBaseViewPlugin *plugin, NSUInteger idx, BOOL *stop) {
        [plugin scrollViewHorizontalScroll:scrollView.contentOffset.x];
    }];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [self scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.currentIndex = scrollView.contentOffset.x / CGRectGetWidth(self.scrollView.frame);
    UIViewController *viewController = [self viewControllerForIndex:self.currentIndex];
    UIScrollView *curScrollView = viewController.tabContentScrollView;
    UIEdgeInsets insets = curScrollView.contentInset;
    CGFloat maxY = insets.bottom + curScrollView.contentSize.height - curScrollView.bounds.size.height;
    if (curScrollView.contentOffset.y > maxY) {
        [curScrollView setContentOffset:CGPointMake(0, -insets.top) animated:YES];
    }
    _contentOffsetY = curScrollView.contentOffset.y;
    if (@available(iOS 11.0, *)) {
        if (_contentOffsetY < 0 && _contentOffsetY < -CGRectGetMaxY(self.tabHeaderView.frame)) {
            [self observeValueForKeyPath:@"contentOffset" ofObject:curScrollView change:nil context:nil];
        }
    }
    [self enableCurScrollViewScrollToTop:YES];
    [self viewDidScrollToIndex:self.currentIndex];
}

- (void)viewDidScrollToIndex:(NSInteger)index {
    if ([self.tabDelegate respondsToSelector:@selector(tabViewController:scrollViewDidScrollToIndex:)]) {
        [self.tabDelegate tabViewController:self scrollViewDidScrollToIndex:index];
    }
    [self.plugins enumerateObjectsUsingBlock:^(QMTabBaseViewPlugin *plugin, NSUInteger idx, BOOL *stop) {
        [plugin scrollViewDidScrollToIndex:index];
    }];
}

#pragma mark - Plugin

- (void)loadPlugins {
    [self.plugins enumerateObjectsUsingBlock:^(QMTabBaseViewPlugin *plugin, NSUInteger idx, BOOL *stop) {
        [plugin loadPlugin];
    }];
    _loadParameter.pluginsLoadFlag = YES;
}

- (void)enablePlugin:(QMTabBaseViewPlugin *)plugin {
    if (!self.plugins) {
        self.plugins = [NSMutableArray new];
    }
    [self.plugins enumerateObjectsUsingBlock:^(QMTabBaseViewPlugin *existPlugin, NSUInteger idx, BOOL *stop) {
        if ([existPlugin isMemberOfClass:[plugin class]]) {
            [existPlugin removePlugin];
            [self.plugins removeObject:existPlugin];
            *stop = YES;
        }
    }];
    [self.plugins addObject:plugin];
    plugin.tabViewController = self;
    [plugin initPlugin];
    if (_loadParameter.pluginsLoadFlag) {
        [plugin loadPlugin];
    }
}

- (void)removePlugin:(QMTabBaseViewPlugin *)plugin {
    [plugin removePlugin];
    plugin.tabViewController = nil;
    [self.plugins removeObject:plugin];
}

#pragma mark -

- (void)setViewControllers:(NSArray *)viewControllers {
    if ((!_viewControllers && !viewControllers)
        || [_viewControllers isEqualToArray:viewControllers]) {
        return;
    }
    _viewControllers = viewControllers;
}

/**
 *  加载containerView
 */
- (void)loadContainerView {
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.headerZoomIn = YES;
    
    self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.containerView.backgroundColor = [UIColor clearColor];
    self.containerView.clipsToBounds = YES;
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:self.containerView];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.containerView.bounds];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.directionalLockEnabled = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.delegate = self;
    self.scrollView.scrollsToTop = NO;
    self.scrollView.delaysContentTouches = NO;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [self.containerView addSubview:self.scrollView];
}

- (void)layoutSubViewWhenScrollViewFrameChange {
    if (CGRectGetHeight(self.scrollView.frame) == self.scrollView.contentSize.height) {
        return;
    }
    NSInteger count = self.viewControllers.count;
    CGFloat width = CGRectGetWidth(self.scrollView.bounds);
    CGFloat height = CGRectGetHeight(self.scrollView.bounds);
    self.scrollView.contentSize = CGSizeMake(width * count, height);
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
        viewController.view.frame = CGRectMake(width * idx, 0, width, height);
    }];
}

- (void)setScrollEnabled:(BOOL)scrollEnabled {
    _scrollEnabled = scrollEnabled;
    self.scrollView.scrollEnabled = scrollEnabled;
}

@end
