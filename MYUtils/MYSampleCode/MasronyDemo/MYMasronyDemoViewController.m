//
//  MYMasronyDemoViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/15.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYMasronyDemoViewController.h"
#import <Masonry.h>

@interface MYMasronyDemoViewController ()

@property (nonatomic, strong) UIButton *customButton;
@property (nonatomic, assign) CGFloat scacle;

@end

@implementation MYMasronyDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [customButton setTitle:@"点我放大" forState:UIControlStateNormal];
    customButton.layer.borderColor = UIColor.greenColor.CGColor;
    customButton.layer.borderWidth = 3;
    [customButton addTarget:self action:@selector(customButtonEventClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton];
    self.customButton = customButton;
    self.scacle = 1.0;
    [customButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.view);
        make.width.height.mas_equalTo(100 * self.scacle);
        make.width.height.lessThanOrEqualTo(self.view);
    }];
}

- (void)customButtonEventClick:(UIButton *)sender {
    self.scacle += 1.0;
    // 告诉self.view约束需要更新
    [self.view setNeedsUpdateConstraints];
    // 调用此方法告诉self.view检测是否需要更新约束，若需要则更新，下面添加动画效果才起作用
    [self.view updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
}

#pragma mark - updateViewConstraints
// 重写该方法来更新约束
- (void)updateViewConstraints {
    [super updateViewConstraints];
    [self.customButton mas_updateConstraints:^(MASConstraintMaker *make) {
        // 这里写需要更新的约束，不用更新的约束将继续存在
        // 不会被取代，如：其宽高小于屏幕宽高不需要重新再约束
        make.width.height.mas_equalTo(100 * self.scacle);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
