//
//  MYSliderViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/2.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYSliderViewController.h"
#import "FXSlider.h"
#import "UtilsMacros.h"
#import <MYKit/MYKit.h>
#import <Masonry.h>

@interface MYSliderViewController ()

@property (nonatomic, strong) FXSlider *sliderView;

@end

@implementation MYSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义UISlider";
    self.view.backgroundColor = [UIColor whiteColor];
    
    _sliderView = [[FXSlider alloc] init];
    _sliderView.maxCount = 5;
    _sliderView.trackColor = [UIColor colorWithHexString:@"#F7F7F7"];
    _sliderView.sliderCircleImage = [UIImage imageNamed:@"homestay_slider"];
    _sliderView.labels = @[@"100", @"200", @"300", @"400", @"500"];
    _sliderView.labelColor = [UIColor colorWithHexString:@"#959595"];
    _sliderView.labelFont = [UIFont systemFontOfSize:14.0f];
    _sliderView.labelOffset = 10.0f;
    _sliderView.tintColor = [UIColor colorWithHexString:@"#F1B559"];
    [_sliderView addTarget:self action:@selector(eventValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_sliderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    weakSelf(weakSelf)
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(120.0f);
        make.height.mas_equalTo(120.0f);
    }];
}

- (void)eventValueChanged:(FXSlider *)slider {
    NSLog(@"Selected index: %lu",slider.index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
