//
//  MYTestViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/10/30.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYTestViewController.h"

@interface MYTestViewController ()

@end

@implementation MYTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"测试测试";
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *cancellationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancellationButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 50)/2, 200, 50, 50);
    
    cancellationButton.backgroundColor = [UIColor yellowColor];
    [cancellationButton setTitle:@"销毁" forState:UIControlStateNormal];
    [cancellationButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancellationButton];
    
}

- (void)click {
    [self dismissViewControllerAnimated:YES completion:NULL];
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
