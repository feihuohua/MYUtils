//
//  NSHTTPCookieStorage+Extension.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSHTTPCookieStorage (Extension)

/**
 *  @brief 存储 UIWebView cookies到磁盘目录
 */
- (void)saveCookie;
/**
 *  @brief 读取UIWebView cookies从磁盘目录
 */
- (void)loadCookie;

@end
