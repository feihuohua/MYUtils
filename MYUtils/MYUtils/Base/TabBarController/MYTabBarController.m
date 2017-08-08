//
//  MYTabBarController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYTabBarController.h"
#import "MYNavigationController.h"
#import "ViewController.h"

@interface MYTabBarController ()

@end

@implementation MYTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ViewController *vc = [[ViewController alloc] init];
    [self setupChildsViewController:vc title:@"首页" imageName:@"" seleceImageName:@""];
}

- (void)setupChildsViewController:(UIViewController *)childsController title:(NSString *)title imageName:(NSString *)imageName seleceImageName:(NSString *)selectImageName {
    
    childsController.tabBarItem.title = title;//跟上面一样效果
    childsController.tabBarItem.image = [UIImage imageNamed:imageName];
    childsController.tabBarItem.selectedImage = [UIImage imageNamed:selectImageName];
    MYNavigationController *nav = [[MYNavigationController alloc] initWithRootViewController:childsController];
    childsController.title = title;
    [self addChildViewController:nav];
}

@end
