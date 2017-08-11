//
//  MYBannerCycleViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYBannerCycleViewController.h"
#import "FXBannerCycleView.h"
#import "UtilsMacros.h"
#import "MYBannerViewCell.h"

@interface MYBannerCycleViewController ()<FXBannerCycleViewDelegate,FXBannerCycleViewDataSource>

@property (nonatomic, strong) FXBannerCycleView *cycleView;

@end

@implementation MYBannerCycleViewController

static NSString * const identifier = @"MYBannerViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"轮播图";
    
    [self.view addSubview:self.cycleView];
}

#pragma mark - FXBannerCycleViewDataSource
- (NSInteger)numberOfRowsInCycleView:(FXBannerCycleView *)cycleView
{
    return 4;
}

- (UICollectionViewCell *)cycleView:(FXBannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row
{
    MYBannerViewCell *cell = (MYBannerViewCell *)[cycleView dequeueReusableCellWithReuseIdentifier:identifier forRow:row];
    return cell;
}

- (CGSize)cycleView:(FXBannerCycleView *)cycleView sizeForItemAtRow:(NSInteger)row
{
    return CGSizeMake(MYScreenWidth - 40, 180);
}

- (FXBannerCycleView *)cycleView
{
    if (!_cycleView) {
        _cycleView = [[FXBannerCycleView alloc] initWithType:FXBannerCycleViewTypeDefault];
        _cycleView.frame = CGRectMake(0, 200, MYScreenWidth, 180);
        _cycleView.itemSize = CGSizeMake(MYScreenWidth - 40, 180);
        _cycleView.dataSource = self;
        _cycleView.delegate = self;
        _cycleView.showPageControl = YES;
        _cycleView.itemSpace = 10;
        _cycleView.itemMargin = 20;
        _cycleView.timeInterval = 3.5f;
        [_cycleView registerClass:[MYBannerViewCell class] forCellWithReuseIdentifier:identifier];
        [self.view addSubview:_cycleView];
    }
    return _cycleView;
}

@end
