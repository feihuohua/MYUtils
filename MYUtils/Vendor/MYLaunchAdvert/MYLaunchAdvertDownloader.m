//
//  MYLaunchAdvertDownloader.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYLaunchAdvertDownloader.h"
#import "MYLaunchAdvertConst.h"
#import "MYLaunchAdvertCache.h"
#import <NSString+Extension.h>

@interface MYLaunchAdvertDownload()

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSURLSessionDownloadTask *downloadTask;
@property (nonatomic, assign) unsigned long long totalLength;
@property (nonatomic, assign) unsigned long long currentLength;
@property (nonatomic, copy) MYLaunchAdDownloadProgressBlock progressBlock;
@property (nonatomic, strong) NSURL *url;

@end

@implementation MYLaunchAdvertDownload

@end

#pragma mark -  MYLaunchAdvertImageDownload
@interface MYLaunchAdvertImageDownload()<NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>

@property (nonatomic, copy ) MYLaunchAdDownloadImageCompletedBlock completedBlock;

@end
@implementation MYLaunchAdvertImageDownload

- (instancetype)initWithURL:(NSURL *)url
              delegateQueue:(NSOperationQueue *)queue
                   progress:(MYLaunchAdDownloadProgressBlock)progressBlock
                  completed:(MYLaunchAdDownloadImageCompletedBlock)completedBlock {
    self = [super init];
    if (self) {
        self.url = url;
        self.progressBlock = progressBlock;
        _completedBlock = completedBlock;
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = 15.0;
        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                     delegate:self
                                                delegateQueue:queue];
        self.downloadTask =  [self.session downloadTaskWithRequest:[NSURLRequest requestWithURL:url]];
        [self.downloadTask resume];
    }
    return self;
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSData *data = [NSData dataWithContentsOfURL:location];
    UIImage *image = [UIImage imageWithData:data];
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_completedBlock) {
            _completedBlock(image,data, nil);
            // 防止重复调用
            _completedBlock = nil;
        }
        // 下载完成回调
        if ([self.delegate respondsToSelector:@selector(downloadFinishWithURL:)]) {
            [self.delegate downloadFinishWithURL:self.url];
        }
    });
    //销毁
    [self.session invalidateAndCancel];
    self.session = nil;
}

- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    self.currentLength = totalBytesWritten;
    self.totalLength = totalBytesExpectedToWrite;
    if (self.progressBlock) {
        self.progressBlock(self.totalLength, self.currentLength);
    }
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error){
        MYLog(@"error = %@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_completedBlock) {
                _completedBlock(nil, nil, error);
            }
            _completedBlock = nil;
        });
    }
}

// 处理HTTPS请求的
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler {
    NSURLProtectionSpace *protectionSpace = challenge.protectionSpace;
    if ([protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
        SecTrustRef serverTrust = protectionSpace.serverTrust;
        completionHandler(NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
    } else {
        completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
    }
}

@end

#pragma makr - MYLaunchAdvertVideoDownload
@interface MYLaunchAdvertVideoDownload()<NSURLSessionDownloadDelegate,NSURLSessionTaskDelegate>

@property (nonatomic, copy) MYLaunchAdDownloadVideoCompletedBlock completedBlock;

@end
@implementation MYLaunchAdvertVideoDownload

- (instancetype)initWithURL:(NSURL *)url
              delegateQueue:(NSOperationQueue *)queue
                   progress:(MYLaunchAdDownloadProgressBlock)progressBlock
                  completed:(MYLaunchAdDownloadVideoCompletedBlock)completedBlock {
    self = [super init];
    if (self) {
        self.url = url;
        self.progressBlock = progressBlock;
        _completedBlock = completedBlock;
        NSURLSessionConfiguration * sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        sessionConfiguration.timeoutIntervalForRequest = 15.0;
        self.session = [NSURLSession sessionWithConfiguration:sessionConfiguration
                                                     delegate:self
                                                delegateQueue:queue];
        self.downloadTask =  [self.session downloadTaskWithRequest:[NSURLRequest requestWithURL:url]];
        [self.downloadTask resume];
    }
    return self;
}

#pragma mark - NSURLSessionDownloadDelegate
- (void)URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    NSError *error = nil;
    NSURL *toURL = [NSURL fileURLWithPath:[MYLaunchAdvertCache videoPathWithURL:self.url]];
    [[NSFileManager defaultManager] copyItemAtURL:location toURL:toURL error:&error];
    if (error) {
        MYLog(@"error = %@",error);
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_completedBlock) {
            if(!error){
                _completedBlock(toURL, nil);
            } else {
                _completedBlock(nil, error);
            }
            // 防止重复调用
            _completedBlock = nil;
        }
        // 下载完成回调
        if ([self.delegate respondsToSelector:@selector(downloadFinishWithURL:)]) {
            [self.delegate downloadFinishWithURL:self.url];
        }
    });
    [self.session invalidateAndCancel];
    self.session = nil;
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    self.currentLength = totalBytesWritten;
    self.totalLength = totalBytesExpectedToWrite;
    if (self.progressBlock) {
        self.progressBlock(self.totalLength, self.currentLength);
    }
}

