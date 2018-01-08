//
//  MYLaunchAdvertVideoView.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/5.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYLaunchAdvertVideoView.h"

@interface MYLaunchAdvertVideoView ()<UIGestureRecognizerDelegate>

@end

@implementation MYLaunchAdvertVideoView

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.userInteractionEnabled = YES;
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        [self addSubview:self.videoPlayer.view];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                     action:@selector(tap:)];
        tapGesture.delegate = self;
        [self addGestureRecognizer:tapGesture];
    }
    return self;
}

- (void)tap:(UIGestureRecognizer *)gestureRecognizer {
    CGPoint point = [gestureRecognizer locationInView:self];
    if (self.click) {
        self.click(point);
    }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}

#pragma mark - Action
- (void)stopVideoPlayer {
    if (!_videoPlayer) {
        return;
    }
    [_videoPlayer.player pause];
    [_videoPlayer.view removeFromSuperview];
    _videoPlayer = nil;
}

- (void)runLoopTheMovie:(NSNotification *)notification {
    // 需要循环播放
    if (!_videoCycleOnce) {
        [(AVPlayerItem *)[notification object] seekToTime:kCMTimeZero];
        [self.videoPlayer.player play]; //重播
    }
}

#pragma mark - set
- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    _videoPlayer.view.frame = self.frame;
}

- (void)setContentURL:(NSURL *)contentURL {
    _contentURL = contentURL;
    AVAsset *movieAsset = [AVURLAsset URLAssetWithURL:contentURL options:nil];
    AVPlayerItem * playerItem = [AVPlayerItem playerItemWithAsset:movieAsset];
    self.videoPlayer.player = [AVPlayer playerWithPlayerItem:playerItem];
}

- (void)setVideoGravity:(AVLayerVideoGravity)videoGravity {
    _videoGravity = videoGravity;
    _videoPlayer.videoGravity = videoGravity;
}

- (void)setVideoScalingMode:(MPMovieScalingMode)videoScalingMode {
    _videoScalingMode = videoScalingMode;
    switch (_videoScalingMode) {
        case MPMovieScalingModeNone: {
            _videoPlayer.videoGravity = AVLayerVideoGravityResizeAspect;
        }
            break;
        case MPMovieScalingModeAspectFit: {
            _videoPlayer.videoGravity = AVLayerVideoGravityResizeAspect;
        }
            break;
        case MPMovieScalingModeAspectFill: {
            _videoPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        }
            break;
        case MPMovieScalingModeFill: {
            _videoPlayer.videoGravity = AVLayerVideoGravityResize;
        }
            break;
        default:
            break;
    }
}

- (AVPlayerViewController *)videoPlayer {
    if (!_videoPlayer) {
        _videoPlayer = [[AVPlayerViewController alloc] init];
        _videoPlayer.showsPlaybackControls = NO;
        _videoPlayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
        _videoPlayer.view.frame = [UIScreen mainScreen].bounds;
        _videoPlayer.view.backgroundColor = [UIColor clearColor];
        // 注册通知控制是否循环播放
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(runLoopTheMovie:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    }
    return _videoPlayer;
}

@end
