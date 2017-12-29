//
//  MYVerticalWaterfallFlowLayout.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYVerticalWaterfallFlowLayout;

@protocol MYVerticalWaterfallFlowLayoutDelegate <NSObject>

@required

/**
 *  @param  waterflowLayout 哪个布局需要代理返回高度
 *  @param  indexPath       对应的cell, 的indexPath, 但是indexPath.section == 0
 *  @param  itemWidth       layout内部计算的宽度
 *
 *  @return 需要代理高度对应的cell的高度
 */
- (CGFloat)waterflowLayout:(MYVerticalWaterfallFlowLayout *)waterflowLayout
            collectionView:(UICollectionView *)collectionView
  heightForItemAtIndexPath:(NSIndexPath *)indexPath
                 itemWidth:(CGFloat)itemWidth;

@optional

/**
 *  需要显示的列数, 默认3
 */
- (NSInteger)waterflowLayout:(MYVerticalWaterfallFlowLayout *)waterflowLayout
     columnsInCollectionView:(UICollectionView *)collectionView;

/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(MYVerticalWaterfallFlowLayout *)waterflowLayout columnsMarginInCollectionView:(UICollectionView *)collectionView;

/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(MYVerticalWaterfallFlowLayout *)waterflowLayout
            collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  距离collectionView四周的间距, 默认{20, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(MYVerticalWaterfallFlowLayout *)waterflowLayout
     edgeInsetsInCollectionView:(UICollectionView *)collectionView;


@end

@interface MYVerticalWaterfallFlowLayout : UICollectionViewLayout

- (instancetype)initWithDelegate:(id<MYVerticalWaterfallFlowLayoutDelegate>)delegate;

+ (instancetype)flowLayoutWithDelegate:(id<MYVerticalWaterfallFlowLayoutDelegate>)delegate;

@end
