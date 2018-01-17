//
//  MYSliderViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/2.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYSliderViewController.h"
#import "FXSlider.h"
#import "MYSliderView.h"
#import "UtilsMacros.h"
#import <MYKit/MYKit.h>
#import <Masonry.h>

@interface MYSliderViewController ()<MYSliderViewDelegate>

@property (nonatomic, strong) FXSlider *sliderView;
@property (nonatomic, strong) MYSliderView *mySliderView;

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

    _mySliderView = [[MYSliderView alloc] initWithFrame:CGRectMake(40, 100, 200, 50) handleWith:50 handleImage:[UIImage imageNamed:@"icon_arrow_slide"]];

    // 设置背景颜色，滑块颜色，滑块左部view颜色，整个边框颜色
    [_mySliderView setBackgroundColor:[UIColor grayColor] foregroundColor:[UIColor blueColor] handleColor:[UIColor redColor] borderColor:nil];
    _mySliderView.delegate = self;
    // 设置文本的相关属性
    _mySliderView.label.text = @"确认到店";
    _mySliderView.label.font = [UIFont systemFontOfSize:25];
    _mySliderView.label.textColor = [UIColor whiteColor];
    [self.view addSubview:_mySliderView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    weakSelf(weakSelf)
    
    [self.sliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.view).offset(120.0f);
        make.height.mas_equalTo(120.0f);
    }];
    
    [self.mySliderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(weakSelf.view);
        make.top.equalTo(weakSelf.sliderView.mas_bottom).offset(20.0f);
        make.size.mas_equalTo(CGSizeMake(200, 50));
    }];
}

- (void)eventValueChanged:(FXSlider *)slider {
    NSLog(@"Selected index: %lu",slider.index);
}

#pragma mark -- MYSliderViewDelegate
// 随时监听滑块的滑动位置
- (void)sliderValueChanged:(MYSliderView *)sender {
    NSLog(@"滑块位置：%f",sender.value);
}

// 监听滑动结束时滑块的位置
- (void)sliderValueChangeEnded:(MYSliderView *)sender {
    if(_mySliderView.value == 1){
        NSLog(@"欧耶！");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
