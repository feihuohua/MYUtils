//
//  MYStringFormattManager.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/24.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYStringFormattManager : NSObject

+ (instancetype)shareManager;

/**
 *  按首字母排列数组
 *  attributeName:排序所根据的属性名,若传入string数组则attributeName传空
 */
- (NSArray *)orderArray:(NSArray *)array
                orderBy:(NSString *)attributeName;

/**
 *  获取首字母数组
 *  attributeName:排序所根据的属性名,若传入string数组则attributeName传空
 */
- (NSArray *)getSectionArray:(NSArray *)array
                     orderBy:(NSString *)attributeName;

@end
