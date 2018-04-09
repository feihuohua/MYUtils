//
//  MYLaunchAdModel.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/4/9.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYLaunchAdModel.h"

@implementation MYLaunchAdModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        
        self.content = dict[@"content"];
        self.openUrl = dict[@"openUrl"];
        self.duration = [dict[@"duration"] integerValue];
        self.contentSize = dict[@"contentSize"];
    }
    return self;
}

- (CGFloat)width {
    return [[[self.contentSize componentsSeparatedByString:@"*"] firstObject] floatValue];
}

- (CGFloat)height {
    return [[[self.contentSize componentsSeparatedByString:@"*"] lastObject] floatValue];
}

@end
