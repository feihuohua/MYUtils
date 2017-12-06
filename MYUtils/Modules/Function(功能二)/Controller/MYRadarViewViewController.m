//
//  MYRadarViewViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYRadarViewViewController.h"
#import "MYRadarView.h"
#import <Masonry.h>

@interface MYRadarViewViewController ()

@property (nonatomic, strong) MYRadarView *radarView;

@end

@implementation MYRadarViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat X = ([UIScreen mainScreen].bounds.size.width - 240) / 2;
    CGFloat Y = ([UIScreen mainScreen].bounds.size.height - 240) / 2;
    self.radarView = [[MYRadarView alloc] initWithFrame:CGRectMake(X, Y, 240, 240)];
    self.radarView.fillColor = [UIColor blueColor];
    self.radarView.instanceCount = 4;
    self.radarView.instanceDelay = 1;
    self.radarView.animationDuration = self.radarView.instanceCount * self.radarView.instanceDelay;
    self.radarView.opacityValue = 0.6f;
    [self.view addSubview:self.radarView];

    [self.radarView startAnimation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [self.radarView stopAnimation];
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
