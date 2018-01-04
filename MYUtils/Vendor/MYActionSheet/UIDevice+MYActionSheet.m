//
//  UIDevice+MYActionSheet.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "UIDevice+MYActionSheet.h"

@implementation UIDevice (MYActionSheet)

- (BOOL)device_isX {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    return MAX(screenSize.width, screenSize.height) == 812.0;
}

@end
