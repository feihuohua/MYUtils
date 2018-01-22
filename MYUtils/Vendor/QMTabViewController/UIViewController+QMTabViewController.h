//
//  UIViewController+QMTabViewController.h
//  QuanMinTV
//
//  Created by sunjinshuai on 2018/1/19.
//  Copyright © 2018年 QMTV. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QMTabViewController;

@interface UIViewController (QMTabViewController)

@property (nonatomic, weak) QMTabViewController *tabViewController;

// 子控件的ScrollView容器
@property (nonatomic, weak) UIScrollView *tabContentScrollView;

@end
