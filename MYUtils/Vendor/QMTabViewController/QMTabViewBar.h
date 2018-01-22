//
//  QMTabViewBar.h
//  QuanMinTV
//
//  Created by sunjinshuai on 2018/1/19.
//  Copyright © 2018年 QMTV. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat QMTabViewBarDefaultHeight = 44.0f;

@protocol QMTabViewBarDelegate <NSObject>

@required

- (void)reloadTabBar;

@optional
- (void)tabScrollXPercent:(CGFloat)percent;
- (void)tabScrollXOffset:(CGFloat)contentOffsetX;
- (void)tabDidScrollToIndex:(NSInteger)index;
- (void)tabWillScrollFromIndex:(NSInteger)index offsetX:(CGFloat)contentOffsetX;

@end


@interface QMTabViewBar : UIView<QMTabViewBarDelegate>

@end
