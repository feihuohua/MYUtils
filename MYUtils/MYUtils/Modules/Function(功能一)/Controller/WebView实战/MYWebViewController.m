//
//  MYWebViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYWebViewController.h"
#import "MYJavaScriptCoreViewController.h"
#import "MYScriptMessageHandlerViewController.h"
#import "MYWebViewJavascriptBridgeViewController.h"

@interface MYWebViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MYWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"MYWebViewController";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataSource = [[NSMutableArray alloc] initWithObjects:
                       @"JavaScriptCore",
                       @"ScriptMessageHandler",
                       @"WebViewJavascriptBridge",nil];
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
    
    NSString *title = self.dataSource[indexPath.row];
    
    if ([title isEqualToString:@"JavaScriptCore"]) {
        
        MYJavaScriptCoreViewController *vc = [[MYJavaScriptCoreViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([title isEqualToString:@"ScriptMessageHandler"]) {
        
        MYScriptMessageHandlerViewController *vc = [[MYScriptMessageHandlerViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
        
    } else if ([title isEqualToString:@"WebViewJavascriptBridge"]) {
        
        MYWebViewJavascriptBridgeViewController *vc = [[MYWebViewJavascriptBridgeViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
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
