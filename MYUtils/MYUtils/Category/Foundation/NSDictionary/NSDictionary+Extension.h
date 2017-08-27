//
//  NSDictionary+Extension.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSDictionary (Extension)

/**
 利用链式编程去实现富文本属性的赋值
 */
- (NSMutableDictionary *(^)(CGFloat))font;
- (NSMutableDictionary *(^)(UIColor *))color;


/**
 获取字典指定的NSDictionary的对象

 @param aKey key
 @return value值如果为nil或者null会返回空NSDictionary
 */
- (NSDictionary *)dictionaryObjectForKey:(id)aKey;

/**
 
 获取字典指定的array的对象
 @param aKey key
 @return value值如果为nil或者null会返回空列表
 */
- (NSArray *)arrayObjectForKey:(id)aKey;

/**
 
 获取字典指定的array的对象
 @param aKey key
 @return value值如果为nil或者null会返回空列表
 */
- (NSMutableArray *)mutableArrayObjectForKey:(id)aKey;

/**
 获取字典指定的对象为空是返回默认对象
 @param aKey key
 @param defaultObject value值如果为nil或者null会返回默认对象
 @return 对象
 */
- (id)objectExtForKey:(id)aKey defaultObject:(id)defaultObject;

/**
 如果akey找不到，返回默认值 (防止出现nil，使程序崩溃)

 @param aKey 字典key值
 @param defValue 为空时的默认值
 @return 字典value
 */
- (NSString *)stringForKey:(id)aKey;

/**
 NSDictionary转换成JSON字符串

 @return  JSON字符串
 */
- (NSString *)JSONString;

@end
