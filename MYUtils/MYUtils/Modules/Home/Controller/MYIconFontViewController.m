//
//  MYIconFontViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYIconFontViewController.h"
#import "TBCityIconFont.h"
#import "UIImage+TBCityIconFont.h"

@interface MYIconFontViewController ()

@end

@implementation MYIconFontViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iconfont实战";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 150, 30, 30)];
    [self.view addSubview:imageView];
    imageView.image = [UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e603", 30, [UIColor redColor])];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(100, CGRectGetMaxY(imageView.frame) + 20, 40, 40);
    [self.view addSubview:button];
    [button setImage:[UIImage iconWithInfo:TBCityIconInfoMake(@"\U0000e60c", 40, [UIColor redColor])] forState:UIControlStateNormal];
    [button setTintColor:[UIColor greenColor]];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(button.frame) + 20, 280, 40)];
    [self.view addSubview:label];
    label.font = [UIFont fontWithName:@"iconfont" size:15];
    label.text = @"这是用label显示的iconfont  \U0000e60c";
}

@end
