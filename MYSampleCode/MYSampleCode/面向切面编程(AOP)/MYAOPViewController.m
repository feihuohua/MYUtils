//
//  MYAOPViewController.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/27.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "MYAOPViewController.h"
#import "TestClass+AOP.h"
#import "TestClass.h"

@interface MYAOPViewController ()

@end

@implementation MYAOPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(self.view.center.x - 50, self.view.center.y, 100, 50);
    [button addTarget:self action:@selector(tapPushButton) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitle:@"下一步" forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)tapPushButton {
    TestClass *testClass = [[TestClass alloc] init];
    [testClass method1];
}

@end
