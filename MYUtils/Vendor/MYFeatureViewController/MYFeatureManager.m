//
//  MYFeatureManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/20.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYFeatureManager.h"

@implementation MYFeatureManager

+ (instancetype)shareManager {
    static MYFeatureManager *_shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[MYFeatureManager alloc] init];
    });
    return _shareManager;
}

#pragma mark - 是否显示新特性视图控制器

- (BOOL)shouldShowNewFeature {
    
    NSString *key = @"CFBundleShortVersionString";
    // 获取沙盒中版本号
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] stringForKey:key];
    
    // 获取当前的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    if ([currentVersion isEqualToString:lastVersion]) {
        return NO;
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
}

@end
