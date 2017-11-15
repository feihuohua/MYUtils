//
//  MYCrossDissolveFirstViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/4.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYCrossDissolveFirstViewController.h"
#import "UtilsMacros.h"
#import "MYCrossDissolveSecondViewController.h"
#import "MYCrossDissolveTransitionAnimator.h"
#import <Masonry.h>

@interface MYCrossDissolveFirstViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation MYCrossDissolveFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor purpleColor];
    
    UIButton *customButton = [UIButton buttonWithType:UIButtonTypeCustom];
    customButton.backgroundColor = [UIColor redColor];
    [customButton setTitle:@"Present With Custom Transition" forState:UIControlStateNormal];
    [customButton addTarget:self action:@selector(presentWithCustomTransitionAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:customButton];
    
    weakSelf(self)
    [customButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(weakSelf.view);
    }];
}

- (void)presentWithCustomTransitionAction:(UIButton *)sender {
    MYCrossDissolveSecondViewController *secondViewController = [[MYCrossDissolveSecondViewController alloc] init];
    secondViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    
    // The transitioning delegate can supply a custom animation controller
    // that will be used to animate the incoming view controller.
    secondViewController.transitioningDelegate = self;
    
    [self presentViewController:secondViewController animated:YES completion:NULL];
}

#pragma mark -
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


@end
