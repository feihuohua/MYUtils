//
//  MYPagerViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/16.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYPagerViewController.h"
#import "PagerViewDmeoController.h"
#import "PagerControllerDmeoController.h"
#import "TabPagerControllerDemoController.h"
#import "TabPagerViewDmeoController.h"

@interface MYPagerViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MYPagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MYPagerViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:
                       @"PagerViewDemo",
                       @"PagerControllerDemo",
                       @"TabPagerControllerDemo",
                       @"TabPagerViewDemo",nil];
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0.01f;
    }
    return 10.00f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = self.dataSource[indexPath.row];
    
    if ([title isEqualToString:@"PagerViewDemo"]) {
        
        PagerViewDmeoController *vc = [[PagerViewDmeoController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([title isEqualToString:@"PagerControllerDemo"]) {
        
        TabPagerViewDmeoController *vc = [[TabPagerViewDmeoController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    } else if ([title isEqualToString:@"TabPagerControllerDemo"]) {
        
        PagerControllerDmeoController *pagerController = [[PagerControllerDmeoController alloc] init];
        [self.navigationController pushViewController:pagerController animated:YES];
    } else if ([title isEqualToString:@"TabPagerViewDemo"]) {
        
        TabPagerControllerDemoController *pagerController = [[TabPagerControllerDemoController alloc] init];
        //pagerController.pagerController.layout.prefetchItemCount = 1;
        [self.navigationController pushViewController:pagerController animated:YES];
    }
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}


- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
