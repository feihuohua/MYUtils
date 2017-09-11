//
//  FXSliderViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/9/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "FXSliderViewController.h"
#import "FXSlider.h"

@interface FXSliderViewController ()

@end

@implementation FXSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    FXSlider *slider = [[FXSlider alloc] initWithFrame:CGRectMake(100, 200, 200, 100)];
    slider.maxCount = 5;
    slider.tintColor = [UIColor redColor];
    slider.sliderCircleColor = [UIColor blueColor];
    slider.labels = @[@"1", @"2", @"3", @"4", @"5"];
    slider.labelColor = [UIColor redColor];
    [self.view addSubview:slider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
