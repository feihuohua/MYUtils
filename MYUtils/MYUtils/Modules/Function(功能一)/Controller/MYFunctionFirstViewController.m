//
//  MYFunctionFirstViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/16.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYFunctionFirstViewController.h"
#import "UtilsMacros.h"

@interface MYFunctionFirstViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MYFunctionFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIKitDemo";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.dataSource addObject:@"UILabel设置行间距、指定显示行数-MYShowTextViewController"];
    [self.dataSource addObject:@"iconfont实战-MYIconFontViewController"];
    [self.dataSource addObject:@"imageView设置圆角-MYImageCornerRadiusViewController"];
    [self.dataSource addObject:@"*轮播图-MYBannerCycleViewController"];
    [self.dataSource addObject:@"*照片浏览器-MWPhotoBrowserDemo"];
    [self.dataSource addObject:@"*自定义UISlider-FXSliderViewController"];
    [self.dataSource addObject:@"*自定义UITextField-MYTextFieldViewController"];
    [self.dataSource addObject:@"*自定义UISwitch-MYAMViralSwitchViewController"];
    [self.dataSource addObject:@"*倒计时演练-MYCountDownViewController"];
    [self.dataSource addObject:@"*keyboard-MYKeyboardViewController"];
    [self.dataSource addObject:@"*WebView实战-MYWebViewController"];
    [self.dataSource addObject:@"*自定义导航条-MYCustomNavigationBarViewController"];
    
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
    
    return 44.0f;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *title = [self.dataSource objectAtIndex:indexPath.row];
    NSString *className = [[title componentsSeparatedByString:@"-"] lastObject];
    
    UIViewController *viewController = [[NSClassFromString(className) alloc] init];
    viewController.title = [[title componentsSeparatedByString:@"-"] firstObject];
    
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSMutableArray *)dataSource {
    
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UITableView *)tableView {
    if (!_tableView) {
         _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, MYScreenWidth, MYScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.dataSource = self;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
            _tableView.scrollIndicatorInsets = _tableView.contentInset;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
