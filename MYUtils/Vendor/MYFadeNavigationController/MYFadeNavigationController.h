//
//  MYFadeNavigationController.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MYFadeNavigationControllerNavigationBarVisibility) {
    MYFadeNavigationControllerNavigationBarVisibilityDefault = 0,
    MYFadeNavigationControllerNavigationBarVisibilitySystem,
    MYFadeNavigationControllerNavigationBarVisibilityHidden,
    MYFadeNavigationControllerNavigationBarVisibilityVisible
};

@protocol MYFadeNavigationControllerDelegate <NSObject>

- (MYFadeNavigationControllerNavigationBarVisibility)preferredNavigationBarVisibility;

@end

@interface MYFadeNavigationController : UINavigationController

- (void)setNeedsNavigationBarVisibilityUpdateAnimated:(BOOL)animated;

@end
