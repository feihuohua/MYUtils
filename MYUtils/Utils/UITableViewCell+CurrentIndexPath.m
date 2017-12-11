//
//  UITableViewCell+CurrentIndexPath.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UITableViewCell+CurrentIndexPath.h"
#import <objc/runtime.h>

@implementation UITableViewCell (CurrentIndexPath)

@dynamic currentIndexPath;

- (NSIndexPath *)currentIndexPath {
    NSIndexPath *indexPath = objc_getAssociatedObject(self, @selector(currentIndexPath));
    return indexPath;
}

- (void)setCurrentIndexPath:(NSIndexPath *)currentIndexPath {
    objc_setAssociatedObject(self, @selector(currentIndexPath), currentIndexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
