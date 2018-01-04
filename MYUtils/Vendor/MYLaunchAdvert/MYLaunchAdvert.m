//
//  MYLaunchAdvert.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYLaunchAdvert.h"
#import "MYLaunchAdvertConfiguration.h"
#import "MYLaunchAdvertButton.h"
#import "MYLaunchAdvertCache.h"
#import "MYLaunchAdvertView.h"
#import "MYLaunchAdvertViewController.h"
#import "MYLaunchImageView.h"
#import "MYLaunchAdvertImageView+MYLaunchAdvertCache.h"

typedef NS_ENUM(NSInteger, MYLaunchAdType) {
    MYLaunchAdTypeImage,
    MYLaunchAdTypeVideo
};

static NSInteger defaultWaitDataDuration = 3;
static MYLaunchImageViewSourceType _sourceType = MYLaunchImageViewSourceTypeLaunchImage;

@interface MYLaunchAdvert()

@property (nonatomic, assign) MYLaunchAdType launchAdType;
/// 倒计时
@property (nonatomic, assign) NSInteger waitDataDuration;
@property (nonatomic, strong) MYLaunchImageAdvertConfiguration *imageAdConfiguration;
@property (nonatomic, strong) MYLaunchVideoAdvertConfiguration *videoAdConfiguration;
@property (nonatomic, strong) MYLaunchAdvertButton *skipButton;
@property (nonatomic, strong) MYLaunchAdvertVideoView *adVideoView;
@property (nonatomic, strong) UIWindow *window;
@property (nonatomic, copy) dispatch_source_t waitDataTimer;
@property (nonatomic, copy) dispatch_source_t skipTimer;
@property (nonatomic, assign) BOOL detailPageShowing;
@property (nonatomic, assign) CGPoint clickPoint;
@end

@implementation MYLaunchAdvert

+ (void)setLaunchSourceType:(MYLaunchImageViewSourceType)sourceType {
    _sourceType = sourceType;
}

+ (void)setWaitDataDuration:(NSInteger )waitDataDuration{
    MYLaunchAdvert *launchAd = [MYLaunchAdvert shareLaunchAd];
    launchAd.waitDataDuration = waitDataDuration;
}

+ (MYLaunchAdvert *)imageAdWithImageAdConfiguration:(MYLaunchImageAdvertConfiguration *)imageAdconfiguration {
    return [MYLaunchAdvert imageAdWithImageAdConfiguration:imageAdconfiguration delegate:nil];
}

+ (MYLaunchAdvert *)imageAdWithImageAdConfiguration:(MYLaunchImageAdvertConfiguration *)imageAdconfiguration delegate:(id)delegate {
    MYLaunchAdvert *launchAd = [MYLaunchAdvert shareLaunchAd];
    if (delegate) {
        launchAd.delegate = delegate;
    }
    launchAd.imageAdConfiguration = imageAdconfiguration;
    return launchAd;
}

+ (MYLaunchAdvert *)videoAdWithVideoAdConfiguration:(MYLaunchVideoAdvertConfiguration *)videoAdconfiguration {
    return [MYLaunchAdvert videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:nil];
}

+ (MYLaunchAdvert *)videoAdWithVideoAdConfiguration:(MYLaunchVideoAdvertConfiguration *)videoAdconfiguration delegate:(id)delegate {
    MYLaunchAdvert *launchAd = [MYLaunchAdvert shareLaunchAd];
    if (delegate) {
        launchAd.delegate = delegate;
    }
    launchAd.videoAdConfiguration = videoAdconfiguration;
    return launchAd;
}

+ (void)downLoadImageAndCacheWithURLArray:(NSArray <NSURL *> *)urlArray {
    [self downLoadImageAndCacheWithURLArray:urlArray completed:nil];
}

