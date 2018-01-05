//
//  MYLaunchAdvertImageView+MYLaunchAdvertCache.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYLaunchAdvertImageView+MYLaunchAdvertCache.h"
#import "MYLaunchAdvertImageManager.h"
#import "MYLaunchAdvertConst.h"

@implementation MYLaunchAdvertImageView (MYLaunchAdvertCache)

- (void)ad_setImageWithURL:(NSURL *)url {
    [self ad_setImageWithURL:url placeholderImage:nil];
}

- (void)ad_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder {
    [self ad_setImageWithURL:url placeholderImage:placeholder options:MYLaunchAdvertImageDefault];
}

- (void)ad_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(MYLaunchAdvertImageOptions)options{
    [self ad_setImageWithURL:url placeholderImage:placeholder options:options completed:nil];
}

- (void)ad_setImageWithURL:(NSURL *)url completed:(MYExternalCompletionBlock)completedBlock {
    
    [self ad_setImageWithURL:url placeholderImage:nil completed:completedBlock];
}

- (void)ad_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder completed:(MYExternalCompletionBlock)completedBlock {
    [self ad_setImageWithURL:url placeholderImage:placeholder options:MYLaunchAdvertImageDefault completed:completedBlock];
}

- (void)ad_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder options:(MYLaunchAdvertImageOptions)options completed:(MYExternalCompletionBlock)completedBlock {
    [self ad_setImageWithURL:url
            placeholderImage:placeholder
           GIFImageCycleOnce:NO
                     options:options
     GIFImageCycleOnceFinish:nil
                   completed:completedBlock];
}

- (void)ad_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
         GIFImageCycleOnce:(BOOL)GIFImageCycleOnce
                   options:(MYLaunchAdvertImageOptions)options
   GIFImageCycleOnceFinish:(void(^_Nullable)(void))cycleOnceFinishBlock
                 completed:(MYExternalCompletionBlock)completedBlock {
    if (placeholder) {
        self.image = placeholder;
    }
    if (!url) {
        return;
    }
    MYWeakSelf
    [[MYLaunchAdvertImageManager sharedManager] loadImageWithURL:url
                                                         options:options
                                                        progress:nil
                                                       completed:^(UIImage * _Nullable image,  NSData * _Nullable imageData, NSError * _Nullable error, NSURL * _Nullable imageURL) {
                                                           if (!error) {
                                                               if (MYISGIFTypeWithData(imageData)) {
                                                                   weakSelf.image = nil;
                                                                   weakSelf.animatedImage = [FLAnimatedImage animatedImageWithGIFData:imageData];
                                                                   weakSelf.loopCompletionBlock = ^(NSUInteger loopCountRemaining) {
                                                                       if(GIFImageCycleOnce){
                                                                           [weakSelf stopAnimating];
                                                                           MYLog(@"GIF不循环,播放完成");
                                                                           if(cycleOnceFinishBlock) cycleOnceFinishBlock();
                                                                       }
                                                                   };
                                                               } else {
                                                                   weakSelf.animatedImage = nil;
                                                                   weakSelf.image = image;
                                                               }
                                                           }
                                                           if (completedBlock) {
                                                               completedBlock(image, imageData, error, imageURL);
                                                           }
                                                       }];
}

@end
