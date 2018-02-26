//
//  MYLaunchAdvertImageManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYLaunchAdvertImageManager.h"
#import "MYLaunchAdvertCache.h"

@interface MYLaunchAdvertImageManager()

@property (nonatomic, strong) MYLaunchAdvertDownloader *downloader;
@end

@implementation MYLaunchAdvertImageManager

+ (instancetype)sharedManager {
    static MYLaunchAdvertImageManager *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[MYLaunchAdvertImageManager alloc] init];
        
    });
    return instance;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _downloader = [MYLaunchAdvertDownloader sharedDownloader];
    }
    return self;
}

- (void)loadImageWithURL:(NSURL *)url
                 options:(MYLaunchAdvertImageOptions)options
                progress:(MYLaunchAdDownloadProgressBlock)progressBlock
               completed:(MYExternalCompletionBlock)completedBlock {
    if (!options) {
        options = MYLaunchAdvertImageDefault;
    }
    if (options & MYLaunchAdvertImageOnlyLoad) {
        [_downloader downloadImageWithURL:url
                                 progress:progressBlock
                                completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error) {
                                    if (completedBlock) {
                                        completedBlock(image,data,error,url);
                                    }
                                }];
    } else if (options & MYLaunchAdvertImageRefreshCached) {
        NSData *imageData = [MYLaunchAdvertCache getCacheImageDataWithURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        if(image && completedBlock) completedBlock(image,imageData,nil,url);
        [_downloader downloadImageWithURL:url
                                 progress:progressBlock
                                completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error) {
                                    if (completedBlock) {
                                        completedBlock(image,data,error,url);
                                    }
                                    [MYLaunchAdvertCache async_saveImageData:data imageURL:url completed:nil];
                                }];
    } else if (options & MYLaunchAdvertImageCacheInBackground) {
        NSData *imageData = [MYLaunchAdvertCache getCacheImageDataWithURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        if (image && completedBlock) {
            completedBlock(image, imageData, nil, url);
        } else {
            [_downloader downloadImageWithURL:url
                                     progress:progressBlock
                                    completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error) {
                                        [MYLaunchAdvertCache async_saveImageData:data imageURL:url completed:nil];
                                    }];
        }
    } else {//default
        NSData *imageData = [MYLaunchAdvertCache getCacheImageDataWithURL:url];
        UIImage *image = [UIImage imageWithData:imageData];
        if (image && completedBlock) {
            completedBlock(image, imageData, nil, url);
        } else {
            [_downloader downloadImageWithURL:url
                                     progress:progressBlock
                                    completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error) {
                                        if (completedBlock) {
                                            completedBlock(image,data,error,url);
                                        }
                                        [MYLaunchAdvertCache async_saveImageData:data imageURL:url completed:nil];
                                    }];
        }
    }
}

@end
