//
//  MYTransparentNavigationBarViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/2.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYTransparentNavigationBarViewController.h"
#import <UIBarButtonItem+Extension.h>
#import "UtilsMacros.h"
#import <Masonry.h>
#import "UINavigationBar+Extension.h"

#define NAVBAR_COLORCHANGE_POINT (IMAGE_HEIGHT - NAV_HEIGHT * 2)
#define IMAGE_HEIGHT 220
#define NAV_HEIGHT 64

@interface MYTransparentNavigationBarViewController ()<UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIButton *betRoomButton;
@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong, nonnull) UITableView *tableView;

@end

@implementation MYTransparentNavigationBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupNavigationBarButtonItem];
    
    [self.navigationController.navigationBar setOverlayViewBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"homestay_houseresource_mask"]]];
    [self.navigationController.navigationBar setNavigationBarForDividingLineHidden:NO];
    
    [self.view addSubview:self.betRoomButton];
    [self.view addSubview:self.webView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setupSubViews];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_COLORCHANGE_POINT) {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        
        self.navigationItem.title = @"房源详情";
        
        [self.navigationController.navigationBar setOverlayViewBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:alpha]];
        [self.navigationController.navigationBar setOverlayViewAlpha:alpha];
        
        [self.navigationController.navigationBar setNavigationBarForDividingLineHidden:YES];
        
        [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIButton *selectedButton = (UIButton *)self.navigationItem.rightBarButtonItems[idx].customView;
            if (idx == 0) {
                [selectedButton setBackgroundImage:[UIImage imageNamed:@"houses_share_b"] forState:UIControlStateNormal];
            } else {
                [selectedButton setBackgroundImage:[UIImage imageNamed:@"houses_collect_normal_b"] forState:UIControlStateNormal];
            }
        }];
        
        [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *selectedButton = (UIButton *)self.navigationItem.leftBarButtonItems[idx].customView;
            [selectedButton setBackgroundImage:[UIImage imageNamed:@"hk_navigation_back"] forState:UIControlStateNormal];
        }];
        
    } else {
        
        self.navigationItem.title = @"";
        [self.navigationController.navigationBar setOverlayViewBackgroundColor:[[UIColor whiteColor] colorWithAlphaComponent:0]];
        [self.navigationController.navigationBar setOverlayViewAlpha:1];
        [self.navigationController.navigationBar setOverlayViewBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"homestay_houseresource_mask"]]];
        [self.navigationController.navigationBar setNavigationBarForDividingLineHidden:NO];
        
        [self.navigationItem.rightBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            UIButton *selectedButton = (UIButton *)self.navigationItem.rightBarButtonItems[idx].customView;
            if (idx == 0) {
                [selectedButton setBackgroundImage:[UIImage imageNamed:@"houses_share"] forState:UIControlStateNormal];
            } else {
                [selectedButton setBackgroundImage:[UIImage imageNamed:@"houses_collect_normal"] forState:UIControlStateNormal];
            }
        }];
        
        [self.navigationItem.leftBarButtonItems enumerateObjectsUsingBlock:^(UIBarButtonItem * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIButton *selectedButton = (UIButton *)self.navigationItem.leftBarButtonItems[idx].customView;
            [selectedButton setBackgroundImage:[UIImage imageNamed:@"hk_navigation_white_back"] forState:UIControlStateNormal];
        }];
    }
}


- (void)setupNavigationBarButtonItem {
    
    NSMutableArray *rightBarButtonItems = [NSMutableArray array];
    
    UIBarButtonItem *shareButton = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(share:) image:@"houses_share"];
    
    [rightBarButtonItems addObject:shareButton];
    
    UIBarButtonItem *blankItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    blankItem.width = 17.0f;
    [rightBarButtonItems addObject:blankItem];
    
    UIBarButtonItem *collectButton = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(collect:) image:@"houses_collect_normal"];
    
    [rightBarButtonItems addObject:collectButton];
    
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
    
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem barButtonItemWithTarget:self action:@selector(didTapBackButton) image:@"hk_navigation_white_back"];
}

- (void)setupSubViews {
    
    weakSelf(weakSelf)
    [self.betRoomButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.view);
        make.height.mas_equalTo(49.0f);
    }];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.view);
        make.left.equalTo(weakSelf.view);
        make.right.equalTo(weakSelf.view);
        make.bottom.equalTo(weakSelf.betRoomButton.mas_top);
    }];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)betRoom {
    
}

- (void)collect:(UIButton *)button {
    
}

- (void)share:(UIButton *)button {
    
}


- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.delegate = self;
        _webView.scrollView.bounces = YES;
        _webView.scrollView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_webView];
    }
    return _webView;
}

- (UIButton *)betRoomButton {
    if (!_betRoomButton) {
        _betRoomButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _betRoomButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        [_betRoomButton setBackgroundImage:[UIImage imageNamed:@"hk_web_betroom_button"] forState:UIControlStateNormal];
        [_betRoomButton setTitle:@"我要压房" forState:UIControlStateNormal];
        [_betRoomButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_betRoomButton addTarget:self action:@selector(betRoom) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_betRoomButton];
    }
    return _betRoomButton;
}


@end
