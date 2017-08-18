//
//  MYTabBarController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYTabBarController.h"
#import "HKNavigationController.h"
#import "HomeViewController.h"

@interface MYTabBarController ()

@end

@implementation MYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeViewController *home = [[HomeViewController alloc] init];
    [self setupChildsViewController:home title:@"首页" imageName:@"" seleceImageName:@""];
}

- (void)setupChildsViewController:(UIViewController *)childsController title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName {
    
    childsController.tabBarItem.title = title;
    childsController.tabBarItem.image = [UIImage imageNamed:imageName];
    childsController.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    HKNavigationController *nav = [[HKNavigationController alloc] initWithRootViewController:childsController];
    childsController.title = title;
    [self addChildViewController:nav];
}

@end