- (void)URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if (error) {
        MYLog(@"error = %@",error);
        dispatch_async(dispatch_get_main_queue(), ^{
            if (_completedBlock) {
                _completedBlock(nil, error);
            }
            _completedBlock = nil;
        });
    }
}

@end

@interface MYLaunchAdvertDownloader()<MYLaunchAdvertDownloadDelegate>

@property (nonatomic, strong) NSOperationQueue *downloadImageQueue;
@property (nonatomic, strong) NSOperationQueue *downloadVideoQueue;
@property (nonatomic, strong) NSMutableDictionary *allDownloadDict;

@end

@implementation MYLaunchAdvertDownloader

+ (instancetype)sharedDownloader {
    static MYLaunchAdvertDownloader *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[MYLaunchAdvertDownloader alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _downloadImageQueue = [NSOperationQueue new];
        _downloadImageQueue.maxConcurrentOperationCount = 6;
        _downloadImageQueue.name = @"com.it7090.XHLaunchAdDownloadImageQueue";
        _downloadVideoQueue = [NSOperationQueue new];
        _downloadVideoQueue.maxConcurrentOperationCount = 3;
        _downloadVideoQueue.name = @"com.it7090.XHLaunchAdDownloadVideoQueue";
        MYLog(@"XHLaunchAdCachePath:%@",[MYLaunchAdvertCache launchAdCachePath]);
    }
    return self;
}

- (void)downloadImageWithURL:(NSURL *)url
                    progress:(MYLaunchAdDownloadProgressBlock)progressBlock
                   completed:(MYLaunchAdDownloadImageCompletedBlock)completedBlock {
    NSString *key = [self keyWithURL:url];
    if (self.allDownloadDict[key]) {
        return;
    }
    MYLaunchAdvertImageDownload * download = [[MYLaunchAdvertImageDownload alloc]
                                              initWithURL:url
                                              delegateQueue:_downloadImageQueue
                                              progress:progressBlock
                                              completed:completedBlock];
    download.delegate = self;
    [self.allDownloadDict setObject:download forKey:key];
}

- (void)downloadImageAndCacheWithURL:(NSURL *)url completed:(void(^)(BOOL result))completedBlock {
    if (!url) {
        if (completedBlock) {
            completedBlock(NO);
        }
        return;
    }
    [self downloadImageWithURL:url progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error) {
        if (error) {
            if(completedBlock) completedBlock(NO);
        } else {
            [MYLaunchAdvertCache async_saveImageData:data imageURL:url completed:^(BOOL result, NSURL * _Nonnull URL) {
                if (completedBlock) {
                    completedBlock(result);
                }
            }];
        }
    }];
}

- (void)downLoadImageAndCacheWithURLArray:(NSArray<NSURL *> *)urlArray {
    [self downLoadImageAndCacheWithURLArray:urlArray completed:nil];
}

