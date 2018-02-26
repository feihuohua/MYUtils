//
//  HKTabBarControllerConfig.m
//  FXVIP
//
//  Created by sunjinshuai on 2017/8/15.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "HKTabBarControllerConfig.h"
#import "HKNavigationController.h"
#import "MYUIKitViewController.h"
#import "MYUtilsViewController.h"
#import "MYAnimationViewController.h"

@interface HKTabBarControllerConfig ()<UITabBarControllerDelegate>

@property (nonatomic, readwrite, strong) CYLTabBarController *tabBarController;

@end

@implementation HKTabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (!_tabBarController) {
        /**
         * 以下两行代码目的在于手动设置让TabBarItem只显示图标，不显示文字，并让图标垂直居中。
         * 等效于在 `-tabBarItemsAttributesForController` 方法中不传 `CYLTabBarItemTitle` 字段。
         * 更推荐后一种做法。
         */
        UIEdgeInsets imageInsets = UIEdgeInsetsZero;//UIEdgeInsetsMake(4.5, 0, -4.5, 0);
        UIOffset titlePositionAdjustment = UIOffsetZero;//UIOffsetMake(0, MAXFLOAT);
        
        CYLTabBarController *tabBarController = [CYLTabBarController tabBarControllerWithViewControllers:self.viewControllers
                                                                                   tabBarItemsAttributes:self.tabBarItemsAttributesForController
                                                                                             imageInsets:imageInsets
                                                                                 titlePositionAdjustment:titlePositionAdjustment];
        
        [self customizeTabBarAppearance:tabBarController];
        _tabBarController = tabBarController;
    }
    return _tabBarController;
}

- (NSArray *)viewControllers {
    
    MYUIKitViewController *firstViewController = [[MYUIKitViewController alloc] init];
    UIViewController *firstNavigationController = [[HKNavigationController alloc]
                                                   initWithRootViewController:firstViewController];
    
    
    MYUtilsViewController *secondViewController = [[MYUtilsViewController alloc] init];
    UIViewController *secondNavigationController = [[HKNavigationController alloc]
                                                   initWithRootViewController:secondViewController];
    
    MYAnimationViewController *thirdViewController = [[MYAnimationViewController alloc] init];
    UIViewController *thirdNavigationController = [[HKNavigationController alloc]
                                                    initWithRootViewController:thirdViewController];
  
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController
                                 ];
    return viewControllers;
}

- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"UIKit",
                                                 CYLTabBarItemImage : @"investment_normal",  /* NSString and UIImage are supported*/
                                                 CYLTabBarItemSelectedImage : @"investment_selected", /* NSString and UIImage are supported*/
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"Utils",
                                                  CYLTabBarItemImage : @"travel_normal",
                                                  CYLTabBarItemSelectedImage : @"travel_selected",
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"Animation",
                                                 CYLTabBarItemImage : @"myprofile_normal",
                                                 CYLTabBarItemSelectedImage : @"myprofile_selected",
                                                 };
    
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       ];
    return tabBarItemsAttributes;
}

/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性等等
 */
- (void)customizeTabBarAppearance:(CYLTabBarController *)tabBarController {

    // set the text color for unselected state
    // 普通状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    // set the text color for selected state
    // 选中状态下的文字属性
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    
    // set the text Attributes
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];

    // set the bar shadow image
    // This shadow image attribute is ignored if the tab bar does not also have a custom background image.So at least set somthing.
    [[UITabBar appearance] setBackgroundImage:[[UIImage alloc] init]];
    [[UITabBar appearance] setBackgroundColor:[UIColor whiteColor]];
    [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"tapbar_top_line"]];
}

@end
