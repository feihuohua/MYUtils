//
//  MYTabViewControllerBasePlugin.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYTabViewController;

@protocol MYTabViewControllerPlugin <NSObject>

- (void)scrollViewVerticalScroll:(CGFloat)contentPercentY;
- (void)scrollViewHorizontalScroll:(CGFloat)contentOffsetX;
- (void)scrollViewWillScrollFromIndex:(NSInteger)index offsetX:(CGFloat)contentOffsetX;
- (void)scrollViewDidScrollToIndex:(NSInteger)index;

@end

@interface MYTabViewControllerBasePlugin : NSObject <MYTabViewControllerPlugin>

@property (nonatomic, assign) MYTabViewController *tabViewController;

// Called only once when enable. Default does nothing
- (void)initPlugin;

// Called when tabViewController load. Default does nothing
- (void)loadPlugin;

// Called before tabViewController reload. Default does nothing
- (void)removePlugin;

@end
