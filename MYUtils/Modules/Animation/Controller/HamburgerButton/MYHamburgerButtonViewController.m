//
//  MYHamburgerButtonViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYHamburgerButtonViewController.h"
#import "MYHamburgerButton.h"
#import <UIView+Position.h>
#import <Masonry.h>

@interface MYHamburgerButtonViewController ()

@property (nonatomic, strong) MYHamburgerButton *backButton;
@property (nonatomic, strong) MYHamburgerButton *closeButton;
@property (nonatomic, strong) MYHamburgerButton *crossToArrowButton;

@end

@implementation MYHamburgerButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.backButton = [MYHamburgerButton buttonWithType:UIButtonTypeCustom];
    [self.backButton addTarget:self action:@selector(didBackButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backButton];
    [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view).offset(80.0f);
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
    }];
    
    self.closeButton = [MYHamburgerButton buttonWithType:UIButtonTypeCustom];
    [self.closeButton addTarget:self action:@selector(didCloseButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.closeButton];
    [self.closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.backButton.mas_bottom).offset(80.0f);
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
    }];
    
    self.crossToArrowButton = [MYHamburgerButton buttonWithType:UIButtonTypeCustom];
    [self.crossToArrowButton addTarget:self action:@selector(didCrossToArrowButtonTouch:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.crossToArrowButton];
    [self.crossToArrowButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.closeButton.mas_bottom).offset(80.0f);
        make.size.mas_equalTo(CGSizeMake(40.0f, 40.0f));
    }];
    
    [self.crossToArrowButton setCurrentMode:MYHamburgerButtonModeArrow];
}

- (void)didBackButtonTouch:(MYHamburgerButton *)sender {
    if(sender.currentMode == MYHamburgerButtonModeHamburger) {
        [sender setCurrentModeWithAnimation:MYHamburgerButtonModeArrow];
    } else{
        [sender setCurrentModeWithAnimation:MYHamburgerButtonModeHamburger];
    }
}

- (void)didCloseButtonTouch:(MYHamburgerButton *)sender {
    if(sender.currentMode == MYHamburgerButtonModeHamburger) {
        [sender setCurrentModeWithAnimation:MYHamburgerButtonModeCross];
    } else{
        [sender setCurrentModeWithAnimation:MYHamburgerButtonModeHamburger];
    }
}

- (void)didCrossToArrowButtonTouch:(MYHamburgerButton *)sender {
    if(sender.currentMode == MYHamburgerButtonModeArrow){
        [sender setCurrentModeWithAnimation:MYHamburgerButtonModeCross];
    } else{
        [sender setCurrentModeWithAnimation:MYHamburgerButtonModeArrow];
    }
}

@end
