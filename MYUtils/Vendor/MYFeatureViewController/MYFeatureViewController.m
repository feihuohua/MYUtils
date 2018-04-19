//
//  MYFeatureViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/20.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYFeatureViewController.h"
#import "MYFeatureViewCell.h"
#import "UIImage+Feature.h"
#import <UIView+Position.h>

// 屏幕尺寸
#define MYScreenBounds [UIScreen mainScreen].bounds
#define MYScreenSize [UIScreen mainScreen].bounds.size
#define MYScreenWidth [UIScreen mainScreen].bounds.size.width
#define MYScreenHeight [UIScreen mainScreen].bounds.size.height

@interface MYFeatureViewController () <UIScrollViewDelegate>

@property (nonatomic, weak) UICollectionView *collectionView;
/**
 * 分页控制器
 */
@property (nonatomic, weak) UIPageControl *pageControl;
/**
 * 图片名
 */
@property (nonatomic, copy) NSString *imageName;
/**
 * 图片个数
 */
@property (nonatomic, assign) NSInteger imageCount;
/**
 * 是否显示分页控制器
 */
@property (nonatomic, assign) BOOL showPageControl;
/**
 * 跳过按钮
 */
@property (nonatomic, weak) UIButton *skipBtn;

/**
 * 进入主界面
 */
@property (nonatomic, weak) UIButton *enterButton;

@property (nonatomic, copy) MYNewFeatureFinishBlock finishBlock;

@end

@implementation MYFeatureViewController

static NSString * const featureIdentifier = @"feature.identifier";

+ (BOOL)shouldShowNewFeature {
    NSString *key = @"CFBundleShortVersionString";
    
    // 获取沙盒中版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    // 获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        return NO;
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
}

+ (instancetype)newFeatureWithImageName:(NSString *)imageName
                             imageCount:(NSInteger)imageCount
                        showPageControl:(BOOL)showPageControl {
    
    return [[self alloc] initWithImageName:imageName
                                imageCount:imageCount
                           showPageControl:showPageControl];
}

+ (instancetype)newFeatureWithImageName:(NSString *)imageName
                             imageCount:(NSInteger)imageCount
                        showPageControl:(BOOL)showPageControl
                            finishBlock:(MYNewFeatureFinishBlock)finishBlock {
    
    return [[self alloc] initWithImageName:imageName
                                imageCount:imageCount
                           showPageControl:showPageControl
                               finishBlock:finishBlock];
}

- (instancetype)initWithImageName:(NSString *)imageName
                       imageCount:(NSInteger)imageCount
                  showPageControl:(BOOL)showPageControl {
    
    if (self = [super init]) {
        
        _imageName       = imageName;
        _imageCount      = imageCount;
        _showPageControl = showPageControl;
        
        [self setupUI];
    }
    
    return self;
}

