//
//  UIImage+Extension.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/9.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 Create and return a 1x1 point size image with the given color.

 @param color The color
 @return image
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
