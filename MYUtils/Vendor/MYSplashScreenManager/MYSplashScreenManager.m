//
//  MYSplashScreenManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/18.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYSplashScreenManager.h"
#import <SDWebImage/SDWebImageDownloader.h>

@interface MYSplashScreenController: UIViewController

@property (nonatomic, strong, readonly) UIImage *image;

- (instancetype)initWithImage:(UIImage *)image;

@end


@implementation MYSplashScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = self.image;
    [self.view addSubview:imageView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (instancetype)initWithImage:(UIImage *)image {
    if (self = [super init]) {
        _image = image;
    }
    return self;
}

@end

@interface MYSplashScreenManager ()

@property (nonatomic, copy) NSString *requestPath;

@property (nonatomic, strong) UIWindow *splashWindow;

@end

@implementation MYSplashScreenManager

#define SPLASH_SCREEN_IMAGE_URL @"splash_screen_image_url"

static MYSplashScreenManager *_manager = nil;
static dispatch_once_t _onceToken;
static NSInteger _tryCount = 0;

+ (MYSplashScreenManager *)sharedManager {
    dispatch_once(&_onceToken, ^{
        _manager = [[MYSplashScreenManager alloc] init];
        _tryCount = 3;
    });
    return _manager;
}

- (void)showSplashScreenWithDuration:(CGFloat)time {
    NSData *imageDate = [NSData dataWithContentsOfFile:[self imageCachePath]];
    if (imageDate) {
        if (!self.splashWindow) {
            self.splashWindow = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
            self.splashWindow.backgroundColor = [UIColor clearColor];
            self.splashWindow.windowLevel = UIWindowLevelStatusBar + 10000;
            self.splashWindow.rootViewController = [[MYSplashScreenController alloc] initWithImage:[UIImage imageWithData:imageDate]];
            [self.splashWindow makeKeyAndVisible];
            [self performSelector:@selector(removeSplashScreen) withObject:nil afterDelay:(time > 0 ? time : 1)];
        }
    }
}

- (void)removeSplashScreen {
    [UIView animateWithDuration:0.7 delay:0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseInOut animations:^{
        [self.splashWindow.rootViewController.view.layer setValue:@3 forKeyPath:@"transform.scale"];
        self.splashWindow.rootViewController.view.alpha = 0;
    } completion:^(BOOL finished) {
        self.splashWindow.windowLevel = normal;
        self.splashWindow = nil;
    }];
}


- (void)startDownLoadNewImageWithUrl:(NSString *)imageUrl {
    if (!self.requestPath) {
        self.requestPath = imageUrl;
    }
    if (![self.requestPath isEqualToString:[[NSUserDefaults standardUserDefaults] stringForKey:SPLASH_SCREEN_IMAGE_URL]]) {
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:self.requestPath] options:SDWebImageDownloaderLowPriority progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if (error) {
                if (--_tryCount >= 0) {
                    [self performSelector:@selector(startDownLoadNewImageWithUrl:) withObject:nil afterDelay:30];
                    return;
                }
                return;
            }
            if ([data writeToFile:[self imageCachePath] atomically:YES]) {
                [[NSUserDefaults standardUserDefaults] setObject:self.requestPath forKey:SPLASH_SCREEN_IMAGE_URL];
            } else {
                if (--_tryCount >= 0) {
                    [self startDownLoadNewImageWithUrl:nil];
                    [self performSelector:@selector(startDownLoadNewImageWithUrl:) withObject:nil afterDelay:30];
                }
            }
        }];
    }
}


- (NSString *)imageCachePath {
    return [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"splashScreenImage.png"];
}

@end
