//
//  MYCrossDissolveSecondViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/4.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYCrossDissolveSecondViewController.h"
#import "UtilsMacros.h"
#import <Masonry.h>

@interface MYCrossDissolveSecondViewController ()

@end

@implementation MYCrossDissolveSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.backgroundColor = [UIColor redColor];
    [customButton setTitle:@"Dismiss" forState:UIControlStateNormal];
    [customButton addTarget:self action:@selector(dismissAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton];
    
    weakSelf(self)
    [customButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
    }];

}

- (void)dismissAction:(UIButton *)sender
{
    // For the sake of example, this demo implements the presentation and
    // dismissal logic completely in code.  Take a look at the later demos
    // to learn how to integrate custom transitions with segues.
    [self dismissViewControllerAnimated:YES completion:NULL];
}


@end
