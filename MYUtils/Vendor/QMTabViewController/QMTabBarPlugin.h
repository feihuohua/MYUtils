//
//  QMTabBarPlugin.h
//  QuanMinTV
//
//  Created by sunjinshuai on 2018/1/19.
//  Copyright © 2018年 QMTV. All rights reserved.
//

#import "QMTabBaseViewPlugin.h"
@class QMTabViewBar;
@class QMTabViewController;

@protocol QMTabBarPluginDelagate <NSObject>

@optional

- (void)tabViewController:(QMTabViewController *)tabViewController
        tabViewBarDidLoad:(QMTabViewBar *)tabViewBar;

@end

/*
 You can enable custome tabViewBar by this plugin. Default tabViewBar is nil
 */
@interface QMTabBarPlugin : QMTabBaseViewPlugin

- (instancetype)initWithTabViewBar:(QMTabViewBar *)tabViewBar
                          delegate:(id<QMTabBarPluginDelagate>)delegate;

@end
