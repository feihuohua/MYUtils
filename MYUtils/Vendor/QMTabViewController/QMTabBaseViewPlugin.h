//
//  QMTabBaseViewPlugin.h
//  QuanMinTV
//
//  Created by sunjinshuai on 2018/1/19.
//  Copyright © 2018年 QMTV. All rights reserved.
//

#import <UIKit/UIKit.h>

@class QMTabViewController;

@protocol QMTabViewPluginDelegate <NSObject>

- (void)scrollViewVerticalScroll:(CGFloat)contentPercentY;
- (void)scrollViewHorizontalScroll:(CGFloat)contentOffsetX;
- (void)scrollViewWillScrollFromIndex:(NSInteger)index offsetX:(CGFloat)contentOffsetX;
- (void)scrollViewDidScrollToIndex:(NSInteger)index;

@end

@interface QMTabBaseViewPlugin : NSObject <QMTabViewPluginDelegate>

@property (nonatomic, assign) QMTabViewController *tabViewController;

// Called only once when enable. Default does nothing
- (void)initPlugin;

// Called when tabViewController load. Default does nothing
- (void)loadPlugin;

// Called before tabViewController reload. Default does nothing
- (void)removePlugin;

@end
