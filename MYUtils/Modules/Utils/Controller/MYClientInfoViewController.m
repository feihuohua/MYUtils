//
//  MYClientInfoViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/4/9.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYClientInfoViewController.h"
#import "MYBasicViewController.h"

@interface MYClientInfoViewController ()

@end

@implementation MYClientInfoViewController

#pragma mark - Event Response
- (IBAction)hardWareInfoButtonTapped:(id)sender {
    [self _pushVCWithType:BasicInfoTypeHardWare sender:sender];
}

- (IBAction)batteryInfoButtonTapped:(id)sender {
    [self _pushVCWithType:BasicInfoTypeBattery sender:sender];
}

- (IBAction)addressInfoButtonTapped:(id)sender {
    [self _pushVCWithType:BasicInfoTypeIpAddress sender:sender];
}

- (IBAction)CPUInfoButtonTapped:(id)sender {
    [self _pushVCWithType:BasicInfoTypeCPU sender:sender];
}

- (IBAction)diskInfoButtonTapped:(id)sender {
    [self _pushVCWithType:BasicInfoTypeDisk sender:sender];
}

- (void)_pushVCWithType:(BasicInfoType)type sender:(UIButton *)sender {
    MYBasicViewController *basicVC = [[MYBasicViewController alloc] initWithType:type];
    basicVC.navigationItem.title = sender.titleLabel.text;
    [self.navigationController pushViewController:basicVC  animated:YES];
}

@end
