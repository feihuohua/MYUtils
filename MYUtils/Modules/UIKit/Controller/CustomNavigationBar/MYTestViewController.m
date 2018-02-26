//
//  MYTestViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYTestViewController.h"
#import "MYNavigaionBar.h"
#import "UtilsMacros.h"
#import <UIBarButtonItem+Extension.h>

@interface MYTestViewController ()

@property (nonatomic, strong) MYNavigaionBar *customNavBar;

@end

@implementation MYTestViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavBar];
}

- (void)setupNavBar {
    [self.view addSubview:self.customNavBar];
    
    // 设置自定义导航栏背景图片
    self.customNavBar.barBackgroundImage = [UIImage imageNamed:@"millcolorGrad"];
    
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
    [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"hk_navigation_back"]];
    
    weakSelf(self)
    self.customNavBar.onClickLeftButton = ^{
        [weakSelf didTapBackButton];
    };
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (MYNavigaionBar *)customNavBar
{
    if (_customNavBar == nil) {
        _customNavBar = [MYNavigaionBar CustomNavigationBar];
    }
    return _customNavBar;
}

@end
