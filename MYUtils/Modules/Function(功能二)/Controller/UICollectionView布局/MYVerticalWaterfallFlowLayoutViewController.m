//
//  MYVerticalWaterfallFlowLayoutViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYVerticalWaterfallFlowLayoutViewController.h"
#import "MYVerticalWaterfallFlowLayout.h"

@interface MYVerticalWaterfallFlowLayoutViewController ()<MYVerticalWaterfallFlowLayoutDelegate>

@end

@implementation MYVerticalWaterfallFlowLayoutViewController

static NSString *const shopId = @"shop";

- (instancetype)init {
    
    MYVerticalWaterfallFlowLayout *layout = [[MYVerticalWaterfallFlowLayout alloc] initWithDelegate:self];
    
    if (self = [super initWithCollectionViewLayout:layout]) {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class]) forIndexPath:indexPath];
    
    cell.contentView.backgroundColor = [UIColor yellowColor];
    
    if (![cell.contentView viewWithTag:100]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
        label.tag = 100;
        label.textColor = [UIColor redColor];
        label.font = [UIFont boldSystemFontOfSize:17];
        [cell.contentView addSubview:label];
    }
    
    UILabel *label = [cell.contentView viewWithTag:100];
    
    label.text = [NSString stringWithFormat:@"%zd", indexPath.item];
    return cell;
}

#pragma mark - MYVerticalWaterfallFlowLayoutDelegate
- (CGFloat)waterflowLayout:(MYVerticalWaterfallFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth {
    return ((arc4random()) % 7 + 1) * itemWidth;
}

/**
 *  需要显示的列数, 默认3
 */
- (NSInteger)waterflowLayout:(MYVerticalWaterfallFlowLayout *)waterflowLayout columnsInCollectionView:(UICollectionView *)collectionView {
    return 4;
}

/**
 *  列间距, 默认10
 */
- (CGFloat)waterflowLayout:(MYVerticalWaterfallFlowLayout *)waterflowLayout columnsMarginInCollectionView:(UICollectionView *)collectionView {
    return 10;
}

/**
 *  行间距, 默认10
 */
- (CGFloat)waterflowLayout:(MYVerticalWaterfallFlowLayout *)waterflowLayout collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item % 5) {
        return 10;
    } else {
        return 30;
    }
}

/**
 *  距离collectionView四周的间距, 默认{20, 10, 10, 10}
 */
- (UIEdgeInsets)waterflowLayout:(MYVerticalWaterfallFlowLayout *)waterflowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView {
    
    return UIEdgeInsetsMake(20, 5, 40, 10);
}

@end
