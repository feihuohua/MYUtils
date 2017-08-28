//
//  UIImage+BetterFace.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//  https://github.com/croath/UIImageView-BetterFace

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, BFAccuracy) {
    kBFAccuracyLow = 0,
    kBFAccuracyHigh,
};

@interface UIImage (BetterFace)

- (UIImage *)betterFaceImageForSize:(CGSize)size
                           accuracy:(BFAccuracy)accurary;

@end
