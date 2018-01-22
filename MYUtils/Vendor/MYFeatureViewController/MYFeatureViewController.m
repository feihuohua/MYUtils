//
//  MYFeatureViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/20.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYFeatureViewController.h"
#import "MYFeatureViewCell.h"
#import <UIView+Position.h>

// 屏幕尺寸
#define MYScreenBounds [UIScreen mainScreen].bounds
#define MYScreenSize [UIScreen mainScreen].bounds.size
#define MYScreenWidth [UIScreen mainScreen].bounds.size.width
#define MYScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MYFeatureViewController () <UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, weak) UICollectionView *collectionView;
@property (nonatomic, weak) UIPageControl *pageControl;
/**
 * 图片数量
 */
@property (nonatomic, strong) NSArray<UIImage *> *imageArray;
/**
 * 是否显示分页控制器
 */
@property (nonatomic, assign) BOOL showPageControl;
/**
 * 进入主界面
 */
@property (nonatomic, weak) UIButton *enterButton;

@end

@implementation MYFeatureViewController

static NSString * const featureIdentifier = @"feature.identifier";

+ (instancetype)initWithImageArray:(NSArray<UIImage *> *)images {
    
    return [[self alloc] initWithImageArray:images showPageControl:YES];
}

+ (instancetype)initWithImageArray:(NSArray<UIImage *> *)images
                   showPageControl:(BOOL)showPageControl {
    return [[self alloc] initWithImageArray:images showPageControl:showPageControl];
}

- (instancetype)initWithImageArray:(NSArray<UIImage *> *)images
                   showPageControl:(BOOL)showPageControl {
    
    if (self = [super init]) {
        
        _imageArray      = images;
        _showPageControl = showPageControl;
        
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[MYFeatureViewCell class] forCellWithReuseIdentifier:featureIdentifier];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view bringSubviewToFront:self.pageControl];
}

#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double page = scrollView.contentOffset.x / scrollView.width;
    // 四舍五入计算出页码
    self.pageControl.currentPage = (int)(page + 0.5);
    
    CGFloat offsetX = scrollView.contentOffset.x;
    
    if(offsetX == MYScreenWidth * self.imageArray.count - 1){
        
        [self.view addSubview:self.enterButton];
    }
}

#pragma mark - collectionView delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MYFeatureViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:featureIdentifier forIndexPath:indexPath];
    cell.image = self.imageArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 3) {
        [self switchController];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(MYScreenWidth, MYScreenHeight);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (void)switchController
{
    
}

#pragma mark - setter and getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:MYScreenBounds collectionViewLayout:layout];
        collectionView.backgroundColor = [UIColor clearColor];
        collectionView.showsHorizontalScrollIndicator = NO;
        collectionView.showsVerticalScrollIndicator = NO;
        collectionView.pagingEnabled = YES;
        collectionView.bounces = YES;
        collectionView.dataSource = self;
        collectionView.delegate = self;
        [self.view addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        CGFloat pageControlW = MYScreenWidth;
        CGFloat pageControlX = 0;
        CGFloat pageControlH = 40.0F;
        CGFloat pageControlY = MYScreenHeight * 0.9;
        pageControl.frame = CGRectMake(pageControlX, pageControlY, pageControlW, pageControlH);
        pageControl.numberOfPages = self.imageArray.count;
        [self.view addSubview:pageControl];
        _pageControl = pageControl;
    }
    return _pageControl;
}

- (UIButton *)enterButton {
    if (!_enterButton) {
        UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat enterButtonW = MYScreenWidth/375 * 237;
        CGFloat enterButtonH = MYScreenHeight/667 * 48;
        CGFloat enterButtonX = (MYScreenWidth - enterButtonW) * 0.5;
        CGFloat enterButtonY = CGRectGetMaxY(self.pageControl.frame) - enterButtonH - 30;
        enterButton.frame = CGRectMake(enterButtonX, enterButtonY, enterButtonW, enterButtonH);
        [enterButton setTitle:@"进入主界面" forState:UIControlStateNormal];
        enterButton.titleLabel.font = [UIFont systemFontOfSize:20];
        enterButton.layer.borderWidth = 0.5;
        enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
        enterButton.layer.cornerRadius = 2;
        [enterButton addTarget:self action:@selector(switchController) forControlEvents:UIControlEventTouchUpInside];
        self.enterButton = enterButton;
    }
    return _enterButton;
}

@end
