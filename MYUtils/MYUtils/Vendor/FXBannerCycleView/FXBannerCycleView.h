//
//  FXBannerCycleView.h
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/8/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FXBannerCycleViewType) {
    FXBannerCycleViewTypeDefault, // default
    FXBannerCycleViewTypePage,   // left
};

typedef NS_ENUM(NSInteger, FXBannerCyclePageControlPosition) {
    FXBannerCyclePageControlPositionCenter, // default
    FXBannerCyclePageControlPositionLeft,   // left
    FXBannerCyclePageControlPositionRight,  // right
};

@class FXBannerCycleView;

@protocol FXBannerCycleViewDataSource <NSObject>

@required

/**
 *  代理方法取轮播总数（参考UITableView或UICollectionView）
 *
 *  @param cycleView 轮播视图
 *
 *  @return 轮播总数
 */
- (NSInteger)numberOfRowsInCycleView:(FXBannerCycleView *)cycleView;

/**
 *  代理方法取轮播子视图（参考UITableView或UICollectionView）
 *
 *  @param cycleView 轮播视图
 *  @param row       子视图索引
 *
 *  @return 轮播子视图（继承自系统UICollectionViewCell）
 */
- (UICollectionViewCell *)cycleView:(FXBannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row;

@end

@protocol FXBannerCycleViewDelegate <NSObject>

@optional
/**
 *  代理方法取子视图大小
 *
 *  @param cycleView 轮播视图
 *  @param row       子视图索引
 *
 *  @return 子视图大小
 */
- (CGSize)cycleView:(FXBannerCycleView *)cycleView sizeForItemAtRow:(NSInteger)row;

/**
 *  代理方法视图滚动到子视图时回调
 *
 *  @param cycleView 滚动视图
 *  @param row       子视图索引
 */
- (void)cycleView:(FXBannerCycleView *)cycleView didScrollToItemAtRow:(NSInteger)row;

/**
 *  代理方法子视图点击时回调
 *
 *  @param cycleView 滚动视图
 *  @param row       子视图索引
 */
- (void)cycleView:(FXBannerCycleView *)cycleView didSelectItemAtRow:(NSInteger)row;

@end

@interface FXBannerCycleView : UIView

/** 
 子视图大小 
 */
@property (nonatomic, assign) CGSize itemSize;

/** 
 子视图间隔 
 */
@property (nonatomic, assign) CGFloat itemSpace;

/** 
 子视图距父视图间距 
 */
@property (nonatomic, assign) CGFloat itemMargin;

/** 
 数据源 
 */
@property (nonatomic, weak) id <FXBannerCycleViewDataSource> dataSource;

/** 
 代理 
 */
@property (nonatomic, weak) id <FXBannerCycleViewDelegate> delegate;

/** 
 当前索引
 */
@property (nonatomic, assign, readonly) NSInteger index;

/** 
 是否显示页面指示器 
 */
@property (nonatomic, assign) BOOL showPageControl;

/** 
 页面指示器显示位置 
 */
@property (nonatomic, assign) FXBannerCyclePageControlPosition pageControlPosition;

/** 
 用于设置页面指示器位置偏移 
 */
@property (nonatomic, assign) CGPoint pageControlOffset;

/** 
 是否循环(default = YES) 
 */
@property (nonatomic, assign) BOOL cycleEnabled;

/** 
 自动滚动间隔(default = 0) 
 */
@property (nonatomic, assign) CGFloat timeInterval;

- (instancetype)initWithType:(FXBannerCycleViewType)type;

/** 
 重新载入视图 
 */
- (void)reloadData;

/** 
 滚动到下一个子视图 
 */
- (void)scrollToNextIndex;

/** 
 滚动到上一个子视图 
 */
- (void)scrollToPreviousIndex;

/** 
 滚动到指定索引 
 */
- (void)scrollToIndex:(NSInteger)index animation:(BOOL)animation;

/**
 *  注册子视图
 *
 *  @param cellClass  子视图类
 *  @param identifier 子视图重用标示
 */
- (void)registerClass:(Class)cellClass forCellWithReuseIdentifier:(NSString *)identifier;

/**
 *  从缓存中取重用子视图
 *
 *  @param identifier 子视图重用标示
 *  @param row        子视图索引
 *
 *  @return 重用的子视图
 */
- (__kindof UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forRow:(NSInteger)row;

@end
