//
//  MYUtilsViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/2.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYUtilsViewController.h"
#import "UtilsMacros.h"
#import "CATLog.h"
#import <FLEX/FLEX.h>

@interface MYUtilsViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation MYUtilsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.dataSource addObject:@"*轮播图*-MYCyclePagerViewController"];
    [self.dataSource addObject:@"*照片浏览器*-MWPhotoBrowserDemo"];
    [self.dataSource addObject:@"*IconFont实战*-MYIconFontViewController"];
    [self.dataSource addObject:@"Keyboard-MYKeyboardViewController"];
    [self.dataSource addObject:@"*36氪*-MYPagerViewController"];
    [self.dataSource addObject:@"*UIScrollView嵌套UIScrollView问题*-MYHeaderTabViewController"];
    [self.dataSource addObject:@"*MYSoundServiceKit*-MYSoundServiceKitViewController"];
    [self.dataSource addObject:@"*消息弹出*-MYMessagesViewController"];
    [self.dataSource addObject:@"*iOS中获取各种设备信息*-MYClientInfoViewController"];
    
    [self registerViewControllerBasedOption];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"FLEX" style:UIBarButtonItemStylePlain target:self action:@selector(flexButtonTapped:)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"SHOWLOGFILE" style:UIBarButtonItemStylePlain target:self action:@selector(showLogFile)];
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

- (void)showLogFile {
    //    [CATLog showAllLogFile];
    [CATLog showTodayLogFile];
}

- (void)registerViewControllerBasedOption
{
    // create UIViewController subclass
    UIViewController *viewController = [[UIViewController alloc] init];
    
    // fill it with some stuff
    UILabel *infoLabel = [[UILabel alloc] init];
    infoLabel.translatesAutoresizingMaskIntoConstraints = NO;
    infoLabel.text = @"Add switches, notes or whatewer you wish to provide your testers with superpowers!";
    infoLabel.numberOfLines = 0;
    infoLabel.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = viewController.view;
    view.backgroundColor = [UIColor whiteColor];
    [view addSubview:infoLabel];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[infoLabel]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(infoLabel)]];
    
    [view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[infoLabel]-0-|"
                                                                 options:0
                                                                 metrics:nil
                                                                   views:NSDictionaryOfVariableBindings(infoLabel)]];
    
    
    
    // return it in viewControllerFutureBlock
    [[FLEXManager sharedManager] registerGlobalEntryWithName:@"🛃  Custom Superpowers"
                                   viewControllerFutureBlock:^id{
                                       return viewController;
                                   }];
}

- (void)flexButtonTapped:(id)sender {
    [[FLEXManager sharedManager] showExplorer];
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
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        }
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

@end
