//
//  MYCustomNavigationBarViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/2.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYCustomNavigationBarViewController.h"
#import "WRNavigationBar.h"
#import "UtilsMacros.h"
#import "MYTestViewController.h"
#import <Masonry.h>

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT*2)
#define IMAGE_HEIGHT 220
#define NAV_HEIGHT 64

@interface MYCustomNavigationBarViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIImageView *topView;
@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *fansLabel;
@property (nonatomic, strong) UILabel *detailsLabel;

@end

@implementation MYCustomNavigationBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    self.title = @"";
    [self.view addSubview:self.tableView];
    [self.topView addSubview:self.iconView];
    self.iconView.center = CGPointMake(self.topView.center.x, self.topView.center.y - 10);
    [self.topView addSubview:self.nameLabel];
    self.nameLabel.frame = CGRectMake(0, self.iconView.frame.size.height + self.iconView.frame.origin.y + 6, self.view.frame.size.width, 19);
    [self.topView addSubview:self.fansLabel];
    self.fansLabel.frame = CGRectMake(0, self.nameLabel.frame.origin.y + 19 + 5, self.view.frame.size.width, 16);
    [self.topView addSubview:self.detailsLabel];
    self.detailsLabel.frame = CGRectMake(0, self.fansLabel.frame.origin.y + 16 + 5, self.view.frame.size.width, 15);
    self.tableView.tableHeaderView = self.topView;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"··· " style:UIBarButtonItemStyleDone target:self action:nil];
    
    // 设置导航栏颜色
    [self wr_setNavBarBarTintColor:[UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0]];
    
    // 设置初始导航栏透明度
    [self wr_setNavBarBackgroundAlpha:0];
    
    // 设置导航栏按钮和标题颜色
    [self wr_setNavBarTintColor:[UIColor whiteColor]];
    
    [self wr_setNavBarShadowImageHidden:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT) {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self wr_setNavBarTintColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setNavBarTitleColor:[[UIColor blackColor] colorWithAlphaComponent:alpha]];
        [self wr_setStatusBarStyle:UIStatusBarStyleDefault];
        self.title = @"自定义导航栏";
    } else {
        [self wr_setNavBarBackgroundAlpha:0];
        [self wr_setNavBarTintColor:[UIColor whiteColor]];
        [self wr_setNavBarTitleColor:[UIColor whiteColor]];
        [self wr_setStatusBarStyle:UIStatusBarStyleLightContent];
        self.title = @"";
    }
}


#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    NSString *str = [NSString stringWithFormat:@"MYNavigationBar %zd",indexPath.row];
    cell.textLabel.text = str;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MYTestViewController *test = [MYTestViewController new];
    
    test.title = [NSString stringWithFormat:@"MYNavigationBar %zd",indexPath.row];;
    [self.navigationController pushViewController:test animated:YES];
}

#pragma mark - getter / setter
- (UITableView *)tableView {
    if (!_tableView) {
        CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.contentInset = UIEdgeInsetsMake(-[self navBarBottom], 0, 0, 0);
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIImageView *)topView {
    if (!_topView) {
        _topView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wbBG"]];
        _topView.frame = CGRectMake(0, 0, self.view.frame.size.width, IMAGE_HEIGHT);
    }
    return _topView;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
        _iconView.bounds = CGRectMake(0, 0, 80, 80);
        _iconView.layer.cornerRadius = 40;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [UILabel new];
        _nameLabel.backgroundColor = [UIColor clearColor];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.text = @"自定义导航栏";
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabel;
}

- (UILabel *)fansLabel {
    if (!_fansLabel) {
        _fansLabel = [UILabel new];
        _fansLabel.backgroundColor = [UIColor clearColor];
        _fansLabel.textColor = [UIColor whiteColor];
        _fansLabel.text = @"关注 121  |  粉丝 117";
        _fansLabel.textAlignment = NSTextAlignmentCenter;
        _fansLabel.font = [UIFont systemFontOfSize:14];
    }
    return _fansLabel;
}

- (UILabel *)detailsLabel {
    if (!_detailsLabel) {
        _detailsLabel = [UILabel new];
        _detailsLabel.backgroundColor = [UIColor clearColor];
        _detailsLabel.textColor = [UIColor whiteColor];
        _detailsLabel.text = @"简介:全民TV，全民TVAPP iOS工程师";
        _detailsLabel.textAlignment = NSTextAlignmentCenter;
        _detailsLabel.font = [UIFont systemFontOfSize:13];
    }
    return _detailsLabel;
}

- (int)navBarBottom {
    if ([WRNavigationBar isIphoneX]) {
        return 88;
    } else {
        return 64;
    }
}

@end
