//
//  MYHeaderTabViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYHeaderTabViewController.h"
#import "MYHeaderTabViewBar.h"
#import "TableViewController.h"
#import "QMTabViewController.h"
#import "QMTabHeaderScrollViewPlugin.h"
#import "QMTabBarPlugin.h"

@interface MYHeaderTabViewController ()<QMTabViewControllerDataSource, QMTabViewControllerDelagate, MYHeaderTabViewBarDelegate>

@end

@implementation MYHeaderTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabDataSource = self;
    self.tabDelegate = self;
    self.headerZoomIn = NO;
    self.scrollEnabled = NO;
    MYHeaderTabViewBar *tabViewBar = [[MYHeaderTabViewBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, QMTabViewBarDefaultHeight)];
    tabViewBar.seperatorViewHidden = NO;

    tabViewBar.delegate = self;
    QMTabBarPlugin *tabViewBarPlugin = [[QMTabBarPlugin alloc] initWithTabViewBar:tabViewBar delegate:nil];
    [self enablePlugin:tabViewBarPlugin];
    
    [self enablePlugin:[QMTabHeaderScrollViewPlugin new]];
}

#pragma mark -

- (NSInteger)numberOfTabForTabViewBar:(MYHeaderTabViewBar *)tabViewBar {
    return [self numberOfViewControllerForTabViewController:self];
}

- (NSString *)tabViewBar:(MYHeaderTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    if (index == 0) {
        return @"d";
    }
    return @"网易云云网易云云网易云云";
}

- (void)tabViewBar:(MYHeaderTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    BOOL anim = labs(index - self.currentIndex) > 1 ? NO: YES;
    [self scrollToIndex:index animated:anim];
}

#pragma mark -

- (NSInteger)numberOfViewControllerForTabViewController:(QMTabViewController *)tabViewController {
    return 10;
}

- (UIViewController *)tabViewController:(QMTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
    TableViewController *vc = [TableViewController new];
    vc.index = index;
    return vc;
}

- (UIView *)tabHeaderViewForTabViewController:(QMTabViewController *)tabViewController {
    CGRect rect = CGRectMake(0, 0, 0, floor(300.0f));
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:rect];
    headerView.image = [UIImage imageNamed:@"1"];
    headerView.contentMode = UIViewContentModeScaleAspectFill;
    headerView.userInteractionEnabled = YES;
    return headerView;
}

- (CGFloat)tabHeaderBottomInsetForTabViewController:(QMTabViewController *)tabViewController {
    return QMTabViewBarDefaultHeight + CGRectGetMaxY(self.navigationController.navigationBar.frame);
}

- (UIEdgeInsets)containerInsetsForTabViewController:(QMTabViewController *)tabViewController {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
