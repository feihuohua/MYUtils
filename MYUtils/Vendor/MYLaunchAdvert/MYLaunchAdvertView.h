//
//  MYLaunchAdvertView.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>

#if __has_include(<FLAnimatedImage/FLAnimatedImage.h>)
#import <FLAnimatedImage/FLAnimatedImage.h>
#else
#import "FLAnimatedImage.h"
#endif

#if __has_include(<FLAnimatedImage/FLAnimatedImageView.h>)
#import <FLAnimatedImage/FLAnimatedImageView.h>
#else
#import "FLAnimatedImageView.h"
#endif

#pragma mark - image
@interface MYLaunchAdvertImageView : FLAnimatedImageView

@property (nonatomic, copy) void(^click)(CGPoint point);

@end

@interface MYLaunchAdvertVideoView : UIView

@property (nonatomic, copy) void(^click)(CGPoint point);
@property (nonatomic, strong) AVPlayerViewController *videoPlayer;
@property (nonatomic, assign) MPMovieScalingMode videoScalingMode;
@property (nonatomic, assign) AVLayerVideoGravity videoGravity;
@property (nonatomic, assign) BOOL videoCycleOnce;
@property (nonatomic, strong) NSURL *contentURL;

- (void)stopVideoPlayer;

@end
