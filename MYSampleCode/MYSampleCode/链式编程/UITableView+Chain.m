//
//  UITableView+Chain.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "UITableView+Chain.h"
#import "MYTableViewHelper.h"
#import <objc/runtime.h>

@implementation UITableView (Chain)

- (void)setHelper:(MYTableViewHelper *)helper {
    objc_setAssociatedObject(self, @selector(helper), helper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MYTableViewHelper *)helper {
    return objc_getAssociatedObject(self, @selector(helper));
}

- (void)makeConfigure:(void (^)(MYTableViewHelper *))helper {
    MYTableViewHelper *tableViewHelper = [MYTableViewHelper new];
    !helper ? : helper(tableViewHelper);
    self.helper = tableViewHelper;
}

@end
