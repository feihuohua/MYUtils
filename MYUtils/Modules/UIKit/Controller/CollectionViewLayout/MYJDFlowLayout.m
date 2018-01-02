//
//  MYJDFlowLayout.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/29.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYJDFlowLayout.h"

static const CGFloat _XMargin_ = 10;
static const CGFloat _YMargin_ = 10;
static const UIEdgeInsets _EdgeInsets_ = {20, 10, 10, 10};

@interface MYJDFlowLayout()

/** 所有的cell的attrbts */
@property (nonatomic, strong) NSMutableArray<UICollectionViewLayoutAttributes *> *attributes;

/** 每一列的最后的高度 */
@property (nonatomic, assign) CGRect lastAttributesFrame;

@end

@implementation MYJDFlowLayout

+ (instancetype)flowLayoutWithDelegate:(id<MYJDFlowLayoutDelegate>)delegate {
    return [[self alloc] initWithDelegate:delegate];
}

- (instancetype)initWithDelegate:(id<MYJDFlowLayoutDelegate>)delegate {
    if (self = [super init]) {
        
    }
    return self;
}

/**
 *  刷新布局的时候回重新调用
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    // 如果重新刷新就需要移除之前存储的高度
    // 复赋值以顶部的高度, 并且根据列数
    self.lastAttributesFrame = CGRectMake(0, 0, self.collectionView.frame.size.width, 0);
    
    // 移除以前计算的cells的attrbs
    [self.attributes removeAllObjects];
    
    // 并且重新计算, 每个cell对应的atrbs, 保存到数组
    for (NSInteger i = 0; i < [self.collectionView numberOfItemsInSection:0]; i++) {
        [self.attributes addObject:[self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]]];
    }
}

/**
 *在这里边所处每个cell对应的位置和大小
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *atrbs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // 原来的
    CGSize itemSize = [self.delegate flowLayout:self collectionView:self.collectionView sizeForItemAtIndexPath:indexPath];
    
    CGFloat w = floorf(itemSize.width);
    w = MIN(w, self.collectionView.frame.size.width);
    
    // 高度由外界决定, 外界必须实现这个方法
    CGFloat h = itemSize.height;
    
    // 拿到最后的高度最小的那一列, 假设第0列最小
    CGFloat rightLeftWidth = self.collectionView.frame.size.width - CGRectGetMaxX(self.lastAttributesFrame) - [self xMarginAtIndexPath:indexPath] - self.edgeInsets.right;
    
    CGFloat x = self.edgeInsets.left;
    CGFloat y = self.edgeInsets.top;
    
    if (rightLeftWidth >= w) {
        
        x = CGRectGetMaxX(self.lastAttributesFrame) + [self xMarginAtIndexPath:indexPath];
        y = self.lastAttributesFrame.origin.y;
    } else {
        x = self.edgeInsets.left;
        y = CGRectGetMaxY(self.maxHeightFrame) + [self yMarginAtIndexPath:indexPath];
    }
    
    if (w > self.collectionView.frame.size.width - self.edgeInsets.left - self.edgeInsets.right) {
        
        x = (self.collectionView.frame.size.width - w) * 0.5;
    }
    
    if (y <= [self yMarginAtIndexPath:indexPath]) {
        y = self.edgeInsets.top;
    }
    
    // 赋值frame
    atrbs.frame = CGRectMake(x, y, w, h);
    
    // 覆盖添加完后那一列;的最新高度
    self.lastAttributesFrame = atrbs.frame;
    
    return atrbs;
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.attributes;
}

- (CGRect)maxHeightFrame {
    
    __block CGRect maxHeightFrame = self.lastAttributesFrame;
    
    [self.attributes enumerateObjectsUsingBlock:^(UICollectionViewLayoutAttributes * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (CGRectGetMaxY(obj.frame) > CGRectGetMaxY(maxHeightFrame)) {
            maxHeightFrame = obj.frame;
        }
    }];
    return maxHeightFrame;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.frame.size.width, CGRectGetMaxY(self.maxHeightFrame) + self.edgeInsets.bottom);
}

- (CGFloat)xMarginAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(flowLayout:collectionView:columnsMarginForItemAtIndexPath:)]) {
        return [self.delegate flowLayout:self collectionView:self.collectionView columnsMarginForItemAtIndexPath:indexPath];
    } else {
        return _XMargin_;
    }
}

- (CGFloat)yMarginAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.delegate respondsToSelector:@selector(flowLayout:collectionView:linesMarginForItemAtIndexPath:)]) {
        return [self.delegate flowLayout:self collectionView:self.collectionView linesMarginForItemAtIndexPath:indexPath];
    } else {
        return _YMargin_;
    }
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(flowLayout:edgeInsetsInCollectionView:)]) {
        return [self.delegate flowLayout:self edgeInsetsInCollectionView:self.collectionView];
    } else {
        return _EdgeInsets_;
    }
}

- (id<MYJDFlowLayoutDelegate>)delegate {
    return (id<MYJDFlowLayoutDelegate>)self.collectionView.dataSource;
}

- (NSMutableArray *)attributes {
    if(!_attributes) {
        _attributes = [NSMutableArray array];
    }
    return _attributes;
}

@end
