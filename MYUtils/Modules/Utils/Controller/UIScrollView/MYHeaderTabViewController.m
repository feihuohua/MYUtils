//
//  MYHeaderTabViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYHeaderTabViewController.h"
#import "MYTabViewControllerTabViewBarPlugin.h"
#import "MYTabViewControllerHeaderScrollPlugin.h"
#import "MYHeaderTabViewBar.h"
#import "TableViewController.h"

@interface MYHeaderTabViewController ()<MYTabViewControllerDataSource, MYTabViewControllerDelagate, MYHeaderTabViewBarDelegate>

@end

@implementation MYHeaderTabViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabDataSource = self;
    self.tabDelegate = self;
    self.headerZoomIn = NO;
    self.scrollEnabled = NO;
    MYHeaderTabViewBar *tabViewBar = [[MYHeaderTabViewBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    tabViewBar.seperatorViewHidden = NO;
    tabViewBar.titleFont = [UIFont systemFontOfSize:18.0f];
//    tabViewBar.titleSelectedColor = [UIColor redColor];
//    tabViewBar.indicatorColor = [UIColor redColor];
//    tabViewBar.indicatorStyle = MYIndicatorStyleCover;
//    tabViewBar.indicatorColor = [UIColor lightGrayColor];
//    tabViewBar.indicatorCornerRadius = 5;
//    tabViewBar.indicatorAdditionalWidth = 10;
//    tabViewBar.indicatorHeight = 5;
    tabViewBar.delegate = self;
    MYTabViewControllerTabViewBarPlugin *tabViewBarPlugin = [[MYTabViewControllerTabViewBarPlugin alloc] initWithTabViewBar:tabViewBar delegate:nil];
    [self enablePlugin:tabViewBarPlugin];
    
    [self enablePlugin:[MYTabViewControllerHeaderScrollPlugin new]];
}

#pragma mark -

- (NSInteger)numberOfTabForTabViewBar:(MYHeaderTabViewBar *)tabViewBar {
    return [self numberOfViewControllerForTabViewController:self];
}

- (NSString *)tabViewBar:(MYHeaderTabViewBar *)tabViewBar titleForIndex:(NSInteger)index {
    if (index == 0) {
        return @"虾米";
    }
    return @"网易云asdfasdfasdf 5";
}

- (void)tabViewBar:(MYHeaderTabViewBar *)tabViewBar didSelectIndex:(NSInteger)index {
    BOOL anim = labs(index - self.curIndex) > 1 ? NO: YES;
    [self scrollToIndex:index animated:anim];
}

#pragma mark -

- (NSInteger)numberOfViewControllerForTabViewController:(MYTabViewController *)tabViewController {
    return 10;
}

- (UIViewController *)tabViewController:(MYTabViewController *)tabViewController viewControllerForIndex:(NSInteger)index {
    TableViewController *vc = [TableViewController new];
    vc.index = index;
    return vc;
}

- (UIView *)tabHeaderViewForTabViewController:(MYTabViewController *)tabViewController {
    CGRect rect = CGRectMake(0, 0, 0, floor(300.0f));
    UIImageView *headerView = [[UIImageView alloc] initWithFrame:rect];
    headerView.image = [UIImage imageNamed:@"1"];
    headerView.contentMode = UIViewContentModeScaleAspectFill;
    headerView.userInteractionEnabled = YES;
    return headerView;
}

- (CGFloat)tabHeaderBottomInsetForTabViewController:(MYTabViewController *)tabViewController {
    return MYTabViewBarDefaultHeight + CGRectGetMaxY(self.navigationController.navigationBar.frame);
}

- (UIEdgeInsets)containerInsetsForTabViewController:(MYTabViewController *)tabViewController {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

@end
