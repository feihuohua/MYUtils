//
//  UIViewController+MYTabViewController.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYTabViewController;

@interface UIViewController (MYTabViewController)

@property (nonatomic, weak) MYTabViewController *tabViewController;

// ScrollView of childViewController. You can implement as necessary.
@property (nonatomic, weak) UIScrollView *tabContentScrollView;

@end
