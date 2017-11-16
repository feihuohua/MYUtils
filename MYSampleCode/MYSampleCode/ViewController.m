//
//  ViewController.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/15.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+CaculatorMaker.h"
#import "CaculatorMaker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int result = [NSObject makeCaculators:^(CaculatorMaker *make) {
        make.add(5).subtraction(1).muilt(2).divide(2);
    }];
    
    NSLog(@"结果是：%d",result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
