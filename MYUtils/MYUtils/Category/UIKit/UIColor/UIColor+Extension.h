//
//  UIColor+Extension.h
//  FXKitExampleDemo
//
//  Created by sunjinshuai on 2017/7/20.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Extension)

+ (UIColor *)randomColor;

/**
 Creates and returns a color object from hex string.
 
 @discussion:
 Valid format: #RGB #RGBA #RRGGBB #RRGGBBAA 0xRGB ...
 The `#` or "0x" sign is not required.
 The alpha will be set to 1.0 if there is no alpha component.
 It will return nil when an error occurs in parsing.
 
 Example: @"0xF0F", @"66ccff", @"#66CCFF88"
 
 @param hexStr  The hex string value for the new color.
 
 @return        An UIColor object from string, or nil if an error occurs.
 */
+ (nullable UIColor *)colorWithHexString:(NSString *)hexStr;
+ (nullable UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alphaValue;


/**
 渐变颜色

 @param fromColor 开始颜色
 @param toColor 结束颜色
 @param height 渐变高度
 @return 渐变颜色
 */
+ (UIColor *)gradientFromColor:(UIColor *)fromColor toColor:(UIColor *)toColor height:(CGFloat)height;

@end

NS_ASSUME_NONNULL_END
