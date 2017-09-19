//
//  MYAnimationViewController.m
//  MYUtils
//
//  Created by Michael on 2017/9/12.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYAnimationViewController.h"
#import "MYActionSheet.h"

#define KEY_WINDOW  [UIApplication sharedApplication].keyWindow

@interface MYAnimationViewController ()<UIAlertViewDelegate, MYActionSheetDelegate>

@end

@implementation MYAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动画";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cancellationButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancellationButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 50)/2, 200, 50, 50);
    cancellationButton.backgroundColor = [UIColor redColor];
    [cancellationButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancellationButton];
    
    
    UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    photoButton.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - 50)/2, CGRectGetMaxY(cancellationButton.frame) + 20, 200, 50);
    photoButton.backgroundColor = [UIColor redColor];
    [photoButton addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:photoButton];
    
}

- (void)click {

    MYActionSheet *actionSheet = [MYActionSheet sheetWithTitle:@"确定要注销吗？"
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"确定", nil];
    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
    [indexSet addIndex:1];
    
    actionSheet.destructiveButtonIndexSet = indexSet;
    actionSheet.destructiveButtonColor    = [UIColor redColor];
    [actionSheet show];
}

#pragma mark - MYActionSheetDelegate

- (void)actionSheet:(MYActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"clickedButtonAtIndex: %d, keyWindow: %p", (int)buttonIndex, KEY_WINDOW);
}

- (void)willPresentActionSheet:(MYActionSheet *)actionSheet {
    NSLog(@"willPresentActionSheet, keyWindow: %p", KEY_WINDOW);
}

- (void)didPresentActionSheet:(MYActionSheet *)actionSheet {
    NSLog(@"didPresentActionSheet, keyWindow: %p", KEY_WINDOW);
}

- (void)actionSheet:(MYActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"willDismissWithButtonIndex: %d, keyWindow: %p", (int)buttonIndex, KEY_WINDOW);
}

- (void)actionSheet:(MYActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex {
    NSLog(@"didDismissWithButtonIndex: %d, keyWindow: %p", (int)buttonIndex, KEY_WINDOW);
}


@end
