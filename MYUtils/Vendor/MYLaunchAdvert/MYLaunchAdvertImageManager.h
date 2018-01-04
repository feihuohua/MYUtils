//
//  MYLaunchAdvertImageManager.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYLaunchAdvertDownloader.h"
#import "MYLaunchAdvertConst.h"

typedef void(^MYExternalCompletionBlock)(UIImage * image, NSData *imageData, NSError *error, NSURL *imageURL);

@interface MYLaunchAdvertImageManager : NSObject

+ (instancetype)sharedManager;

- (void)loadImageWithURL:(NSURL *)url
                 options:(MYLaunchAdvertImageOptions)options
                progress:(MYLaunchAdDownloadProgressBlock)progressBlock
               completed:(MYExternalCompletionBlock)completedBlock;

@end
