//
//  UIBarButtonItem+Extension.h
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/7/20.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIBarButtonItem (Extension)

+ (UIBarButtonItem *)barButtonItemWithTarget:(id)target
                               andWithAction:(SEL)action
                                andWithImage:(NSString *)image;

+ (UIBarButtonItem *)barButtonItemWithTarget:(id)target
                               andWithAction:(SEL)action
                                    andTitle:(NSString *)title
                               selectedTitle:(NSString *)selectedTitle;

@end

NS_ASSUME_NONNULL_END
