//
//  MYBannerCycleViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYBannerCycleViewController.h"
#import "UtilsMacros.h"
#import "FXCyclePagerViewCell.h"
#import "FXCyclePagerView.h"
#import "FXPageControl.h"

@interface MYBannerCycleViewController ()<FXCyclePagerViewDataSource, FXCyclePagerViewDelegate>

@property (nonatomic, strong) FXCyclePagerView *pagerView;
@property (nonatomic, strong) FXPageControl *pageControl;
@property (nonatomic, strong) NSArray *datas;

@end

@implementation MYBannerCycleViewController

static NSString * const identifier = @"MYBannerViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"轮播图";
    
    [self addPagerView];
    [self addPageControl];
    
    [self loadData];
}

#pragma mark - FXCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(FXCyclePagerView *)pageView {
    return _datas.count;
}

- (UICollectionViewCell *)pagerView:(FXCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    FXCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    cell.backgroundColor = _datas[index];
    cell.label.text = [NSString stringWithFormat:@"index->%ld",index];
    return cell;
}

- (FXCyclePagerViewLayout *)layoutForPagerView:(FXCyclePagerView *)pageView {
    FXCyclePagerViewLayout *layout = [[FXCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, 200);
    layout.itemSpacing = 15;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(FXCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    _pageControl.currentPage = toIndex;
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"%ld ->  %ld",fromIndex,toIndex);
}

- (void)addPageControl {
    FXPageControl *pageControl = [[FXPageControl alloc]init];
    //pageControl.numberOfPages = _datas.count;
    pageControl.currentPageIndicatorSize = CGSizeMake(8, 8);
    //    pageControl.pageIndicatorImage = [UIImage imageNamed:@"Dot"];
    //    pageControl.currentPageIndicatorImage = [UIImage imageNamed:@"DotSelected"];
    //    pageControl.contentInset = UIEdgeInsetsMake(0, 20, 0, 20);
    //    pageControl.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    //    pageControl.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    //    [pageControl addTarget:self action:@selector(pageControlValueChangeAction:) forControlEvents:UIControlEventValueChanged];
    [_pagerView addSubview:pageControl];
    _pageControl = pageControl;
}

- (void)loadData {
    NSMutableArray *datas = [NSMutableArray array];
    for (int i = 0; i < 5; ++i) {
        if (i == 0) {
            [datas addObject:[UIColor redColor]];
            continue;
        }
        [datas addObject:[UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:arc4random()%255/255.0]];
    }
    _datas = [datas copy];
    _pageControl.numberOfPages = _datas.count;
    [_pagerView reloadData];
}

- (void)addPagerView {
    FXCyclePagerView *pagerView = [[FXCyclePagerView alloc]init];
    pagerView.layer.borderWidth = 1;
    pagerView.isInfiniteLoop = YES;
    pagerView.autoScrollInterval = 3.0;
    pagerView.dataSource = self;
    pagerView.delegate = self;
    pagerView.layout.itemSize = CGSizeMake([UIScreen mainScreen].bounds.size.width - 60, 200);
    pagerView.layout.itemSpacing = 30;
    [pagerView setNeedUpdateLayout];
    // registerClass or registerNib
    [pagerView registerClass:[FXCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    [self.view addSubview:pagerView];
    _pagerView = pagerView;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _pagerView.frame = CGRectMake(0, 64, CGRectGetWidth(self.view.frame), 200);
    _pageControl.frame = CGRectMake(0, CGRectGetHeight(_pagerView.frame) - 26, CGRectGetWidth(_pagerView.frame), 26);
}

@end