- (instancetype)initWithImageName:(NSString *)imageName
                       imageCount:(NSInteger)imageCount
                  showPageControl:(BOOL)showPageControl
                      finishBlock:(MYNewFeatureFinishBlock)finishBlock {
    
    if (self = [super init]) {
        
        _imageName       = imageName;
        _imageCount      = imageCount;
        _showPageControl = showPageControl;
        _finishBlock     = finishBlock;
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 默认状态栏样式为黑色
    self.statusBarStyle = MYStatusBarStyleBlack;
    
    // 图片数组非空时
    if (_imageCount) {
        
        UIButton *enterButton = [UIButton buttonWithType:UIButtonTypeCustom];
        enterButton.backgroundColor = [UIColor redColor];
        [enterButton setFrame:(CGRect){10.0f, MYScreenSize.height * 0.82, MYScreenSize.width - 20.0f, 40.0f}];
        [enterButton setTitle:@"进入主界面" forState:UIControlStateNormal];
        enterButton.titleLabel.font = [UIFont systemFontOfSize:20];
        enterButton.layer.borderWidth = 0.5;
        enterButton.layer.borderColor = [UIColor whiteColor].CGColor;
        enterButton.layer.cornerRadius = 2;
        [enterButton addTarget:self action:@selector(switchController) forControlEvents:UIControlEventTouchUpInside];
        self.enterButton = enterButton;
        
        // 滚动视图
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        [scrollView setDelegate:self];
        [scrollView setBounces:NO];
        [scrollView setPagingEnabled:YES];
        [scrollView setShowsHorizontalScrollIndicator:NO];
        [scrollView setFrame:(CGRect){0, 0, MYScreenSize}];
        [scrollView setContentSize:(CGSize){MYScreenSize.width * _imageCount, 0}];
        [self.view addSubview:scrollView];
        
        // 滚动图片
        CGFloat imageW = MYScreenSize.width;
        CGFloat imageH = MYScreenSize.height;
        
        for (int i = 0; i < _imageCount; i++) {
            
            CGFloat imageX = imageW * i;
            NSString *realImageName = [NSString stringWithFormat:@"%@_%d", _imageName, i + 1];
            UIImage *realImage = [UIImage imageNamedForAdaptation:realImageName iphone5:YES iphone6:YES iphone6p:YES];
            
            UIImageView *imageView = [[UIImageView alloc] init];
            [imageView setImage:realImage];
            [imageView setFrame:(CGRect){imageX, 0, imageW, imageH}];
            [scrollView addSubview:imageView];
            
            if (_enterButton && i == _imageCount - 1) {
                
                [imageView setUserInteractionEnabled:YES];
                [imageView addSubview:_enterButton];
            }
        }
        
        // 分页视图
        if (_showPageControl) {
            
            UIPageControl *pageControl = [[UIPageControl alloc] init];
            [pageControl setNumberOfPages:_imageCount];
            [pageControl setHidesForSinglePage:YES];
            [pageControl setUserInteractionEnabled:NO];
            [pageControl setPageIndicatorTintColor:[UIColor lightGrayColor]];
            [pageControl setCurrentPageIndicatorTintColor:[UIColor darkGrayColor]];
            [pageControl setFrame:(CGRect){0, MYScreenSize.height * 0.9, MYScreenSize.width, 37.0f}];
            [self.view addSubview:pageControl];
            _pageControl = pageControl;
        }
        
        // 跳过按钮
        UIButton *skipBtn = [[UIButton alloc] init];
        skipBtn.hidden = YES;
        skipBtn.backgroundColor = [UIColor lightGrayColor];
        skipBtn.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [skipBtn setTitle:@"跳过" forState:UIControlStateNormal];
        [skipBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [skipBtn addTarget:self action:@selector(skipBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        skipBtn.frame = CGRectMake(MYScreenSize.width - 95, 30, 80, 40);
        skipBtn.layer.cornerRadius = 20.0f;
        [self.view addSubview:skipBtn];
        self.skipBtn = skipBtn;
        
    } else {
        
        NSLog(@"警告: 请放入新特性图片!");
    }
}

- (void)switchController {
    
    if (self.skipBlock) {
        self.skipBlock();
    }
}

- (void)skipBtnClicked {
    
    if (self.skipBlock) {
        self.skipBlock();
    }
}

- (void)setShowSkip:(BOOL)showSkip {
    _showSkip = showSkip;
    
    self.skipBtn.hidden = !self.showSkip;
}

#pragma mark - 新特性视图控制器的显示和消失

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    switch (self.statusBarStyle) {
            
        case MYStatusBarStyleBlack:
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            break;
            
        case MYStatusBarStyleWhite:
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
            break;
            
        case MYStatusBarStyleNone:
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
            break;
            
        default:
            break;
    }
    
    if (_showPageControl) {
        
        // 如果设置了分页控制器当前点的颜色
        if (self.pointCurrentColor) {
            
            [_pageControl setCurrentPageIndicatorTintColor:self.pointCurrentColor];
        }
        
        // 如果设置了分页控制器其他点的颜色
        if (self.pointOtherColor) {
            
            [_pageControl setPageIndicatorTintColor:self.pointOtherColor];
        }
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    if (self.statusBarStyle == MYStatusBarStyleNone) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }
}

#pragma mark - UIScrollViewDelegate 方法

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    
    // 最后一张再向左划的话
    if (scrollView.contentOffset.x == MYScreenSize.width * (_imageCount - 1)) {
        
        if (self.finishBlock) {
            [UIView animateWithDuration:0.4f animations:^{
                self.view.transform = CGAffineTransformMakeTranslation(-MYScreenSize.width, 0);
            } completion:^(BOOL finished) {
                self.finishBlock();
            }];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    CGPoint currentPoint = scrollView.contentOffset;
    NSInteger page = currentPoint.x / scrollView.bounds.size.width;
    _pageControl.currentPage = page;
    
    
}

@end
