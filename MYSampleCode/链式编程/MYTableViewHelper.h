//
//  MYTableViewHelper.h
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTableViewHelper : NSObject <UITableViewDataSource>

- (MYTableViewHelper *(^)(UITableView *, Class))bindTb;
- (MYTableViewHelper *(^)(NSInteger))totalSection;
- (MYTableViewHelper *(^)(NSInteger))section;
- (MYTableViewHelper *(^)(NSInteger))row;
- (MYTableViewHelper *(^)(NSArray *))configureCell;

@end
