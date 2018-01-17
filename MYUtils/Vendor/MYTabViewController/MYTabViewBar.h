//
//  MYTabViewBar.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

static const CGFloat MYTabViewBarDefaultHeight = 44.0f;

@protocol MYTabViewBar

@required

// Subclass must implement -reloadTabBar
- (void)reloadTabBar;

@optional
- (void)tabScrollXPercent:(CGFloat)percent;
- (void)tabScrollXOffset:(CGFloat)contentOffsetX;
- (void)tabDidScrollToIndex:(NSInteger)index;
- (void)tabWillScrollFromIndex:(NSInteger)index offsetX:(CGFloat)contentOffsetX;

@end

@interface MYTabViewBar : UIView<MYTabViewBar>

@end