+ (void)downLoadImageAndCacheWithURLArray:(NSArray <NSURL *> *)urlArray completed:(MYLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock {
    if (urlArray.count == 0) {
        return;
    }
    [[MYLaunchAdvertDownloader sharedDownloader] downLoadImageAndCacheWithURLArray:urlArray completed:completedBlock];
}

+ (void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> *)urlArray {
    [self downLoadVideoAndCacheWithURLArray:urlArray completed:nil];
}

+ (void)downLoadVideoAndCacheWithURLArray:(NSArray <NSURL *> *)urlArray completed:(MYLaunchAdBatchDownLoadAndCacheCompletedBlock)completedBlock {
    if (urlArray.count == 0) {
        return;
    }
    [[MYLaunchAdvertDownloader sharedDownloader] downLoadVideoAndCacheWithURLArray:urlArray completed:completedBlock];
}

+ (void)removeAndAnimated:(BOOL)animated {
    [[MYLaunchAdvert shareLaunchAd] removeAndAnimated:animated];
}

+ (BOOL)checkImageInCacheWithURL:(NSURL *)url{
    return [MYLaunchAdvertCache checkImageInCacheWithURL:url];
}

+ (BOOL)checkVideoInCacheWithURL:(NSURL *)url {
    return [MYLaunchAdvertCache checkVideoInCacheWithURL:url];
}

+ (void)clearDiskCache {
    [MYLaunchAdvertCache clearDiskCache];
}

+ (void)clearDiskCacheWithImageUrlArray:(NSArray<NSURL *> *)imageUrlArray {
    [MYLaunchAdvertCache clearDiskCacheWithImageUrlArray:imageUrlArray];
}

+ (void)clearDiskCacheExceptImageUrlArray:(NSArray<NSURL *> *)exceptImageUrlArray {
    [MYLaunchAdvertCache clearDiskCacheExceptImageUrlArray:exceptImageUrlArray];
}

+ (void)clearDiskCacheWithVideoUrlArray:(NSArray<NSURL *> *)videoUrlArray {
    [MYLaunchAdvertCache clearDiskCacheWithVideoUrlArray:videoUrlArray];
}

+ (void)clearDiskCacheExceptVideoUrlArray:(NSArray<NSURL *> *)exceptVideoUrlArray {
    [MYLaunchAdvertCache clearDiskCacheExceptVideoUrlArray:exceptVideoUrlArray];
}

+ (float)diskCacheSize {
    return [MYLaunchAdvertCache diskCacheSize];
}

+ (NSString *)launchAdvertCachePath {
    return [MYLaunchAdvertCache launchAdCachePath];
}

+ (NSString *)cacheImageURLString {
    return [MYLaunchAdvertCache getCacheImageUrl];
}

+ (NSString *)cacheVideoURLString {
    return [MYLaunchAdvertCache getCacheVideoUrl];
}

#pragma mark - private
+ (MYLaunchAdvert *)shareLaunchAd {
    static MYLaunchAdvert *instance = nil;
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        instance = [[MYLaunchAdvert alloc] init];
    });
    return instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupLaunchAd];
        [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationWillEnterForegroundNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification * _Nonnull note) {
                                                          [self setupLaunchAdEnterForeground];
                                                      }];
        [[NSNotificationCenter defaultCenter] addObserverForName:MYLaunchAdDetailPageWillShowNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification * _Nonnull note) {
                                                          _detailPageShowing = YES;
                                                      }];
        [[NSNotificationCenter defaultCenter] addObserverForName:MYLaunchAdDetailPageShowFinishNotification
                                                          object:nil
                                                           queue:nil
                                                      usingBlock:^(NSNotification * _Nonnull note) {
                                                          _detailPageShowing = NO;
                                                      }];
    }
    return self;
}

- (void)setupLaunchAdEnterForeground {
    switch (_launchAdType) {
        case MYLaunchAdTypeImage:{
            if (!_imageAdConfiguration.showEnterForeground || _detailPageShowing) {
                return;
            }
            [self setupLaunchAd];
            [self setupImageAdForConfiguration:_imageAdConfiguration];
        }
            break;
        case MYLaunchAdTypeVideo:{
            if (!_videoAdConfiguration.showEnterForeground || _detailPageShowing) {
                return;
            }
            [self setupLaunchAd];
            [self setupVideoAdForConfiguration:_videoAdConfiguration];
        }
            break;
        default:
            break;
    }
}

- (void)setupLaunchAd {
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.rootViewController = [[MYLaunchAdvertViewController alloc] init];
    _window.rootViewController.view.backgroundColor = [UIColor clearColor];
    _window.rootViewController.view.userInteractionEnabled = NO;
    _window.windowLevel = UIWindowLevelStatusBar + 1;
    _window.hidden = NO;
    _window.alpha = 1;
    
    // 添加launchImageView
    [_window addSubview:[[MYLaunchImageView alloc] initWithSourceType:_sourceType]];
}

