//
//  NSMutableDictionary+Extension.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableDictionary (Extension)

/**
 利用链式编程去实现富文本属性的赋值
 */
- (NSMutableDictionary *(^)(CGFloat))font;
- (NSMutableDictionary *(^)(UIColor *))color;

@end
