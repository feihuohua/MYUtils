//
//  MYCountDownViewController1.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYCountDownViewController1.h"
#import "MYCountDownManager.h"
#import "MYCountDownModel.h"
#import "MYCountDownViewCell.h"

@interface MYCountDownViewController1 ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation MYCountDownViewController1

static NSString * const identifier = @"MYCountDownViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MYCountDownViewCell class] forCellReuseIdentifier:identifier];
    [[MYCountDownManager manager] start];
}

#pragma mark - UITableViewDataSource, UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MYCountDownViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.countDownModel = self.dataSource[indexPath.row];
    cell.finishBlock = ^(MYCountDownModel *countDownModel) {
        if (!countDownModel.timeOut) {
            NSLog(@"MYCountDownViewController--%@--时间到了", countDownModel.title);
        }
        countDownModel.timeOut = YES;
    };
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - 刷新数据
- (void)reloadData {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 模拟网络请求
        self.dataSource = nil;
        // 调用reload
        [[MYCountDownManager manager] reload];
        // 刷新
        [self.tableView reloadData];
        // 停止刷新
        [self.tableView.refreshControl endRefreshing];
    });
}

- (void)dealloc {
    [[MYCountDownManager manager] invalidate];
    [[MYCountDownManager manager] reload];
}

#pragma mark - Getter
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.refreshControl = [[UIRefreshControl alloc] init];
        [_tableView.refreshControl addTarget:self action:@selector(reloadData) forControlEvents:UIControlEventValueChanged];
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (!_dataSource) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < 50; i++) {
            NSInteger count = arc4random_uniform(100);
            MYCountDownModel *countDownModel = [[MYCountDownModel alloc]init];
            countDownModel.count = count;
            countDownModel.title = [NSString stringWithFormat:@"第%zd条数据", i];
            [array addObject:countDownModel];
        }
        _dataSource = array.copy;
    }
    return _dataSource;
}

@end
