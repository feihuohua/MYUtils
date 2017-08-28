//
//  UIFont+TTF.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (TTF)

/**
 NSString *pathToFont = [[NSBundle mainBundle] pathForResource:@"segoeui" ofType:@"ttf"];
 UIFont *smallFontFromPath = [UIFont fontWithTTFAtPath:pathToFont size:18.0f];
 
 NSString *pathToFont = [[NSBundle mainBundle] pathForResource:@"segoeui" ofType:@"ttf"];
 
 NSURL *URLToFont = [NSURL fileURLWithPath:pathToFont];
 UIFont *smallFontFromURL = [UIFont fontWithTTFAtURL:[NSURL fileURLWithPath:pathToFont] size:18.0f];
 */

/**
 *  @brief  Obtain a UIFont from a TTF file. If the path to the font is not valid, an exception will be raised,
 *	assuming NS_BLOCK_ASSERTIONS has not been defined. If assertions are disabled, systemFontOfSize is returned.
 *
 *  @param path The path to the TTF file.
 *  @param size The size of the font.
 *
 *  @return A UIFont reference derived from the TrueType Font at the given path with the requested size.
 */

+ (UIFont *)fontWithTTFAtPath:(NSString *)path size:(CGFloat)size;

/**
 *  @brief  Convenience method that calls fontWithTTFAtPath:size: after creating a path from the provided URL.
 *
 *  @param URL  URL to the file (local only).
 *  @param size The size of the font.
 *
 *  @return A UIFont reference derived from the TrueType Font at the given path with the requested size.
 */

+ (UIFont *)fontWithTTFAtURL:(NSURL *)URL size:(CGFloat)size;

@end
