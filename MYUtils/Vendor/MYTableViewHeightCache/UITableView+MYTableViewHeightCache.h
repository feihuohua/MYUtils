//
//  UITableView+MYTableViewHeightCache.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYTableViewHeightCache;

@interface UITableView (MYTableViewHeightCache)

/// 缓存实例
@property (nonatomic, strong) MYTableViewHeightCache *cache;

/// 返回cell高度并缓存高度
/*
 indetifier:重用标识
 indexPath:cell的角标
 configuration:回调block，可在block中对cell进行相关操作，操作后在计算高度
 */
- (CGFloat)calculateCellWithIdentifier:(NSString *)identifier
                             indexPath:(NSIndexPath *)indexPath
                         configuration:(void(^)(id cell))configuration;
/// 移除某个cell的高度缓存
/*
 indetifier:重用标识
 indexPath:cell的角标
 */
- (void)removeHeightCacheWithIdentifier:(NSString *)identifier
                              indexPath:(NSIndexPath *)indexPath
                           numberOfRows:(NSInteger)rows;

/// 移除所有缓存的高度
- (void)removeAllHeightCache;

/// 插入cell时插入高度缓存
/*
 indetifier:重用标识
 indexPath:cell的角标
 rows:插入的分组插入前的元素个数
 */
- (void)insertCellToIndexPath:(NSIndexPath *)indexPath
               withIdentifier:(NSString *)identifier
                 numberOfRows:(NSInteger)rows;

/// 移动cell时交换高度缓存
/*
 indetifier:重用标识
 sourceIndexPath:cell移动的初始角标
 sourceRows:移动前初始分组的元素个数
 destinationIndexPath:cell移动的目标角标
 sourceRows:移动前目标分组的元素个数
 */
- (void)moveCellFromIndexPath:(NSIndexPath *)sourceIndexPath
 sourceIndexPathNumberOfRows:(NSInteger)sourceRows
                 toIndexPath:(NSIndexPath *)destinationIndexPath
destinationIndexPathNumberOfRows:(NSInteger)destinationRows
              withIdentifier:(NSString *)identifier;
@end

@interface UITableViewCell (MYTableViewHeightCache)

// 计算用的cell标识符（将计算用的cell与正常显示的cell进行区分，避免不必要的ui响应）
@property (nonatomic, assign) BOOL calculateCellFlag;

// 不适用autoSizing标识符（不依靠约束计算，只进行自适应）
@property (nonatomic, assign) BOOL autoSizingFlag;
@end


@interface MYTableViewHeightCache : NSObject

//竖直行高缓存字典
@property (nonatomic, strong) NSMutableDictionary *heightCacheVerticalDictionary;
//水平行高缓存字典
@property (nonatomic, strong) NSMutableDictionary *heightCacheHorizontalDictionary;
//当前状态行高缓存字典（中间量）
@property (nonatomic, strong) NSMutableDictionary *heightCurrentDictionary;

- (NSString *)makeKeyWithIdentifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath;

/// 高度是否存在
- (BOOL)existInCacheByKey:(NSString *)key;

/// 取出缓存的高度
- (CGFloat)heightFromCacheWithKey:(NSString *)key;

/// 缓存高度
- (void)cacheHeight:(CGFloat)height key:(NSString *)key;

/// 根据key删除缓存
- (void)removeHeightByIdentifier:(NSString *)identifier
                       indexPath:(NSIndexPath *)indexPath
                    numberOfRows:(NSInteger)rows;

/// 删除所有高度缓存
- (void)removeAllHeight;


- (void)insertCellToIndexPath:(NSIndexPath *)indexPath
                   identifier:(NSString *)identifier
                 numberOfRows:(NSInteger)rows
                        cache:(NSMutableDictionary *)cache;

/// 组外移动
- (void)moveCellFromIndexPath:(NSIndexPath *)sourceIndexPath
    sourceSectionNumberOfRows:(NSInteger)sourceRows
                  toIndexPath:(NSIndexPath *)destinationIndexPath
destinationSectionNumberOfRows:(NSInteger)destinationRows
               withIdentifier:(NSString *)identifier;

@end
