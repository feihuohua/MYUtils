//
//  UITableView+Chain.h
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYTableViewHelper;

@interface UITableView (Chain)

@property (nonatomic, strong) MYTableViewHelper *helper;

- (void)makeConfigure:(void (^)(MYTableViewHelper *helper))helper;

@end