// 图片
- (void)setupImageAdForConfiguration:(MYLaunchImageAdvertConfiguration *)configuration {
    if (!_window) {
        return;
    }
    [self removeSubViewsExceptLaunchAdImageView];
    MYLaunchAdvertImageView *adImageView = [[MYLaunchAdvertImageView alloc] init];
    [_window addSubview:adImageView];
    // frame
    if (configuration.frame.size.width > 0 && configuration.frame.size.height > 0) {
        adImageView.frame = configuration.frame;
    }
    
    if (configuration.contentMode) {
        adImageView.contentMode = configuration.contentMode;
    }
    
    // webImage
    if (configuration.imageNameOrURLString.length && MYISURLString(configuration.imageNameOrURLString)) {
        [MYLaunchAdvertCache async_saveImageUrl:configuration.imageNameOrURLString];
        // 自设图片
        if ([self.delegate respondsToSelector:@selector(launchAdvert:launchAdImageView:URL:)]) {
            [self.delegate launchAdvert:self launchAdImageView:adImageView URL:[NSURL URLWithString:configuration.imageNameOrURLString]];
        } else {
            if (!configuration.imageOption) {
                configuration.imageOption = MYLaunchAdvertImageDefault;
            }
            MYWeakSelf
            [adImageView ad_setImageWithURL:[NSURL URLWithString:configuration.imageNameOrURLString] placeholderImage:nil GIFImageCycleOnce:configuration.GIFImageCycleOnce options:configuration.imageOption GIFImageCycleOnceFinish:^{
                // GIF不循环,播放完成
                [[NSNotificationCenter defaultCenter] postNotificationName:MYLaunchAdGIFImageCycleOnceFinishNotification object:nil userInfo:@{@"imageNameOrURLString":configuration.imageNameOrURLString}];
                
            } completed:^(UIImage *image,NSData *imageData,NSError *error,NSURL *url){
                if(!error){
                    if ([weakSelf.delegate respondsToSelector:@selector(launchAdvert:imageDownLoadFinish:imageData:)]) {
                        [weakSelf.delegate launchAdvert:self imageDownLoadFinish:image imageData:imageData];
                    }
                }
            }];
            
            if (configuration.imageOption == MYLaunchAdvertImageCacheInBackground) {
                // 缓存中未有，完成显示
                if (![MYLaunchAdvertCache checkImageInCacheWithURL:[NSURL URLWithString:configuration.imageNameOrURLString]]) {
                    [self removeAndAnimateDefault];
                    return;
                }
            }
        }
    } else {
        if (configuration.imageNameOrURLString.length) {
            NSData *data = MYDataWithFileName(configuration.imageNameOrURLString);
            if (MYISGIFTypeWithData(data)) {
                FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:data];
                adImageView.animatedImage = image;
                adImageView.image = nil;
                __weak typeof(adImageView) w_adImageView = adImageView;
                adImageView.loopCompletionBlock = ^(NSUInteger loopCountRemaining) {
                    if (configuration.GIFImageCycleOnce) {
                        [w_adImageView stopAnimating];
                        MYLog(@"GIF不循环,播放完成");
                        [[NSNotificationCenter defaultCenter] postNotificationName:MYLaunchAdGIFImageCycleOnceFinishNotification object:@{@"imageNameOrURLString":configuration.imageNameOrURLString}];
                    }
                };
            } else {
                adImageView.animatedImage = nil;
                adImageView.image = [UIImage imageWithData:data];
            }
            if ([self.delegate respondsToSelector:@selector(launchAdvert:imageDownLoadFinish:imageData:)]) {
                [self.delegate launchAdvert:self imageDownLoadFinish:[UIImage imageWithData:data] imageData:data];
            }
        } else {
            MYLog(@"未设置广告图片");
        }
    }
    
    // skipButton
    [self addSkipButtonForConfiguration:configuration];
    [self startSkipDispathTimer];
    
    // customView
    if (configuration.subViews.count > 0) {
        [self addSubViews:configuration.subViews];
    }
    
    MYWeakSelf
    adImageView.click = ^(CGPoint point) {
        [weakSelf clickAndPoint:point];
    };
}

