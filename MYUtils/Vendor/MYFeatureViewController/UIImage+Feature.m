//
//  UIImage+Feature.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/4/19.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "UIImage+Feature.h"

#define IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define IPHONE6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size)) : NO)
#define IPHONE6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size)) : NO)

@implementation UIImage (Feature)

+ (instancetype)imageNamedForAdaptation:(NSString *)imageName
                                iphone5:(BOOL)iphone5
                                iphone6:(BOOL)iphone6
                               iphone6p:(BOOL)iphone6p {
    
    NSString *realImageName = imageName;
    
    if (IPHONE5 && iphone5) {           // 当前设备是 iPhone 5 / 5s 或 iPhone 6 / 6s 放大模式
        
        realImageName = [NSString stringWithFormat:@"%@_iphone5", realImageName];
        
    } else if (IPHONE6 && iphone6) {    // 当前设备是 iPhone 6 / 6s
        
        realImageName = [NSString stringWithFormat:@"%@_iphone6", realImageName];
        
    } else if (IPHONE6P && iphone6p) {  // 当前设备是 iPhone 6 p / 6s p
        
        realImageName = [NSString stringWithFormat:@"%@_iphone6p", realImageName];
    }
  
    return [self imageNamed:realImageName];
}

@end
