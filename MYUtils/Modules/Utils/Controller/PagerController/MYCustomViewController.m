//
//  MYCustomViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/3.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYCustomViewController.h"
#import "MYPagerViewController.h"

@interface MYCustomViewController ()

@property (nonatomic, weak) UILabel *label;
@property (nonatomic, weak) UIButton *pushBtn;
@property (nonatomic, weak) UIButton *cancelBtn;

@end

@implementation MYCustomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addPageLabel];
    [self addPushButton];
    [self addPopButton];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _label.center = CGPointMake(CGRectGetWidth(self.view.frame)/2, CGRectGetHeight(self.view.frame)/2);
    _cancelBtn.center = CGPointMake(_label.center.x,_label.center.y + 100);
    _pushBtn.center = CGPointMake(_label.center.x,_label.center.y + 50);
}

- (void)addPageLabel {
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
    label.text = _text;
    label.font = [UIFont systemFontOfSize:32];
    label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label];
    _label = label;
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0];
}

- (void)addPushButton {
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:21];
    [cancelBtn setTitle:@"posh VC" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(pushVC) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0, 0, 100, 40);
    cancelBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 60);
    [self.view addSubview:cancelBtn];
    _pushBtn = cancelBtn;
}

- (void)addPopButton {
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:21];
    [cancelBtn setTitle:@"pop back" forState:UIControlStateNormal];
    [cancelBtn addTarget:self action:@selector(popBack) forControlEvents:UIControlEventTouchUpInside];
    cancelBtn.frame = CGRectMake(0, 0, 100, 40);
    cancelBtn.center = CGPointMake(self.view.center.x, self.view.center.y + 60);
    [self.view addSubview:cancelBtn];
    _cancelBtn = cancelBtn;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear index %@",_text);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"viewDidAppear index %@",_text);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear index %@",_text);
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"viewDidDisappear index %@",_text);
}

- (void)pushVC {
    MYPagerViewController *vc = [[MYPagerViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)popBack {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