- (void)addSkipButtonForConfiguration:(MYLaunchAdvertConfiguration *)configuration {
    if (!configuration.duration) {
        configuration.duration = 5;
    }
    
    if (!configuration.skipButtonType) {
        configuration.skipButtonType = MYLaunchAdvertButtonSkipTypeSquareTimeText;
    }
    
    if (configuration.customSkipView) {
        [_window addSubview:configuration.customSkipView];
    } else {
        if (!_skipButton) {
            _skipButton = [[MYLaunchAdvertButton alloc] initWithSkipType:configuration.skipButtonType];
            _skipButton.hidden = YES;
            [_skipButton addTarget:self action:@selector(skipButtonClick) forControlEvents:UIControlEventTouchUpInside];
        }
        [_window addSubview:_skipButton];
        [_skipButton setTitleWithSkipType:configuration.skipButtonType duration:configuration.duration];
    }
}

// 视频
- (void)setupVideoAdForConfiguration:(MYLaunchVideoAdvertConfiguration *)configuration {
    if (!_window) {
        return;
    }
    [self removeSubViewsExceptLaunchAdImageView];
    
    if (!_adVideoView) {
        _adVideoView = [[MYLaunchAdvertVideoView alloc] init];
    }
    [_window addSubview:_adVideoView];
    
    // frame
    if (configuration.frame.size.width > 0 && configuration.frame.size.height > 0) {
        _adVideoView.frame = configuration.frame;
    }
    
    if (configuration.videoGravity) {
        _adVideoView.videoGravity = configuration.videoGravity;
    }
    
    _adVideoView.videoCycleOnce = configuration.videoCycleOnce;
    
    if (configuration.videoCycleOnce) {
        [[NSNotificationCenter defaultCenter] addObserverForName:AVPlayerItemDidPlayToEndTimeNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
            MYLog(@"video不循环,播放完成");
            [[NSNotificationCenter defaultCenter] postNotificationName:MYLaunchAdVideoCycleOnceFinishNotification object:nil userInfo:@{@"videoNameOrURLString":configuration.videoNameOrURLString}];
        }];
    }
    
    // video 数据源
    if (configuration.videoNameOrURLString.length && MYISURLString(configuration.videoNameOrURLString)) {
        [MYLaunchAdvertCache async_saveVideoUrl:configuration.videoNameOrURLString];
        NSURL *pathURL = [MYLaunchAdvertCache getCacheVideoWithURL:[NSURL URLWithString:configuration.videoNameOrURLString]];
        if (pathURL) {
            if ([self.delegate respondsToSelector:@selector(launchAdvert:videoDownLoadFinish:)]) {
                [self.delegate launchAdvert:self videoDownLoadFinish:pathURL];
            }
            _adVideoView.contentURL = pathURL;
            [_adVideoView.videoPlayer.player play];
        } else {
            MYWeakSelf
            [[MYLaunchAdvertDownloader sharedDownloader] downloadVideoWithURL:[NSURL URLWithString:configuration.videoNameOrURLString] progress:^(unsigned long long total, unsigned long long current) {
                if ([weakSelf.delegate respondsToSelector:@selector(launchAdvert:videoDownLoadProgress:total:current:)]) {
                    [weakSelf.delegate launchAdvert:self videoDownLoadProgress:current/(float)total total:total current:current];
                }
            }  completed:^(NSURL * _Nullable location, NSError * _Nullable error){
                if (!error) {
                    if ([weakSelf.delegate respondsToSelector:@selector(launchAdvert:videoDownLoadFinish:)]) {
                        [weakSelf.delegate launchAdvert:self videoDownLoadFinish:location];
                    }
                }
            }];
            /***视频缓存,提前显示完成 */
            [self removeAndAnimateDefault];
            return;
        }
    } else {
        if (configuration.videoNameOrURLString.length) {
            NSURL *pathURL = nil;
            NSURL *cachePathURL = [[NSURL alloc] initFileURLWithPath:[MYLaunchAdvertCache videoPathWithFileName:configuration.videoNameOrURLString]];
            // 若本地视频未在沙盒缓存文件夹中
            if (![MYLaunchAdvertCache checkVideoInCacheWithFileName:configuration.videoNameOrURLString]) {
                /***如果不在沙盒文件夹中则将其复制一份到沙盒缓存文件夹中/下次直接取缓存文件夹文件,加快文件查找速度 */
                NSURL *bundleURL = [[NSBundle mainBundle] URLForResource:configuration.videoNameOrURLString withExtension:nil];
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [[NSFileManager defaultManager] copyItemAtURL:bundleURL toURL:cachePathURL error:nil];
                });
                pathURL = bundleURL;
            } else {
                pathURL = cachePathURL;
            }
            
            if (pathURL) {
                if ([self.delegate respondsToSelector:@selector(launchAdvert:videoDownLoadFinish:)]) {
                    [self.delegate launchAdvert:self videoDownLoadFinish:pathURL];
                }
                _adVideoView.contentURL = pathURL;
                [_adVideoView.videoPlayer.player play];
                
            } else {
                MYLog(@"Error:广告视频未找到,请检查名称是否有误!");
            }
        } else {
            MYLog(@"未设置广告视频");
        }
    }
    
    // skipButton
    [self addSkipButtonForConfiguration:configuration];
    [self startSkipDispathTimer];
    
    //customView
    if (configuration.subViews.count > 0) {
        [self addSubViews:configuration.subViews];
    }
    MYWeakSelf
    _adVideoView.click = ^(CGPoint point) {
        [weakSelf clickAndPoint:point];
    };
}

