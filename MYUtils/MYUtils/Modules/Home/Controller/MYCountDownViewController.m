//
//  MYCountDownViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/25.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYCountDownViewController.h"
#import "UIButton+Extension.h"
#import "UILabel+FitLines.h"

@interface MYCountDownViewController ()

@property (weak, nonatomic) IBOutlet UIButton *countdownButton;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;

@end

@implementation MYCountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.countdownLabel scheduledTimerWithTimeInterval:3.0f countDownTitle:@"秒后讲自动跳转订单详情页" completion:^{
        NSLog(@"倒计时结束");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)countdownBtnClick:(UIButton *)sender {
    [self.countdownButton startWithTime:5 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithRed:84/255.0 green:180/255.0 blue:98/255.0 alpha:1.0f] countColor:[UIColor lightGrayColor]];
}


@end
