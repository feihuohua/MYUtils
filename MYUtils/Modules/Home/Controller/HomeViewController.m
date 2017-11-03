//
//  HomeViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "HomeViewController.h"
#import "MYShowTextViewController.h"
#import "MYIconFontViewController.h"
#import "MYImageCornerRadiusViewController.h"
#import "MYBannerCycleViewController.h"
#import "MYPagerViewController.h"
#import "MYCustomNavigationBarViewController.h"
#import "MYWebViewController.h"
#import "MYKeyboardViewController.h"
#import "MYCountDownViewController.h"
#import "MYAMViralSwitchViewController.h"
#import "MYTextFieldViewController.h"
#import "FXSliderViewController.h"
#import "MWPhotoBrowserDemo.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIKitDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:
                       @"UILabel设置行间距、指定显示行数",
                       @"iconfont实战",
                       @"imageView设置圆角",
                       @"轮播图",
                       @"TYPagerController",
                       @"CustomNavigationBar",
                       @"MYWebViewController",
                       @"keyboard",
                       @"倒计时演练",
                       @"自定义UISwitch",
                       @"自定义UITextField",
                       @"自定义UISlider",
                       @"照片浏览器",nil];
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
    
    if ([title isEqualToString:@"UILabel设置行间距、指定显示行数"]) {
        
        MYShowTextViewController *text = [[MYShowTextViewController alloc] init];
        [self.navigationController pushViewController:text animated:YES];
        
    } else if ([title isEqualToString:@"iconfont实战"]) {
        
        MYIconFontViewController *iconfont = [[MYIconFontViewController alloc] init];
        [self.navigationController pushViewController:iconfont animated:YES];
    } else if ([title isEqualToString:@"imageView设置圆角"]) {
        
        MYImageCornerRadiusViewController *cornerRadius = [[MYImageCornerRadiusViewController alloc] init];
        [self.navigationController pushViewController:cornerRadius animated:YES];
    } else if ([title isEqualToString:@"轮播图"]) {
        
        MYBannerCycleViewController *cycle = [[MYBannerCycleViewController alloc] init];
        [self.navigationController pushViewController:cycle animated:YES];
    } else if ([title isEqualToString:@"TYPagerController"]) {
        
        MYPagerViewController *pager = [[MYPagerViewController alloc] init];
        [self.navigationController pushViewController:pager animated:YES];
    } else if ([title isEqualToString:@"CustomNavigationBar"]) {
        MYCustomNavigationBarViewController *customNavigationBar = [[MYCustomNavigationBarViewController alloc] init];
        [self.navigationController pushViewController:customNavigationBar animated:YES];
    } else if ([title isEqualToString:@"MYWebViewController"]) {
    
        MYWebViewController *webViewController = [[MYWebViewController alloc] init];
        [self.navigationController pushViewController:webViewController animated:YES];
    } else if ([title isEqualToString:@"keyboard"]) {
    
        MYKeyboardViewController *keyboard = [[MYKeyboardViewController alloc] init];
        [self.navigationController pushViewController:keyboard animated:YES];
    } else if ([title isEqualToString:@"倒计时演练"]) {
        MYCountDownViewController *countDown = [[MYCountDownViewController alloc] init];
        [self.navigationController pushViewController:countDown animated:YES];
    } else if ([title isEqualToString:@"自定义UISwitch"]) {
    
        MYAMViralSwitchViewController *switchViewController = [[MYAMViralSwitchViewController alloc] init];
        [self.navigationController pushViewController:switchViewController animated:YES];
    } else if ([title isEqualToString:@"自定义UITextField"]) {
    
        MYTextFieldViewController *textField = [[MYTextFieldViewController alloc] init];
        [self.navigationController pushViewController:textField animated:YES];
    } else if ([title isEqualToString:@"自定义UISlider"]) {
    
        FXSliderViewController *slider = [[FXSliderViewController alloc] init];
        [self.navigationController pushViewController:slider animated:YES];
    } else if ([title isEqualToString:@"照片浏览器"]) {
        MWPhotoBrowserDemo *photoBrowser = [[MWPhotoBrowserDemo alloc] init];
        [self.navigationController pushViewController:photoBrowser animated:YES];
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
