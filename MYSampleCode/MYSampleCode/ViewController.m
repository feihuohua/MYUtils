//
//  ViewController.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/15.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+CaculatorMaker.h"
#import "UITableView+Chain.h"
#import "CaculatorMaker.h"
#import "MYTableViewHelper.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    int result = [NSObject makeCaculators:^(CaculatorMaker *make) {
//        make.add(5).subtraction(1).muilt(2).divide(2);
//    }];
//
//    NSLog(@"结果是：%d",result);
    
//    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
//    [tableView makeConfigure:^(MYTableViewHelper *helper) {
//        helper.bindTb(tableView, [UITableViewCell class]).totalSection(1).section(0).row(10).configureCell(@[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"]);
//    }];
//    [self.view addSubview:tableView];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
