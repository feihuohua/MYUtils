//
//  MYLaunchAdvertImageView.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/5.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <FLAnimatedImage/FLAnimatedImage.h>
#import "MYLaunchAdvertImageManager.h"

@interface MYLaunchAdvertImageView : FLAnimatedImageView

@property (nonatomic, copy) void(^click)(CGPoint point);

/**
 设置url图片
 
 @param url 图片url
 */
- (void)ad_setImageWithURL:(NSURL *)url;

/**
 设置url图片
 
 @param url 图片url
 @param placeholder 占位图
 */
- (void)ad_setImageWithURL:(NSURL *)url placeholderImage:(UIImage *)placeholder;

/**
 设置url图片
 
 @param url 图片url
 @param placeholder 占位图
 @param options MYLaunchAdvertImageOptions
 */
- (void)ad_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                   options:(MYLaunchAdvertImageOptions)options;

/**
 设置url图片
 
 @param url 图片url
 @param placeholder 占位图
 @param completedBlock MYExternalCompletionBlock
 */
- (void)ad_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                 completed:(MYExternalCompletionBlock)completedBlock;

/**
 设置url图片
 
 @param url 图片url
 @param completedBlock MYExternalCompletionBlock
 */
- (void)ad_setImageWithURL:(NSURL *)url completed:(MYExternalCompletionBlock)completedBlock;


/**
 设置url图片
 
 @param url 图片url
 @param placeholder 占位图
 @param options MYLaunchAdvertImageOptions
 @param completedBlock MYExternalCompletionBlock
 */
- (void)ad_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
                   options:(MYLaunchAdvertImageOptions)options
                 completed:(MYExternalCompletionBlock)completedBlock;

/**
 设置url图片
 
 @param url 图片url
 @param placeholder 占位图
 @param GIFImageCycleOnce gif是否只循环播放一次
 @param options MYLaunchAdvertImageOptions
 @param cycleOnceFinishBlock gif播放完回调(GIFImageCycleOnce = YES 有效)
 @param completedBlock MYExternalCompletionBlock
 */
- (void)ad_setImageWithURL:(NSURL *)url
          placeholderImage:(UIImage *)placeholder
         GIFImageCycleOnce:(BOOL)GIFImageCycleOnce
                   options:(MYLaunchAdvertImageOptions)options
   GIFImageCycleOnceFinish:(void(^_Nullable)(void))cycleOnceFinishBlock
                 completed:(nullable MYExternalCompletionBlock)completedBlock ;

@end
