//
//  MYFadeViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYFadeViewController.h"
#import "MYTestViewController.h"
#import "MYFadeNavigationController.h"
#import "UtilsMacros.h"

#define kGKHeaderHeight 150.f
#define kGKHeaderVisibleThreshold 44.f
#define kGKNavbarHeight 64.f

@interface MYFadeViewController ()<UITableViewDataSource, UITableViewDelegate, MYFadeNavigationControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) MYFadeNavigationControllerNavigationBarVisibility navigationBarVisibility;

@end

@implementation MYFadeViewController

static NSString *identifier = @"UITableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];

    self.navigationBarVisibility = MYFadeNavigationControllerNavigationBarVisibilityHidden;
    MYFadeNavigationController *navigationController = (MYFadeNavigationController *)self.navigationController;
    [navigationController setNeedsNavigationBarVisibilityUpdateAnimated:NO];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %@", @(indexPath.row)];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"header"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 300.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MYTestViewController *test = [[MYTestViewController alloc] init];
    [self.navigationController pushViewController:test animated:YES];
}

#pragma mark <MYFadeNavigationControllerDelegate>
- (MYFadeNavigationControllerNavigationBarVisibility)preferredNavigationBarVisibility {
    return self.navigationBarVisibility;
}

- (void)setNavigationBarVisibility:(MYFadeNavigationControllerNavigationBarVisibility)navigationBarVisibility {
    if (_navigationBarVisibility != navigationBarVisibility) {
        _navigationBarVisibility = navigationBarVisibility;
        MYFadeNavigationController *navigationController = (MYFadeNavigationController *)self.navigationController;
        if (navigationController.topViewController) {
            [navigationController setNeedsNavigationBarVisibilityUpdateAnimated:YES];
        }
    }
}

#pragma mark <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat scrollOffsetY = kGKHeaderHeight - scrollView.contentOffset.y;

    if (scrollOffsetY - kGKNavbarHeight < kGKHeaderVisibleThreshold) {
        self.navigationBarVisibility = MYFadeNavigationControllerNavigationBarVisibilityVisible;
    } else {
        self.navigationBarVisibility = MYFadeNavigationControllerNavigationBarVisibilityHidden;
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, MYScreenWidth, MYScreenHeight) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
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
