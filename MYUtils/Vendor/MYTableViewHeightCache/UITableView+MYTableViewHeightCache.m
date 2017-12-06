//
//  UITableView+MYTableViewHeightCache.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UITableView+MYTableViewHeightCache.h"
#import <objc/runtime.h>

@implementation UITableView (MYTableViewHeightCache)

- (CGFloat)calculateCellWithIdentifier:(NSString *)identifier
                             indexPath:(NSIndexPath *)indexPath
                         configuration:(void(^)(id cell))configuration {
    // 防止初始宽度为0（如autoLayout初次加载时）
    if (self.bounds.size.width != 0) {
        if (!identifier.length || !indexPath) {
            return 0;
        }
        NSString *key = [self.cache makeKeyWithIdentifier:identifier indexPath:indexPath];
        // 如果key存在
        if ([self.cache existInCacheByKey:key]) {
            // 从cache取出高度
            return [self.cache heightFromCacheWithKey:key];
        }
        // 如果不存在则重新计算高度
        CGFloat height = [self calCulateCellWithIdentifier:identifier configuration:configuration];
        [self.cache cacheHeight:height key:key];
        return height;
    }
    return 0;
}

- (void)removeHeightCacheWithIdentifier:(NSString *)identifier
                              indexPath:(NSIndexPath *)indexPath
                           numberOfRows:(NSInteger)rows {
    [self.cache removeHeightByIdentifier:identifier indexPath:indexPath numberOfRows:rows];
}

- (void)removeAllHeightCache {
    [self.cache removeAllHeight];
}

- (void)insertCellToIndexPath:(NSIndexPath *)indexPath
               withIdentifier:(NSString *)identifier
                 numberOfRows:(NSInteger)rows {
    [self.cache insertCellToIndexPath:indexPath identifier:identifier numberOfRows:rows cache:self.cache.heightCurrentDictionary];
}

- (void)moveCellFromIndexPath:(NSIndexPath *)sourceIndexPath
  sourceIndexPathNumberOfRows:(NSInteger)sourceRows
                  toIndexPath:(NSIndexPath *)destinationIndexPath
destinationIndexPathNumberOfRows:(NSInteger)destinationRows
               withIdentifier:(NSString *)identifier {
    [self.cache moveCellFromIndexPath:sourceIndexPath sourceSectionNumberOfRows:sourceRows toIndexPath:destinationIndexPath destinationSectionNumberOfRows:destinationRows withIdentifier:identifier];
}

/// 根据重用表示取出cell并操作cell后，计算高度
- (CGFloat)calCulateCellWithIdentifier:(NSString *)identifier
                         configuration:(void(^)(id cell))configuration {
    if (!identifier.length) {
        return 0;
    }
    UITableViewCell *cell = [self calculateCellWithIdentifier:identifier];
    // 放回重用池
    [cell prepareForReuse];
    if (configuration) {
        configuration(cell);
    }
    return [self calculateCellHeightWithCell:cell];
}

/// 根据cell计算cell的高度
- (CGFloat)calculateCellHeightWithCell:(UITableViewCell *)cell {
    CGFloat width = self.bounds.size.width;
    // 根据辅助视图校正width
    if (cell.accessoryView) {
        width -= cell.accessoryView.bounds.size.width + 16;
    } else {
        static const CGFloat accessoryWidth[] = {
            [UITableViewCellAccessoryNone] = 0,
            [UITableViewCellAccessoryDisclosureIndicator] = 34,
            [UITableViewCellAccessoryDetailDisclosureButton] = 68,
            [UITableViewCellAccessoryCheckmark] = 40,
            [UITableViewCellAccessoryDetailButton] = 48
        };
        width -= accessoryWidth[cell.accessoryType];
    }
    CGFloat height = 0;
    // 如果不是非自适应模式则添加约束后计算约束后高度
    if (!cell.autoSizingFlag && width > 0) {
        // 创建约束
        NSLayoutConstraint * widthConstraint = [NSLayoutConstraint constraintWithItem:cell.contentView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:width];
        // 添加约束
        [cell.contentView addConstraint:widthConstraint];
        // 计算高度
        height = [cell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize].height;
        // 移除约束
        [cell.contentView removeConstraint:widthConstraint];
    }
    
    // 如果约束错误可能导致计算结果为零，则以自适应模式再次计算
    if (height == 0) {
        height = [cell sizeThatFits:CGSizeMake(width, 0)].height;
    }
    
    // 如果计算仍然为0，则给出默认高度
    if (height == 0) {
        height = 44;
    }
    // 如果不为无分割线模式则添加分割线高度
    if (self.separatorStyle != UITableViewCellSeparatorStyleNone) {
        height += 1.0 /[UIScreen mainScreen].scale;
    }
    return height;
}

