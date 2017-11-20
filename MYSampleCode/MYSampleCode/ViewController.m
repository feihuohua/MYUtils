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
#import "MYScrollView.h"

@interface ViewController ()

@property (nonatomic, strong) MYScrollView *scrollView;

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
  
    self.scrollView = [[MYScrollView alloc] initWithFrame:self.view.bounds];
    self.scrollView.scrollHorizontal = NO;
    
    UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(20, 20, 100, 100)];
    UIView *greenView = [[UIView alloc] initWithFrame:CGRectMake(150, 160, 150, 200)];
    UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(40, 400, 200, 150)];
    UIView *yellowView = [[UIView alloc] initWithFrame:CGRectMake(100, 600, 180, 150)];
    
    redView.backgroundColor = [UIColor colorWithRed:0.815 green:0.007 blue:0.105 alpha:1];
    greenView.backgroundColor = [UIColor colorWithRed:0.494 green:0.827 blue:0.129 alpha:1];
    blueView.backgroundColor = [UIColor colorWithRed:0.29 green:0.564 blue:0.886 alpha:1];
    yellowView.backgroundColor = [UIColor colorWithRed:0.972 green:0.905 blue:0.109 alpha:1];
    
    [self.scrollView addSubview:redView];
    [self.scrollView addSubview:greenView];
    [self.scrollView addSubview:blueView];
    [self.scrollView addSubview:yellowView];
    
    
    
    UIView *redView1 = [[UIView alloc] initWithFrame:CGRectMake(20, 500+20, 100, 100)];
    UIView *greenView1 = [[UIView alloc] initWithFrame:CGRectMake(150, 500+160, 150, 200)];
    UIView *blueView1 = [[UIView alloc] initWithFrame:CGRectMake(40, 500+400, 200, 150)];
    UIView *yellowView1 = [[UIView alloc] initWithFrame:CGRectMake(100, 500+600, 180, 150)];
    
    redView1.backgroundColor = [UIColor purpleColor];
    greenView1.backgroundColor = [UIColor redColor];
    blueView1.backgroundColor = [UIColor grayColor];
    yellowView1.backgroundColor = [UIColor blackColor];
    
    [self.scrollView addSubview:redView1];
    [self.scrollView addSubview:greenView1];
    [self.scrollView addSubview:blueView1];
    [self.scrollView addSubview:yellowView1];
    
    self.scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, CGRectGetMaxY(yellowView1.frame));
    [self.view addSubview:self.scrollView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
