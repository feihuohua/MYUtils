//
//  MYFadeNavigationController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYFadeNavigationController.h"

#define kGKDefaultVisibility YES
#define IS_OS_OLDER_THAN_IOS_8 [[[UIDevice currentDevice] systemVersion] floatValue] <= 8.f

@interface MYFadeNavigationController () <UINavigationControllerDelegate>

@property (nonatomic, strong) UIVisualEffectView *visualEffectView;
@property (nonatomic, strong) UIView *fakeNavigationBarBackground;

@property (nonatomic, assign) MYFadeNavigationControllerNavigationBarVisibility navigationBarVisibility;
@property (nonatomic, strong) UIColor *originalTintColor;

@end

@implementation MYFadeNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Base values
    self.originalTintColor = [self.navigationBar tintColor];
    self.delegate = self;
    
    [self setupCustomNavigationBar];
    self.navigationBarVisibility = MYFadeNavigationControllerNavigationBarVisibilityVisible;
    
    [self updateNavigationBarVisibilityForController:self.topViewController animated:NO];
}

- (void)setNavigationBarVisibility:(MYFadeNavigationControllerNavigationBarVisibility)navigationBarVisibility {
    [self setNavigationBarVisibility:navigationBarVisibility animated:NO];
}

- (NSString *)stringForNavigationBarVisibility:(MYFadeNavigationControllerNavigationBarVisibility)visibility {
    switch (visibility) {
        case MYFadeNavigationControllerNavigationBarVisibilitySystem:
            return @"system";
        case MYFadeNavigationControllerNavigationBarVisibilityVisible:
            return @"visible";
        case MYFadeNavigationControllerNavigationBarVisibilityHidden:
            return @"hidden";
        default:
            return @"unknown";
    }
}

- (void)setNavigationBarVisibility:(MYFadeNavigationControllerNavigationBarVisibility)navigationBarVisibility animated:(BOOL)animated {
    
    if (_navigationBarVisibility == navigationBarVisibility) {
        return;
    }
    
    if (_navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilitySystem) {
        if (navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilityVisible) {
            [self setupCustomNavigationBar];
        } else if (navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilityHidden) {
            [self setupCustomNavigationBar];
            [self showCustomNavigationBar:NO withFadeAnimation:animated];
        }
    } else if (_navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilityHidden) {
        if (navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilitySystem) {
            [self showCustomNavigationBar:YES withFadeAnimation:animated];
            [self setupSystemNavigationBar];
        } else if (navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilityVisible) {
            [self showCustomNavigationBar:YES withFadeAnimation:animated];
        }
    } else if (_navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilityVisible) {
        if (navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilitySystem) {
            [self setupSystemNavigationBar];
        } else if (navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilityHidden) {
            [self showCustomNavigationBar:NO withFadeAnimation:animated];
        }
    }
    
    if (navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilityDefault) {
        NSLog(@"Error: This should not happen: somebody tried to transition from System/Hidden/Visible state to Undefined");
    }
    _navigationBarVisibility = navigationBarVisibility;
}

- (UIVisualEffectView *)visualEffectView {
    if (!_visualEffectView) {
        // Create a the fake navigation bar background
        UIVisualEffect *blurEffect;
        blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
        
        CGFloat navigationBarHeight = CGRectGetHeight(self.navigationBar.frame);
        CGFloat statusBarHeight = [self statusBarHeight];
        
        _visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        _visualEffectView.frame = CGRectMake(0, 0, self.view.frame.size.width, navigationBarHeight+statusBarHeight);
        _visualEffectView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _visualEffectView.userInteractionEnabled = NO;
        
        // Shadow line
        UIView *shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, navigationBarHeight+statusBarHeight-0.5, self.view.frame.size.width, 0.5f)];
        shadowView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2f];
        shadowView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [_visualEffectView.contentView addSubview:shadowView];
    }
    return _visualEffectView;
}

- (CGFloat)statusBarHeight {
    CGSize statusBarSize = [[UIApplication sharedApplication] statusBarFrame].size;
    return MIN(statusBarSize.width, statusBarSize.height);
}

