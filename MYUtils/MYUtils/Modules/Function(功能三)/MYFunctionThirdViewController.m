//
//  MYFunctionThirdViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/16.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYFunctionThirdViewController.h"

@interface MYFunctionThirdViewController ()<UISearchResultsUpdating>

@property (nonatomic, assign) BOOL hidden;

@end

@implementation MYFunctionThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"iOS11的效果";
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    if (@available(iOS 11.0, *)) {
        self.navigationController.navigationBar.prefersLargeTitles = YES;
        UISearchController *searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
        searchController.searchResultsUpdater = self;
        self.navigationItem.searchController = searchController;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"MyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.backgroundColor = self.tableView.backgroundColor;
    cell.backgroundColor = self.tableView.backgroundColor;
    cell.textLabel.text = [NSString stringWithFormat:@"Cell %ld", indexPath.row + 1];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
}

@end
