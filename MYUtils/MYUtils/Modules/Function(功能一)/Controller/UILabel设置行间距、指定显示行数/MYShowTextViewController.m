//
//  MYShowTextViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/8.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYShowTextViewController.h"
#import "MYShowTextCellModel.h"
#import "MYShowTextViewCell.h"
#import "UtilsMacros.h"

#define TextInitContentLines 3
#define TextContentNoLimitLines 0

@interface MYShowTextViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, assign) NSInteger lines;

@end

@implementation MYShowTextViewController

static NSString * const reuseIdentifier = @"MYShowTextViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UILabel设置行间距、指定显示行数";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSArray *array = [[NSMutableArray alloc] initWithObjects:
                      @"在iOS中，有时候显示文本，需要设置文本的行间距、指定显示行数、文本内容超出显示行数，省略结尾部分的内容以……方式省略。这些都可以使用UILabel来是实现，前提是你扩展了UILabel这方面的特性。",
                      @"这个Demo是使用UITableView组织文本的显示。每一个cell可以显示title和content，cell中先指定content文本显示3行，行间距是5.0f。",
                      @"如果content文本用3行不能全部显示，文本下面出现“显示文本”按钮，点击“显示全文”按钮，可以展开全部文本，此时按钮变成“收起全文”；点击按钮可以收起全文，依旧显示3行，按钮恢复成“显示全文”。",
                      @"如果content文本用3行可以全部显示，不会出现按钮。",
                      @"content显示的文本可以设置行数值，行间距值，收起全文和展开全文都是利用**UILabel的扩展特性**来实现的。content显示的文本可以设置行数值，行间距值，收起全文和展开全文都是利用**UILabel的扩展特性**来实现的。",nil];
    for (NSInteger i = 0; i < array.count; i++) {
        MYShowTextCellModel *cellModel = [[MYShowTextCellModel alloc] initWithContent:array[i] contentLines:TextInitContentLines isOpen:NO];
        [self.dataSource addObject:cellModel];
    }
    self.lines = 2;
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self.tableView registerClass:[MYShowTextViewCell class] forCellReuseIdentifier:reuseIdentifier];
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
    
    MYShowTextCellModel *textCellModel = [self.dataSource objectAtIndex:indexPath.row];
    return [MYShowTextViewCell cellHeightWithModel:textCellModel];
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
    MYShowTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    @WeakObj(self)
    [cell setOpenContentBlock:^(MYShowTextCellModel *cellModel) {
        @StrongObj(self)
        if (cellModel.isOpen) {
            cellModel.contentLines = TextContentNoLimitLines;
        } else {
            cellModel.contentLines = TextInitContentLines;
        }
        NSInteger newxtRow = (indexPath.row + 1) >= [self.dataSource count] - 1 ?  [self.dataSource count] - 1 :(indexPath.row + 1);
        [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:newxtRow  inSection:indexPath.section]] withRowAnimation:UITableViewRowAnimationFade];
    }];
    MYShowTextCellModel *textCellModel = [self.dataSource objectAtIndex:indexPath.row];
    [cell layoutSubviewsWithModel:textCellModel];
    return cell;
}

- (void)dealloc {
    NSLog(@"MYShowTextViewController销毁");
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
    }
    return _tableView;
}

@end