#pragma mark - UI support
- (UIStatusBarStyle)preferredStatusBarStyle {
    if (self.navigationBarVisibility == MYFadeNavigationControllerNavigationBarVisibilityHidden) {
        return UIStatusBarStyleLightContent;
    } else {
        return UIStatusBarStyleDefault;
    }
}

#pragma mark - <UINavigationControllerDelegate>
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [self updateNavigationBarVisibilityForController:viewController animated:animated];
    
    id<UIViewControllerTransitionCoordinator> transitionCoordinator = navigationController.topViewController.transitionCoordinator;
    [transitionCoordinator notifyWhenInteractionEndsUsingBlock:^(id<UIViewControllerTransitionCoordinatorContext> context) {
        if ([context isCancelled]) {
            UIViewController *sourceViewController = [context viewControllerForKey:UITransitionContextFromViewControllerKey];
            [self updateNavigationBarVisibilityForController:sourceViewController animated:NO];
        }
    }];
}

#pragma mark - Core functions
- (void)setupCustomNavigationBar {
    [self.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationBar.translucent = YES;
    self.navigationBar.shadowImage = [UIImage new];
    [self.navigationBar.subviews.firstObject insertSubview:self.visualEffectView atIndex:0];
}

- (void)setupSystemNavigationBar {
    [self.visualEffectView removeFromSuperview];
    
    [self.navigationBar setBackgroundImage:[[UINavigationBar appearance] backgroundImageForBarMetrics:UIBarMetricsDefault] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setTranslucent:YES];
    [self.navigationBar setShadowImage:[[UINavigationBar appearance] shadowImage]];
    [self.navigationBar setTitleTextAttributes:[[UINavigationBar appearance] titleTextAttributes]];
    [self.navigationBar setTintColor:self.originalTintColor];
}

- (void)updateNavigationBarVisibilityForController:(UIViewController *)viewController animated:(BOOL)animated {
    MYFadeNavigationControllerNavigationBarVisibility visibility = MYFadeNavigationControllerNavigationBarVisibilitySystem;
    
    if ([viewController conformsToProtocol:@protocol(MYFadeNavigationControllerDelegate)]) {
        if ([viewController respondsToSelector:@selector(preferredNavigationBarVisibility)]) {
            visibility = (MYFadeNavigationControllerNavigationBarVisibility)[viewController performSelector:@selector(preferredNavigationBarVisibility)];
        }
    }
    [self setNavigationBarVisibility:visibility animated:animated];
}

- (void)showCustomNavigationBar:(BOOL)show withFadeAnimation:(BOOL)animated {
    [UIView animateWithDuration:(animated ? 0.2 : 0) animations:^{
        if (show) {
            self.visualEffectView.alpha = 1;
            self.navigationBar.tintColor = [self originalTintColor];
            self.navigationBar.titleTextAttributes = [[UINavigationBar appearance] titleTextAttributes];
        } else {
            self.visualEffectView.alpha = 0;
            self.navigationBar.tintColor = [UIColor whiteColor];
            self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor clearColor]};
        }
    } completion:^(BOOL finished) {
        [self setNeedsStatusBarAppearanceUpdate];
    }];
}

- (void)setNeedsNavigationBarVisibilityUpdateAnimated:(BOOL)animated {
    if (!self.topViewController) {
        NSLog(@"MYFadeNavigationController error: topViewController is not set");
        return;
    }
    if ([self.topViewController conformsToProtocol:@protocol(MYFadeNavigationControllerDelegate)]) {
        if ([self.topViewController respondsToSelector:@selector(preferredNavigationBarVisibility)]) {
            MYFadeNavigationControllerNavigationBarVisibility topControllerPrefersVisibility = (MYFadeNavigationControllerNavigationBarVisibility)[self.topViewController performSelector:@selector(preferredNavigationBarVisibility)];
            [self setNavigationBarVisibility:topControllerPrefersVisibility animated:animated];
        } else {
            NSLog(@"MYFadeNavigationController error: setNeedsNavigationBarVisibilityUpdateAnimated is called but %@ does not have -preferredNavigationBarVisibility method!", self.topViewController);
            return;
        }
    } else {
        NSLog(@"MYFadeNavigationController error: setNeedsNavigationBarVisibilityUpdateAnimated is called but %@ does not conform to MYFadeNavigationControllerDelegate protocol!", self.topViewController);
    }
}

@end
