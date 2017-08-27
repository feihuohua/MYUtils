//
//  NSDictionary+Extension.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSDictionary+Extension.h"
#import "NSString+Extension.h"

@implementation NSDictionary (Extension)

- (NSDictionary *)dictionaryObjectForKey:(id)aKey {
    id value = [self objectForKey:aKey];
    if (value == nil || [value isKindOfClass:[NSNull class]] || ![value isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    return value;
}

- (NSArray *)arrayObjectForKey:(id)aKey {
    id value = [self objectForKey:aKey];
    if (value == nil || [value isKindOfClass:[NSNull class]] || ![value isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return value;
}

- (NSMutableArray *)mutableArrayObjectForKey:(id)aKey {
    id value = [self objectForKey:aKey];
    if (value == nil || [value isKindOfClass:[NSNull class]] || ![value isKindOfClass:[NSArray class]]) {
        return nil;
    }
    return value;
}

- (id)objectExtForKey:(id)aKey defaultObject:(id)defaultObject {
    
    id value = [self objectForKey:aKey];
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        return defaultObject;
    }
    return value;
}

- (NSString *)stringForKey:(id)aKey {
    return [self stringForKey:aKey withDefaultValue:@""];
}

- (NSString *)stringForKey:(id)aKey withDefaultValue:(NSString *)defValue {
    NSString *value = [self objectForKey:aKey];
    if (value == nil || [value isKindOfClass:[NSNull class]]) {
        value = defValue;
    }
    return [[NSString stringWithFormat:@"%@",value] replaceNullString];
}

@end
