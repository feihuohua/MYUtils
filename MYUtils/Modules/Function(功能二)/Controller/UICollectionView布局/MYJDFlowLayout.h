//
//  MYJDFlowLayout.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYJDFlowLayout;

@protocol MYJDFlowLayoutDelegate <NSObject>

@required

/**
 *  @param flowLayout 哪个布局需要代理返回大小
 *  @param  indexPath          对应的cell, 的indexPath, 但是indexPath.section == 0
 *
 *  @return 需要代理高度对应的cell的尺寸
 */
- (CGSize)flowLayout:(MYJDFlowLayout *)flowLayout
      collectionView:(UICollectionView *)collectionView
sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  列间距, 默认10
 */
- (CGFloat)flowLayout:(MYJDFlowLayout *)flowLayout
       collectionView:(UICollectionView *)collectionView columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  行间距, 默认10
 */
- (CGFloat)flowLayout:(MYJDFlowLayout *)flowLayout
       collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  距离collectionView四周的间距, 默认{20, 10, 10, 10}
 */
- (UIEdgeInsets)flowLayout:(MYJDFlowLayout *)flowLayout
edgeInsetsInCollectionView:(UICollectionView *)collectionView;


@end

@interface MYJDFlowLayout : UICollectionViewLayout

+ (instancetype)flowLayoutWithDelegate:(id<MYJDFlowLayoutDelegate>)delegate;
- (instancetype)initWithDelegate:(id<MYJDFlowLayoutDelegate>)delegate;

@end
