//
//  MYLaunchAdvertManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYLaunchAdvertManager.h"
#import "MYLaunchAdvert.h"
#import "MYLaunchAdvertConst.h"
#import "MYLaunchAdvertConfiguration.h"

@implementation MYLaunchAdvertManager

+ (instancetype)shareManager {
    static MYLaunchAdvertManager *_shareManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareManager = [[MYLaunchAdvertManager alloc] init];
    });
    return _shareManager;
}

- (void)showSplashScreenLocalVideo {
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [MYLaunchAdvert setLaunchSourceType:MYLaunchImageViewSourceTypeLaunchImage];
    
    //配置广告数据
    MYLaunchVideoAdvertConfiguration *videoAdconfiguration = [MYLaunchVideoAdvertConfiguration new];
    //广告停留时间
    videoAdconfiguration.duration = 5;
    //广告frame
    videoAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    //广告视频URLString/或本地视频名(请带上后缀)
    videoAdconfiguration.videoNameOrURLString = @"video1.mp4";
    //视频填充模式
    videoAdconfiguration.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //是否只循环播放一次
    videoAdconfiguration.videoCycleOnce = NO;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    videoAdconfiguration.openModel = @"https://www.quanmin.tv/";
    //跳过按钮类型
    videoAdconfiguration.skipButtonType = MYLaunchAdvertButtonSkipTypeRoundProgressTime;
    //广告显示完成动画
    videoAdconfiguration.showFinishAnimate = ShowFinishAnimateLite;
    //广告显示完成动画时间
    videoAdconfiguration.showFinishAnimateTime = 0.8;
    //后台返回时,是否显示广告
    videoAdconfiguration.showEnterForeground = NO;
    //设置要添加的子视图(可选)
    //videoAdconfiguration.subViews = [self launchAdSubViews];
    //显示开屏广告
    [MYLaunchAdvert videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
    
}

- (void)showSplashScreenLocalImage {
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [MYLaunchAdvert setLaunchSourceType:MYLaunchImageViewSourceTypeLaunchImage];
    
    //配置广告数据
    MYLaunchImageAdvertConfiguration *imageAdconfiguration = [MYLaunchImageAdvertConfiguration new];
    //广告停留时间
    imageAdconfiguration.duration = 5;
    //广告frame
    imageAdconfiguration.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 0.8);
    //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
    imageAdconfiguration.imageNameOrURLString = @"image12.gif";
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    imageAdconfiguration.GIFImageCycleOnce = NO;
    //图片填充模式
    imageAdconfiguration.contentMode = UIViewContentModeScaleAspectFill;
    //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
    imageAdconfiguration.openModel = @"https://www.quanmin.tv/";
    //广告显示完成动画
    imageAdconfiguration.showFinishAnimate = ShowFinishAnimateLite;
    //广告显示完成动画时间
    imageAdconfiguration.showFinishAnimateTime = 0.8;
    //跳过按钮类型
    imageAdconfiguration.skipButtonType = MYLaunchAdvertButtonSkipTypeRoundProgressTime;
    //后台返回时,是否显示广告
    imageAdconfiguration.showEnterForeground = NO;
    //设置要添加的子视图(可选)
    //imageAdconfiguration.subViews = [self launchAdSubViews];
    //显示开屏广告
    [MYLaunchAdvert imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
}

@end
