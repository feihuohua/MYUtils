//
//  MYCountDownViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/25.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYCountDownViewController.h"
#import "UIButton+CountDown.h"
#import "UILabel+CountDown.h"
#import <CIImage+Screenshot.h>
#import <NSMutableDictionary+ChainProgramming.h>
#import <NSMutableAttributedString+ChainProgramming.h>
#import "UIButton+Badge.h"
#import "UIBarButtonItem+Badge.h"
#import "UIButton+ImagePosition.h"

@interface MYCountDownViewController ()

@property (weak, nonatomic) IBOutlet UIButton *countdownButton;
@property (weak, nonatomic) IBOutlet UILabel *countdownLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *attributedLabel;
@property (weak, nonatomic) IBOutlet UIButton *topButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;

@end

@implementation MYCountDownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.countdownLabel scheduledTimerWithTimeInterval:5.0f title:@"重新发送" countDownTitle:@"秒后可重发" titleBackgroundColor:[UIColor blueColor] countDownTitleBackgroundColor:[UIColor lightGrayColor]];
    
    [self setupQRCodeImage];
    
    [self setupAttributedString];
    
    self.countdownButton.badgeValue = @"1";
    self.countdownButton.badgeFont = [UIFont systemFontOfSize:10.0f];
    self.countdownButton.badgePadding = 2.0f;
    
    
    UIImage *image2 = [UIImage imageNamed:@"houses_share_b"];
    UIBarButtonItem *navRightButton = [[UIBarButtonItem alloc] initWithImage:image2
                                                                       style:UIBarButtonItemStylePlain
                                                                      target:self
                                                                      action:@selector(insertNewObject:)];
    
    self.navigationItem.rightBarButtonItem = navRightButton;
    
    self.navigationItem.rightBarButtonItem.badgeValue = @"2";
    self.navigationItem.rightBarButtonItem.badgeBGColor = [UIColor redColor];
    self.navigationItem.rightBarButtonItem.badgePadding = 2.0f;
    self.navigationItem.rightBarButtonItem.badgeFont = [UIFont systemFontOfSize:10.0f];
    
    
    [self.topButton setImagePosition:MYImagePositionTop spacing:5.0f];
    [self.rightButton setImagePosition:MYImagePositionRight spacing:5.0f];
    [self.leftButton setImagePosition:MYImagePositionLeft spacing:5.0f];
    [self.bottomButton setImagePosition:MYImagePositionBottom spacing:5.0f];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    
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
    [self.countdownButton scheduledTimerWithTimeInterval:5.0f title:@"获取验证码" countDownTitle:@"s" titleBackgroundColor:[UIColor colorWithRed:84/255.0 green:180/255.0 blue:98/255.0 alpha:1.0f] countDownTitleBackgroundColor:[UIColor lightGrayColor]];
}

@end
