//
//  MYFileManager.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/24.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, MYDirectoryType) {
    MYDirectoryTypeHome,
    MYDirectoryTypeTemporary,
    MYDirectoryTypeDocument,
    MYDirectoryTypeLibrary,
    MYDirectoryTypePreference,
    MYDirectoryTypeCaches
};

@interface MYFileManager : NSObject

+ (instancetype)shareManager;

/// 返回偏好设置字典
- (NSDictionary *)getUserDefaultsDictionary;

/// 返回文件路径
- (NSString *)getPath:(MYDirectoryType)type;

@end
