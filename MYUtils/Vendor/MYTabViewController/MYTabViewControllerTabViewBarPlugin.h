//
//  MYTabViewControllerTabViewBarPlugin.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYTabViewControllerBasePlugin.h"
@class MYTabViewController;
@class MYTabViewBar;

@protocol MYTabViewBarPluginDelagate <NSObject>

@optional

- (void)tabViewController:(MYTabViewController *)tabViewController
        tabViewBarDidLoad:(MYTabViewBar *)tabViewBar;

@end

/*
 You can enable custome tabViewBar by this plugin. Default tabViewBar is nil
 */
@interface MYTabViewControllerTabViewBarPlugin : MYTabViewControllerBasePlugin

- (instancetype)initWithTabViewBar:(MYTabViewBar *)tabViewBar
                          delegate:(id<MYTabViewBarPluginDelagate>)delegate;

@end
