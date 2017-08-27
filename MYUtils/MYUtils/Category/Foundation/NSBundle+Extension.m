//
//  NSBundle+Extension.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "NSBundle+Extension.h"

@implementation NSBundle (Extension)

- (NSString *)appIconPath {
    NSString *iconFilename = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleIconFile"] ;
    NSString *iconBasename = [iconFilename stringByDeletingPathExtension] ;
    NSString *iconExtension = [iconFilename pathExtension] ;
    return [[NSBundle mainBundle] pathForResource:iconBasename
                                           ofType:iconExtension] ;
}

- (UIImage *)appIcon {
    return [[UIImage alloc] initWithContentsOfFile:[self appIconPath]];
}

@end
