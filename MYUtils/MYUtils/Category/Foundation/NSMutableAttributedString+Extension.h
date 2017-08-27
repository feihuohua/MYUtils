//
//  NSMutableAttributedString+Extension.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Extension)

/*
 快速创建属性字符串
 
 @param string 字符串
 @param block 返回attributes
 @return NSMutableAttributedString
 */
+ (NSMutableAttributedString *)makeAttributeString:(NSString *)string
                                         attribute:(void(^)(NSMutableDictionary *attributes))block;

/**
 拼接属性字符串

 @param string 字符串
 @param block 返回attributes
 @return NSMutableAttributedString
 */
- (NSMutableAttributedString *)makeAttributeStringAdd:(NSString *)string
                                            attribute:(void(^)(NSMutableDictionary *attributes))block;

@end
