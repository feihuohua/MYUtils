//
//  MYJDFlowLayoutViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYJDFlowLayoutViewController.h"
#import "MYJDFlowLayout.h"

@interface MYJDFlowLayoutViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, MYJDFlowLayoutDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;

@end

@implementation MYJDFlowLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([UICollectionViewCell class])];
}

#pragma mark - delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 50;
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

#pragma mark - MYJDFlowLayoutDelegate

- (CGSize)flowLayout:(MYJDFlowLayout *)flowLayout collectionView:(UICollectionView *)collectionView sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.item == 0) {
        
        return CGSizeMake([UIScreen mainScreen].bounds.size.width, 150);
        
    } else if (indexPath.item == 1) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 100);
        
    } else if (indexPath.item == 2) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width * 0.38, 60);
        
    } else if (indexPath.item == 3) {
        return CGSizeMake([UIScreen mainScreen].bounds.size.width - 10, 300);
    } else {
        return CGSizeMake(([UIScreen mainScreen].bounds.size.width - 5) * 0.5, ([UIScreen mainScreen].bounds.size.width - 5) * 0.5 / 0.8);
    }
}


- (CGFloat)flowLayout:(MYJDFlowLayout *)flowLayout collectionView:(UICollectionView *)collectionView linesMarginForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item <= 3) {
        return 5;
    } else {
        return 15;
    }
}

- (CGFloat)flowLayout:(MYJDFlowLayout *)flowLayout collectionView:(UICollectionView *)collectionView columnsMarginForItemAtIndexPath:(NSIndexPath *)indexPath {
    return 5;
}

- (UIEdgeInsets)flowLayout:(MYJDFlowLayout *)flowLayout edgeInsetsInCollectionView:(UICollectionView *)collectionView {
    return UIEdgeInsetsMake(20, 0, 20, 0);
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        MYJDFlowLayout *myLayout = [[MYJDFlowLayout alloc] initWithDelegate:self];
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:myLayout];
        _collectionView = collectionView;
        collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self.view addSubview:collectionView];
    }
    return _collectionView;
}

@end
