//
//  NSMutableAttributedString+Extension.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSMutableAttributedString+Extension.h"

@implementation NSMutableAttributedString (Extension)

+ (NSMutableAttributedString *)makeAttributeString:(NSString *)string
                                         attribute:(void(^)(NSMutableDictionary *attributes))block {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    block(attributes);
    return [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];;
}


- (NSMutableAttributedString *)makeAttributeStringAdd:(NSString *)string
                                            attribute:(void(^)(NSMutableDictionary *attributes))block {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    block(attributes);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:string attributes:attributes];
    [self appendAttributedString:attributedString];
    return self;
}

@end
