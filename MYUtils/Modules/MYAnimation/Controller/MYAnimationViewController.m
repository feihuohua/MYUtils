//
//  MYAnimationViewController.m
//  MYUtils
//
//  Created by Michael on 2017/9/12.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYAnimationViewController.h"
#import "MYActionSheet.h"
#import "MYTestViewController.h"
#import "MYCrossDissolveTransitionAnimator.h"

#define KEY_WINDOW  [UIApplication sharedApplication].keyWindow

@interface MYAnimationViewController ()<UIAlertViewDelegate, MYActionSheetDelegate, UIViewControllerTransitioningDelegate>

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

//    MYActionSheet *actionSheet = [MYActionSheet sheetWithTitle:@"确定要注销吗？"
//                                                      delegate:self
//                                             cancelButtonTitle:@"取消"
//                                             otherButtonTitles:@"确定", nil];
//    NSMutableIndexSet *indexSet = [[NSMutableIndexSet alloc] init];
//    [indexSet addIndex:1];
//    
//    actionSheet.destructiveButtonIndexSet = indexSet;
//    actionSheet.destructiveButtonColor    = [UIColor redColor];
//    [actionSheet show];
    
    MYTestViewController *test = [[MYTestViewController alloc] init];
    // Setting the modalPresentationStyle to FullScreen enables the
    // <ContextTransitioning> to provide more accurate initial and final frames
    // of the participating view controllers
    test.modalPresentationStyle = UIModalPresentationFullScreen;
    
    // The transitioning delegate can supply a custom animation controller
    // that will be used to animate the incoming view controller.
    test.transitioningDelegate = self;
    
    [self presentViewController:test animated:YES completion:NULL];
}

#pragma mark UIViewControllerTransitioningDelegate

//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the presentation of the incoming view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  presentation animation should be used.
//
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [MYCrossDissolveTransitionAnimator new];
}


//| ----------------------------------------------------------------------------
//  The system calls this method on the presented view controller's
//  transitioningDelegate to retrieve the animator object used for animating
//  the dismissal of the presented view controller.  Your implementation is
//  expected to return an object that conforms to the
//  UIViewControllerAnimatedTransitioning protocol, or nil if the default
//  dismissal animation should be used.
//
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [MYCrossDissolveTransitionAnimator new];
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
