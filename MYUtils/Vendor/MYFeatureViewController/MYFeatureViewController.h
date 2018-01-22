//
//  MYFeatureViewController.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/20.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  完成新特性界面展示后的block回调
 */
typedef void (^MYFeatureSkipFinishBlock)();

typedef void (^MYFeatureScrollViewDidScrollToIndexFinishBlock)(NSInteger *index, CGFloat *contentOffsetX);
typedef void (^MYFeatureScrollViewWillScrollFinishBlock)(NSInteger *index, CGFloat *contentOffsetX);

@interface MYFeatureViewController : UIViewController

+ (instancetype)initWithImageArray:(NSArray<UIImage *> *)images;

+ (instancetype)initWithImageArray:(NSArray<UIImage *> *)images
                   showPageControl:(BOOL)showPageControl;

- (instancetype)initWithImageArray:(NSArray<UIImage *> *)images
                   showPageControl:(BOOL)showPageControl;

@end
