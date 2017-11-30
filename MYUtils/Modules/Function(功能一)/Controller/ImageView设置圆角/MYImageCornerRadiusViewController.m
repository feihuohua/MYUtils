//
//  MYImageCornerRadiusViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/9.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYImageCornerRadiusViewController.h"
#import "MYImageCornerRadiusViewCell.h"

@interface MYImageCornerRadiusViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MYImageCornerRadiusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"imageView设置圆角";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYImageCornerRadiusViewCell *cell = [MYImageCornerRadiusViewCell cellWithTableView:tableView];
    
    NSString *url = nil;
    switch (indexPath.row % 3) {
        case 0:
            url = @"http://bpic.588ku.com/element_origin_min_pic/16/08/25/1057be5924c75ed.jpg";
            break;
        case 1:
            url = @"http://bpic.588ku.com/element_origin_min_pic/20/16/01/2956ab736ea27c5.jpg";
            break;
        default:
            url = @"http://bpic.588ku.com//element_origin_min_pic/17/07/12/7d6c0bdb9d16da8b9e63bf0ae0aa531b.jpg";
            break;
    }
    cell.imageURL = url;
    cell.textLabel.text = @"imageView设置圆角";
    return cell;
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
