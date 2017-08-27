//
//  NSString+Extension.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (NSString *)replaceNullString {
    if (self == nil || self.length == 0) {
        return @"";
    }
    NSUInteger myLength = self.length;
    if (myLength > 0) {
        if ([self isEqualToString:@"(null)"]||[self isEqualToString:@"<null>"]) {
            return @"";
        }
        return self;
    }
    return @"";
}

@end