#pragma mark - add subViews
- (void)addSubViews:(NSArray *)subViews {
    [subViews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [_window addSubview:view];
    }];
}

#pragma mark - set
- (void)setImageAdConfiguration:(MYLaunchImageAdvertConfiguration *)imageAdConfiguration {
    _imageAdConfiguration = imageAdConfiguration;
    _launchAdType = MYLaunchAdTypeImage;
    [self setupImageAdForConfiguration:imageAdConfiguration];
}

- (void)setVideoAdConfiguration:(MYLaunchVideoAdvertConfiguration *)videoAdConfiguration {
    _videoAdConfiguration = videoAdConfiguration;
    _launchAdType = MYLaunchAdTypeVideo;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(CGFLOAT_MIN * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setupVideoAdForConfiguration:videoAdConfiguration];
    });
}

- (void)setWaitDataDuration:(NSInteger)waitDataDuration {
    _waitDataDuration = waitDataDuration;
    /** 数据等待 */
    [self startWaitDataDispathTiemr];
}

#pragma mark - Action
- (void)skipButtonClick {
    [self removeAndAnimated:YES];
}

- (void)removeAndAnimated:(BOOL)animated {
    if (animated) {
        [self removeAndAnimate];
    } else {
        [self remove];
    }
}

- (void)clickAndPoint:(CGPoint)point {
    self.clickPoint = point;
    MYLaunchAdvertConfiguration * configuration = [self commonConfiguration];
    if ([self.delegate respondsToSelector:@selector(launchAdvert:clickAndOpenModel:clickPoint:)]) {
        [self.delegate launchAdvert:self clickAndOpenModel:configuration.openModel clickPoint:point];
        [self removeAndAnimateDefault];
    }
}

- (MYLaunchAdvertConfiguration *)commonConfiguration {
    MYLaunchAdvertConfiguration *configuration = nil;
    switch (_launchAdType) {
        case MYLaunchAdTypeVideo:
            configuration = _videoAdConfiguration;
            break;
        case MYLaunchAdTypeImage:
            configuration = _imageAdConfiguration;
            break;
        default:
            break;
    }
    return configuration;
}

- (void)startWaitDataDispathTiemr {
    __block NSInteger duration = defaultWaitDataDuration;
    if (_waitDataDuration) {
        duration = _waitDataDuration;
    }
    _waitDataTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    NSTimeInterval period = 1.0;
    dispatch_source_set_timer(_waitDataTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_waitDataTimer, ^{
        if(duration == 0) {
            DISPATCH_SOURCE_CANCEL_SAFE(_waitDataTimer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [[NSNotificationCenter defaultCenter] postNotificationName:MYLaunchAdWaitDataDurationArriveNotification object:nil];
                [self remove];
                return;
            });
        }
        duration--;
    });
    dispatch_resume(_waitDataTimer);
}

