//
//  MYSoundServiceKitViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/3/20.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYSoundServiceKitViewController.h"
#import "MYSoundService.h"

@interface MYSoundServiceKitViewController ()

@end

@implementation MYSoundServiceKitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    playButton.backgroundColor = [UIColor blueColor];
    playButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2, 250, 100, 50);
    [playButton setTitle:@"播放声音" forState:UIControlStateNormal];
    [playButton addTarget:self action:@selector(playSoundTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:playButton];
    
    UIButton *telephoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    telephoneButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 100)/2, CGRectGetMaxY(playButton.frame) + 50, 100, 50);
    telephoneButton.backgroundColor = [UIColor blueColor];
    [telephoneButton setTitle:@"拨打电话" forState:UIControlStateNormal];
    [telephoneButton addTarget:self action:@selector(phoneCallTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:telephoneButton];
}

- (void)playSoundTapped:(UIButton *)sender {
    [[MYSoundService sharedInstance] playSoundWithName:@"brithdayMusic" ofType:@"mp3"];
}

- (void)phoneCallTapped:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://+8618600881435"]]];
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
