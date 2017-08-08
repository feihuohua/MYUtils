//
//  MYShowTextCellModel.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYShowTextCellModel.h"

@implementation MYShowTextCellModel

- (instancetype)initWithContent:(NSString *)content
                   contentLines:(CGFloat)contentLines
                         isOpen:(BOOL)isOpen {
    
    if (self = [super init]) {
        self.content = content;
        self.contentLines = contentLines;
        self.isOpen = isOpen;
    }
    return self;
}

@end