/// 从重用池中返回计算用的cell
- (__kindof UITableViewCell *)calculateCellWithIdentifier:(NSString *)identifier {
    if (!identifier.length) {
        return nil;
    }
    // 利用runtime取出tableV绑定的存有cell的字典
    NSMutableDictionary <NSString * ,UITableViewCell *> *bindingCellDictionary = objc_getAssociatedObject(self, _cmd);
    if (!bindingCellDictionary) {
        // 如果取不到则新建并绑定
        bindingCellDictionary = [NSMutableDictionary dictionary];
        objc_setAssociatedObject(self, _cmd, bindingCellDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    // 以上只是为了只绑定一个字典，类比懒加载
    UITableViewCell *cell = bindingCellDictionary[identifier];
    if (!cell) {
        // 从重用池中取一个cell用来计算，必须以本方式从重用池中取，若以indexPath方式取由于-heightForRowAtIndexPath方法会造成循环。
        cell = [self dequeueReusableCellWithIdentifier:identifier];
        // 开启约束
        cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        // 标记只用来计算
        cell.calculateCellFlag = YES;
        bindingCellDictionary[identifier] = cell;
    }
    // 同上，保证只有一个用来计算的cell
    return cell;
}

- (void)setCache:(MYTableViewHeightCache *)cache {
    objc_setAssociatedObject(self, @selector(cache), cache, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (MYTableViewHeightCache *)cache {
    MYTableViewHeightCache *cacheTemp = objc_getAssociatedObject(self, _cmd);
    if (!cacheTemp) {
        cacheTemp = [[MYTableViewHeightCache alloc] init];
        objc_setAssociatedObject(self, _cmd, cacheTemp, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return cacheTemp;
}

@end

@implementation UITableViewCell (MYTableViewHeightCache)

- (BOOL)autoSizingFlag {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setAutoSizingFlag:(BOOL)autoSizingFlag {
    objc_setAssociatedObject(self, @selector(autoSizingFlag), @(autoSizingFlag), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)calculateCellFlag {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setCalculateCellFlag:(BOOL)calculateCellFlag {
    objc_setAssociatedObject(self, @selector(calculateCellFlag), @(calculateCellFlag), OBJC_ASSOCIATION_RETAIN);
}

@end

@implementation MYTableViewHeightCache

/// key
- (NSString *)makeKeyWithIdentifier:(NSString *)identifier
                          indexPath:(NSIndexPath *)indexPath {
    return [NSString stringWithFormat:@"%@S%ldR%ld", identifier, indexPath.section, indexPath.row];
}

/// 高度是否存在
- (BOOL)existInCacheByKey:(NSString *)key {
    NSNumber * value = [self.heightCurrentDictionary valueForKey:key];
    return (value && ![value isEqualToNumber:@-1]);
}

/// 取出缓存的高度
- (CGFloat)heightFromCacheWithKey:(NSString *)key {
    NSNumber *value = [self.heightCurrentDictionary valueForKey:key];
    if ([self is64bit]) {
        return [value doubleValue];
    }
    return [value floatValue];
}

/// 64位判断
- (BOOL)is64bit {
#if defined(__LP64__) && __LP64__
    return YES;
#else
    return NO;
#endif
}

- (void)cacheHeight:(CGFloat)height key:(NSString *)key {
    [self.heightCurrentDictionary setValue:@(height) forKey:key];
}

- (void)removeHeightByIdentifier:(NSString *)identifier
                       indexPath:(NSIndexPath *)indexPath
                    numberOfRows:(NSInteger)rows {
    if (indexPath.row < rows) {
        for (int i = 0; i < rows - 1 - indexPath.row; i ++) {
            NSIndexPath * indexPathA = [NSIndexPath indexPathForRow:indexPath.row + i inSection:indexPath.section];
            NSLog(@"%ld,%ld",indexPathA.row,indexPathA.section);
            NSIndexPath * indexPathB = [NSIndexPath indexPathForRow:indexPath.row + i + 1 inSection:indexPath.section];
            NSLog(@"%ld,%ld",indexPathB.row,indexPathB.section);
            [self _exchangeValueForIndexPath:indexPathA withIndexPath:indexPathB identifier:identifier dictionary:self.heightCacheHorizontalDictionary];
            [self _exchangeValueForIndexPath:indexPathA withIndexPath:indexPathB identifier:identifier dictionary:self.heightCacheVerticalDictionary];
        }
        NSIndexPath * indexPathC = [NSIndexPath indexPathForRow:rows - 1 inSection:indexPath.section];
        NSString * key = [self makeKeyWithIdentifier:identifier indexPath:indexPathC];
        [self.heightCacheHorizontalDictionary removeObjectForKey:key];
        [self.heightCacheVerticalDictionary removeObjectForKey:key];
    }
}

- (void)removeAllHeight {
    [self.heightCacheHorizontalDictionary removeAllObjects];
    [self.heightCacheVerticalDictionary removeAllObjects];
}

/// 插入cell是插入value
- (void)insertCellToIndexPath:(NSIndexPath *)indexPath
                 numberOfRows:(NSInteger)rows
                       height:(NSNumber *)height
                   identifier:(NSString *)identifier
                        cache:(NSMutableDictionary *)cache {
    if (indexPath.row < rows + 1) {
        [self insertCellToIndexPath:indexPath identifier:identifier numberOfRows:rows cache:cache];
        NSString * key = [self makeKeyWithIdentifier:identifier indexPath:indexPath];
        [cache setValue:height forKey:key];
    }
}

- (void)insertCellToIndexPath:(NSIndexPath *)indexPath
                   identifier:(NSString *)identifier
                 numberOfRows:(NSInteger)rows
                        cache:(NSMutableDictionary *)cache {
    if (indexPath.row < rows + 1) {
        for (int i = 0; i < rows - indexPath.row; i ++) {
            NSIndexPath * indexPathA = [NSIndexPath indexPathForRow:rows - i inSection:indexPath.section];
            NSIndexPath * indexPathB = [NSIndexPath indexPathForRow:rows - i - 1 inSection:indexPath.section];
            [self _exchangeValueForIndexPath:indexPathA withIndexPath:indexPathB identifier:identifier dictionary:cache];
        }
    }
}

/// 移动cell时交换value
- (void)moveCellFromIndexPath:(NSIndexPath *)sourceIndexPath
    sourceSectionNumberOfRows:(NSInteger)sourceRows
                  toIndexPath:(NSIndexPath *)destinationIndexPath
destinationSectionNumberOfRows:(NSInteger)destinationRows
               withIdentifier:(NSString *)identifier {
    if (sourceIndexPath.section == destinationIndexPath.section) {
        [self moveCellInSectionFromIndexPath:sourceIndexPath toIndexPath:destinationIndexPath withIdentifier:identifier];
    } else {
        [self moveCellOutSectionFromIndexPath:sourceIndexPath sourceSectionNumberOfRows:sourceRows toIndexPath:destinationIndexPath destinationSectionNumberOfRows:destinationRows withIdentifier:identifier];
    }
}

/// 组内移动
- (void)moveCellInSectionFromIndexPath:(NSIndexPath *)sourceIndexPath
                           toIndexPath:(NSIndexPath *)destinationIndexPath
                        withIdentifier:(NSString *)identifier {
    NSInteger rowA = sourceIndexPath.row;
    NSInteger rowB = destinationIndexPath.row;
    for (int i = 0; i < (MAX(rowA, rowB) - MIN(rowA, rowB)); i ++) {
        NSIndexPath *indexPathA = [NSIndexPath indexPathForRow:MIN(rowA, rowB) + i inSection:sourceIndexPath.section];
        NSIndexPath *indexPathB = [NSIndexPath indexPathForRow:MIN(rowA, rowB) + i + 1 inSection:sourceIndexPath.section];
        [self _exchangeValueForIndexPath:indexPathA withIndexPath:indexPathB identifier:identifier dictionary:self.heightCacheVerticalDictionary];
        [self _exchangeValueForIndexPath:indexPathA withIndexPath:indexPathB identifier:identifier dictionary:self.heightCacheHorizontalDictionary];
    }
}

- (void)moveCellOutSectionFromIndexPath:(NSIndexPath *)sourceIndexPath
              sourceSectionNumberOfRows:(NSInteger)sourceRows
                            toIndexPath:(NSIndexPath *)destinationIndexPath
         destinationSectionNumberOfRows:(NSInteger)destinationRows
                         withIdentifier:(NSString *)identifier {
    NSNumber *numberHorizontal;
    NSNumber *numberVertical;
    NSLog(@"%ld",sourceIndexPath.row);
    if (sourceIndexPath.row < sourceRows) {
        NSString * key = [self makeKeyWithIdentifier:identifier indexPath:sourceIndexPath];
        numberHorizontal = self.heightCacheHorizontalDictionary[key];
        numberVertical = self.heightCacheVerticalDictionary[key];
        [self removeHeightByIdentifier:identifier indexPath:sourceIndexPath numberOfRows:sourceRows];
    }
    NSLog(@"%ld,%ld",destinationIndexPath.row,destinationIndexPath.section);
    [self insertCellToIndexPath:destinationIndexPath numberOfRows:destinationRows height:numberHorizontal identifier:identifier cache:self.heightCacheHorizontalDictionary];
    [self insertCellToIndexPath:destinationIndexPath numberOfRows:destinationRows height:numberVertical identifier:identifier cache:self.heightCacheVerticalDictionary];
}

/// 根据indexPath交换两个Key
- (void)_exchangeValueForIndexPath:(NSIndexPath *)indexPath1
                     withIndexPath:(NSIndexPath *)indexPath2
                        identifier:(NSString *)identifier
                        dictionary:(NSMutableDictionary *)dictionary {
    NSString *key1 = [self makeKeyWithIdentifier:identifier indexPath:indexPath1];
    NSString *key2 = [self makeKeyWithIdentifier:identifier indexPath:indexPath2];
    NSNumber *Temp = dictionary[key1];
    dictionary[key1] = dictionary[key2];
    dictionary[key2] = Temp;
}

- (NSMutableDictionary *)heightCacheHorizontalDictionary {
    if (!_heightCacheHorizontalDictionary) {
        _heightCacheHorizontalDictionary = [NSMutableDictionary dictionary];
    }
    return _heightCacheHorizontalDictionary;
}

- (NSMutableDictionary *)heightCacheVerticalDictionary {
    if (!_heightCacheVerticalDictionary) {
        _heightCacheVerticalDictionary = [NSMutableDictionary dictionary];
    }
    return _heightCacheVerticalDictionary;
}

- (NSMutableDictionary *)heightCurrentDictionary {
    return UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation)?self.heightCacheVerticalDictionary:self.heightCacheHorizontalDictionary;
}

@end
