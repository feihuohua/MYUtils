//
//  MYFileManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/24.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYFileManager.h"

@implementation MYFileManager

+ (instancetype)shareManager {
    static MYFileManager *_shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[MYFileManager alloc] init];
    });
    return _shareManager;
}

- (NSDictionary *)getUserDefaultsDictionary {
    return [NSDictionary dictionaryWithContentsOfFile:[[[self getPath:MYDirectoryTypePreference] stringByAppendingPathComponent:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]] stringByAppendingString:@".plist"]];
}

- (NSString *)getPath:(MYDirectoryType)type {
    if (type == MYDirectoryTypeTemporary) {
        return [NSTemporaryDirectory() substringToIndex:NSTemporaryDirectory().length-1];
    }
    if (type == MYDirectoryTypeDocument) {
        return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    }
    if (type == MYDirectoryTypeLibrary) {
        return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
    }
    if (type == MYDirectoryTypePreference) {
        return [[self getPath:MYDirectoryTypeLibrary] stringByAppendingString:@"/Preferences"];
    }
    if (type == MYDirectoryTypeCaches) {
        return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    }
    return NSHomeDirectory();
}
@end
