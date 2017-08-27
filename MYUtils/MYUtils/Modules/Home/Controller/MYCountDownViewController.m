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
#import "CIImage+Extension.h"
#import "NSMutableDictionary+Extension.h"
#import "NSMutableAttributedString+Extension.h"

@interface MYCountDownViewController ()

@property (weak, nonatomic) IBOutlet UIButton *countdownButton;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *attributedLabel;

@end

@implementation MYCountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.countdownLabel scheduledTimerWithTimeInterval:3.0f countDownTitle:@"秒后讲自动跳转订单详情页" completion:^{
        NSLog(@"倒计时结束");
    }];
    
    [self setupQRCodeImage];
    
    [self setupAttributedString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupAttributedString {
    //【常用方式】
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc]initWithString:@"3秒后自动跳转订单详情页"];
    [attributedStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16.0] range:NSMakeRange(2, 2)];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 2)];
//    self.attributedLabel.attributedText = attributedStr;
    
    //【封装工具类】
    NSMutableAttributedString *attributedString = [NSMutableAttributedString makeAttributeString:@"3秒后跳转" attribute:^(NSMutableDictionary *attributes) {
        attributes.font(24).color([UIColor redColor]);
    }];
    [attributedString makeAttributeStringAdd:@"订单详情页" attribute:^(NSMutableDictionary *attributes) {
        attributes.font(12).color([UIColor blueColor]);
    }];
    self.attributedLabel.attributedText = attributedString;
}

- (void)setupQRCodeImage {
    // 1.创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 2.恢复默认设置
    [filter setDefaults];
    
    // 3.设置数据
    NSString *info = @"https://www.baidu.com";
    NSData *infoData = [info dataUsingEncoding:NSUTF8StringEncoding];
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    // 4.生成二维码
    CIImage *outputImage = [filter outputImage];
    self.imageView.image = [outputImage createNonInterpolatedWithSize:self.imageView.bounds.size.width];
}

- (IBAction)countdownBtnClick:(UIButton *)sender {
    [self.countdownButton startWithTime:5 title:@"获取验证码" countDownTitle:@"s" mainColor:[UIColor colorWithRed:84/255.0 green:180/255.0 blue:98/255.0 alpha:1.0f] countColor:[UIColor lightGrayColor]];
}

@end
