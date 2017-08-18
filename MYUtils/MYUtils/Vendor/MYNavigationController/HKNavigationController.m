//
//  HKNavigationController.m
//  FXVIP
//
//  Created by sunjinshuai on 2017/8/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "HKNavigationController.h"
#import "UIViewController+NavigationExtension.h"
#import "UIBarButtonItem+Extension.h"

@interface HKWrapNavigationController : UINavigationController

@end

@implementation HKWrapNavigationController

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    return [self.navigationController popToRootViewControllerAnimated:animated];
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    HKNavigationController *navigationController = viewController.hk_navigationController;
    NSInteger index = [navigationController.hk_viewControllers indexOfObject:viewController];
    return [self.navigationController popToViewController:navigationController.viewControllers[index] animated:animated];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    viewController.hk_navigationController = (HKNavigationController *)self.navigationController;
    UIImage *backButtonImage = viewController.hk_navigationController.backButtonImage;
    
    if (!backButtonImage) {
        backButtonImage = [UIImage imageNamed:@"hk_navigation_back"];
    }
    
    if (self.viewControllers.count >= 1) {
        viewController.navigationItem.leftBarButtonItem =[UIBarButtonItem barButtonItemWithTarget:self andWithAction:@selector(didTapBackButton) andWithImage:@"hk_navigation_back"];
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [self.navigationController pushViewController:[HKWrapViewController wrapViewControllerWithViewController:viewController] animated:animated];
}

- (void)didTapBackButton {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    [self.navigationController dismissViewControllerAnimated:flag completion:completion];
    self.viewControllers.firstObject.hk_navigationController = nil;
}

@end

@implementation HKWrapViewController

static NSValue *hk_tabBarRectValue;

+ (HKWrapViewController *)wrapViewControllerWithViewController:(UIViewController *)viewController {
    
    HKWrapNavigationController *wrapNavigationController = [[HKWrapNavigationController alloc] init];
    wrapNavigationController.viewControllers = @[viewController];
    HKWrapViewController *wrapViewController = [[HKWrapViewController alloc] init];
    [wrapViewController.view addSubview:wrapNavigationController.view];
    [wrapViewController addChildViewController:wrapNavigationController];
    return wrapViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    HKWrapNavigationController *wrapNavigationController = self.childViewControllers.firstObject;
//    [self.view addSubview:wrapNavigationController.view];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    if (self.tabBarController && !hk_tabBarRectValue) {
        hk_tabBarRectValue = [NSValue valueWithCGRect:self.tabBarController.tabBar.frame];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.translucent = YES;
    if (self.tabBarController && !self.hidesBottomBarWhenPushed && hk_tabBarRectValue) {
        self.tabBarController.tabBar.frame = hk_tabBarRectValue.CGRectValue;
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.tabBarController && self.hidesBottomBarWhenPushed) {
        self.tabBarController.tabBar.frame = CGRectZero;
    }
}

- (BOOL)enablePopGestureRecognizer {
    return self.rootViewController.enablePopGestureRecognizer;
}

-  (BOOL)hidesBottomBarWhenPushed {
    return self.rootViewController.hidesBottomBarWhenPushed;
}

- (UITabBarItem *)tabBarItem {
    return self.rootViewController.tabBarItem;
}

- (NSString *)title {
    return self.rootViewController.title;
}

- (UIViewController *)childViewControllerForStatusBarStyle {
    return self.rootViewController;
}

- (UIViewController *)childViewControllerForStatusBarHidden {
    return self.rootViewController;
}

- (UIViewController *)rootViewController {
    HKWrapNavigationController *wrapNavigationController = self.childViewControllers.firstObject;
    return wrapNavigationController.viewControllers.firstObject;
}

@end

@interface HKNavigationController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@end

@implementation HKNavigationController

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController {
    if (self = [super init]) {
        rootViewController.hk_navigationController = self;
        self.viewControllers = @[[HKWrapViewController wrapViewControllerWithViewController:rootViewController]];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        self.viewControllers.firstObject.hk_navigationController = self;
        self.viewControllers = @[[HKWrapViewController wrapViewControllerWithViewController:self.viewControllers.firstObject]];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationBarHidden:YES];
    self.delegate = self;
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BOOL isRootViewController = (viewController == navigationController.viewControllers.firstObject);
    
    self.interactivePopGestureRecognizer.delegate = self;
    self.interactivePopGestureRecognizer.enabled = !isRootViewController;
    if (viewController.enablePopGestureRecognizer) {
        self.interactivePopGestureRecognizer.enabled = NO;
    }
}

#pragma mark - UIGestureRecognizerDelegate
// 修复有水平方向滚动的ScrollView时边缘返回手势失效的问题
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIScreenEdgePanGestureRecognizer class]]) {
        return NO;
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRequireFailureOfGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ![gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}

#pragma mark - getter
- (NSArray *)hk_viewControllers {
    NSMutableArray *viewControllers = [NSMutableArray array];
    for (HKWrapViewController *wrapViewController in self.viewControllers) {
        [viewControllers addObject:wrapViewController.rootViewController];
    }
    return viewControllers.copy;
}

@end
