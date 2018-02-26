//
//  MYLaunchAdvertDownloader.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^MYLaunchAdDownloadProgressBlock)(unsigned long long total, unsigned long long current);

typedef void(^MYLaunchAdDownloadImageCompletedBlock)(UIImage *image, NSData *data, NSError *error);

typedef void(^MYLaunchAdDownloadVideoCompletedBlock)(NSURL *location, NSError * error);

typedef void(^MYLaunchAdBatchDownLoadAndCacheCompletedBlock)(NSArray *completedArray);

@protocol MYLaunchAdvertDownloadDelegate <NSObject>

- (void)downloadFinishWithURL:(NSURL *)url;

@end

@interface MYLaunchAdvertDownload : NSObject

@property (nonatomic, weak) id<MYLaunchAdvertDownloadDelegate> delegate;

@end

@interface MYLaunchAdvertImageDownload : MYLaunchAdvertDownload

@end

@interface MYLaunchAdvertVideoDownload : MYLaunchAdvertDownload

@end

@interface MYLaunchAdvertDownloader : NSObject

+ (instancetype)sharedDownloader;

- (void)downloadImageWithURL:(NSURL *)url
                    progress:(MYLaunchAdDownloadProgressBlock)progressBlock
                   completed:(MYLaunchAdDownloadImageCompletedBlock)completedBlock;

- (void)downLoadImageAndCacheWithURLArray:(NSArray <NSURL *> *)urlArray;
- (void)downLoadImageAndCacheWithURLArray:(NSArray <NSURL *> *)urlArray
                                completed:(MYLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock;

- (void)downloadVideoWithURL:(NSURL *)url
                    progress:(MYLaunchAdDownloadProgressBlock)progressBlock
                   completed:(MYLaunchAdDownloadVideoCompletedBlock)completedBlock;

- (void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> *)urlArray;
- (void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> *)urlArray
                                completed:(MYLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock;

@end