- (void)downLoadImageAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray
                                completed:(MYLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock {
    if (urlArray.count == 0) {
        return;
    }
    __block NSMutableArray * resultArray = [[NSMutableArray alloc] init];
    dispatch_group_t downLoadGroup = dispatch_group_create();
    [urlArray enumerateObjectsUsingBlock:^(NSURL *url, NSUInteger idx, BOOL *stop) {
        if (![MYLaunchAdvertCache checkImageInCacheWithURL:url]) {
            dispatch_group_enter(downLoadGroup);
            [self downloadImageAndCacheWithURL:url completed:^(BOOL result) {
                dispatch_group_leave(downLoadGroup);
                [resultArray addObject:@{@"url":url.absoluteString,@"result":@(result)}];
            }];
        } else {
            [resultArray addObject:@{@"url":url.absoluteString,@"result":@(YES)}];
        }
    }];
    dispatch_group_notify(downLoadGroup, dispatch_get_main_queue(), ^{
        if(completedBlock) completedBlock(resultArray);
    });
}

- (void)downloadVideoWithURL:(NSURL *)url
                    progress:(MYLaunchAdDownloadProgressBlock)progressBlock
                   completed:(MYLaunchAdDownloadVideoCompletedBlock)completedBlock {
    NSString *key = [self keyWithURL:url];
    if (self.allDownloadDict[key]) {
        return;
    }
    MYLaunchAdvertVideoDownload * download = [[MYLaunchAdvertVideoDownload alloc]
                                              initWithURL:url
                                              delegateQueue:_downloadVideoQueue
                                              progress:progressBlock
                                              completed:completedBlock];
    download.delegate = self;
    [self.allDownloadDict setObject:download forKey:key];
}

- (void)downloadVideoAndCacheWithURL:(NSURL *)url completed:(void(^)(BOOL result))completedBlock {
    if (!url) {
        if (completedBlock) {
            completedBlock(NO);
        }
        return;
    }
    [self downloadVideoWithURL:url progress:nil completed:^(NSURL * _Nullable location, NSError * _Nullable error) {
        if (error) {
            if (completedBlock) {
                completedBlock(NO);
            }
        } else {
            [MYLaunchAdvertCache async_saveVideoAtLocation:location URL:url completed:^(BOOL result, NSURL * _Nonnull URL) {
                if(completedBlock) completedBlock(result);
            }];
        }
    }];
}

- (void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> * )urlArray {
    [self downLoadVideoAndCacheWithURLArray:urlArray completed:nil];
}

- (void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> *)urlArray
                                completed:(MYLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock {
    if (urlArray.count == 0) {
        return;
    }
    __block NSMutableArray * resultArray = [[NSMutableArray alloc] init];
    dispatch_group_t downLoadGroup = dispatch_group_create();
    [urlArray enumerateObjectsUsingBlock:^(NSURL *url, NSUInteger idx, BOOL *stop) {
        if (![MYLaunchAdvertCache checkVideoInCacheWithURL:url]) {
            dispatch_group_enter(downLoadGroup);
            [self downloadVideoAndCacheWithURL:url completed:^(BOOL result) {
                dispatch_group_leave(downLoadGroup);
                [resultArray addObject:@{@"url":url.absoluteString,@"result":@(result)}];
            }];
        } else {
            [resultArray addObject:@{@"url":url.absoluteString,@"result":@(YES)}];
        }
    }];
    dispatch_group_notify(downLoadGroup, dispatch_get_main_queue(), ^{
        if (completedBlock) {
            completedBlock(resultArray);
        }
    });
}

- (NSMutableDictionary *)allDownloadDict {
    if (!_allDownloadDict) {
        _allDownloadDict = [[NSMutableDictionary alloc] init];
    }
    return _allDownloadDict;
}

- (void)downloadFinishWithURL:(NSURL *)url {
    [self.allDownloadDict removeObjectForKey:[self keyWithURL:url]];
}

- (NSString *)keyWithURL:(NSURL *)url {
    return url.absoluteString.md5String;
}

@end
