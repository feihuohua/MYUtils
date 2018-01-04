//
//  UIDevice+MYActionSheet.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (MYActionSheet)

/**
 Return `YES` if current device is iPhone X.
 
 iPhone X Safe Area
 - Top:     +24.0pt
 - Bottom:  +34.0pt
 
 @return Whether it is iPhone X
 */
- (BOOL)device_isX;

@end

NS_ASSUME_NONNULL_END