- (void)startSkipDispathTimer {
    MYLaunchAdvertConfiguration *configuration = [self commonConfiguration];
    DISPATCH_SOURCE_CANCEL_SAFE(_waitDataTimer);
    if (!configuration.skipButtonType) {
        configuration.skipButtonType = MYLaunchAdvertButtonSkipTypeSquareTimeText;//默认
    }
    __block NSInteger duration = 5;//默认
    if (configuration.duration) {
        duration = configuration.duration;
    }
    
    if (configuration.skipButtonType == MYLaunchAdvertButtonSkipTypeRoundProgressTime || configuration.skipButtonType == MYLaunchAdvertButtonSkipTypeRoundProgressText) {
        [_skipButton startRoundDispathTimerWithDuration:duration];
    }
    NSTimeInterval period = 1.0;
    _skipTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0));
    dispatch_source_set_timer(_skipTimer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_skipTimer, ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([self.delegate respondsToSelector:@selector(launchAdvert:customSkipView:duration:)]) {
                [self.delegate launchAdvert:self customSkipView:configuration.customSkipView duration:duration];
            }
            if (!configuration.customSkipView) {
                [_skipButton setTitleWithSkipType:configuration.skipButtonType duration:duration];
            }
            if (duration == 0) {
                DISPATCH_SOURCE_CANCEL_SAFE(_skipTimer);
                [self removeAndAnimate];
                return ;
            }
            duration--;
        });
    });
    dispatch_resume(_skipTimer);
}

- (void)removeAndAnimate {
    
    MYLaunchAdvertConfiguration * configuration = [self commonConfiguration];
    CGFloat duration = showFinishAnimateTimeDefault;
    if (configuration.showFinishAnimateTime > 0) {
        duration = configuration.showFinishAnimateTime;
    }
    switch (configuration.showFinishAnimate) {
        case ShowFinishAnimateNone:{
            [self remove];
        }
            break;
        case ShowFinishAnimateFadein:{
            [self removeAndAnimateDefault];
        }
            break;
        case ShowFinishAnimateLite:{
            [UIView transitionWithView:_window duration:duration options:UIViewAnimationOptionCurveEaseOut animations:^{
                _window.transform = CGAffineTransformMakeScale(1.5, 1.5);
                _window.alpha = 0;
            } completion:^(BOOL finished) {
                [self remove];
            }];
        }
            break;
        case ShowFinishAnimateFlipFromLeft:{
            [UIView transitionWithView:_window duration:duration options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
                _window.alpha = 0;
            } completion:^(BOOL finished) {
                [self remove];
            }];
        }
            break;
        case ShowFinishAnimateFlipFromBottom:{
            [UIView transitionWithView:_window duration:duration options:UIViewAnimationOptionTransitionFlipFromBottom animations:^{
                _window.alpha = 0;
            } completion:^(BOOL finished) {
                [self remove];
            }];
        }
            break;
        case ShowFinishAnimateCurlUp:{
            [UIView transitionWithView:_window duration:duration options:UIViewAnimationOptionTransitionCurlUp animations:^{
                _window.alpha = 0;
            } completion:^(BOOL finished) {
                [self remove];
            }];
        }
            break;
        default:{
            [self removeAndAnimateDefault];
        }
            break;
    }
}

- (void)removeAndAnimateDefault {
    MYLaunchAdvertConfiguration *configuration = [self commonConfiguration];
    CGFloat duration = showFinishAnimateTimeDefault;
    if (configuration.showFinishAnimateTime > 0) {
        duration = configuration.showFinishAnimateTime;
    }
    [UIView transitionWithView:_window duration:duration options:UIViewAnimationOptionTransitionNone animations:^{
        _window.alpha = 0;
    } completion:^(BOOL finished) {
        [self remove];
    }];
}

- (void)remove {
    DISPATCH_SOURCE_CANCEL_SAFE(_waitDataTimer)
    DISPATCH_SOURCE_CANCEL_SAFE(_skipTimer)
    REMOVE_FROM_SUPERVIEW_SAFE(_skipButton)
    if (_launchAdType==MYLaunchAdTypeVideo) {
        if (_adVideoView) {
            [_adVideoView stopVideoPlayer];
            REMOVE_FROM_SUPERVIEW_SAFE(_adVideoView)
        }
    }
    [_window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        REMOVE_FROM_SUPERVIEW_SAFE(obj)
    }];
    _window.hidden = YES;
    _window = nil;
    
    if ([self.delegate respondsToSelector:@selector(launchAdvertShowFinish:)]) {
        [self.delegate launchAdvertShowFinish:self];
    }
}

- (void)removeSubViewsExceptLaunchAdImageView {
    [_window.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if(![obj isKindOfClass:[MYLaunchImageView class]]){
            REMOVE_FROM_SUPERVIEW_SAFE(obj)
        }
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
