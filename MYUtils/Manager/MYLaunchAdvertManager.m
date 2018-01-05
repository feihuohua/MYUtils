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
#import "MYNetworking.h"
#import "WebViewController.h"

@interface MYLaunchAdvertManager()<MYLaunchAdvertDelegate>

@end

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

- (void)showSplashScreenNetWorkImage {
    
    //设置你工程的启动页使用的是:LaunchImage 还是 LaunchScreen.storyboard(不设置默认:LaunchImage)
    [MYLaunchAdvert setLaunchSourceType:MYLaunchImageViewSourceTypeLaunchImage];
    
    //1.因为数据请求是异步的,请在数据请求前,调用下面方法配置数据等待时间.
    //2.设为3即表示:启动页将停留3s等待服务器返回广告数据,3s内等到广告数据,将正常显示广告,否则将不显示
    //3.数据获取成功,配置广告数据后,自动结束等待,显示广告
    //注意:请求广告数据前,必须设置此属性,否则会先进入window的的根控制器
    [MYLaunchAdvert setWaitDataDuration:3];
    
    NSMutableDictionary *paramters = [NSMutableDictionary dictionary];
    paramters[@"pos"] = @(3005);
    
    [MYNetworking postWithUrl:@"http://114.215.108.225:8081/d/json/1.0" refreshCache:NO params:paramters success:^(id response) {
        
        NSString *url = response[@"3005"][0][@"material"][0][@"src"];
        
        if ([url containsString:@"jpg"] || [url containsString:@"png"]) {
            //配置广告数据
            MYLaunchImageAdvertConfiguration *imageAdconfiguration = [MYLaunchImageAdvertConfiguration new];
            //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
            imageAdconfiguration.imageNameOrURLString = response[@"3005"][0][@"material"][0][@"src"];
            //缓存机制(仅对网络图片有效)
            //为告展示效果更好,可设置为XHLaunchAdImageCacheInBackground,先缓存,下次显示
            imageAdconfiguration.imageOption = MYLaunchAdvertImageDefault;
            //广告点击打开页面参数(openModel可为NSString,模型,字典等任意类型)
            imageAdconfiguration.openModel = @"https://www.quanmin.tv/";
            //显示开屏广告
            [MYLaunchAdvert imageAdWithImageAdConfiguration:imageAdconfiguration delegate:self];
        } else if ([url containsString:@"gif"]) {
            
            //配置广告数据
            MYLaunchImageAdvertConfiguration *imageAdconfiguration = [MYLaunchImageAdvertConfiguration new];
            //广告停留时间
            imageAdconfiguration.duration = 5;
            //广告图片URLString/或本地图片名(.jpg/.gif请带上后缀)
            imageAdconfiguration.imageNameOrURLString = response[@"3005"][0][@"material"][0][@"src"];
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
            
        } else {
            
            //配置广告数据
            MYLaunchVideoAdvertConfiguration *videoAdconfiguration = [MYLaunchVideoAdvertConfiguration new];
            //广告视频URLString/或本地视频名(请带上后缀)
            //注意:视频广告只支持先缓存,下次显示(看效果请二次运行)
            videoAdconfiguration.videoNameOrURLString = response[@"3005"][0][@"material"][0][@"src"];
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
            [MYLaunchAdvert videoAdWithVideoAdConfiguration:videoAdconfiguration delegate:self];
        }
    } fail:^(NSError *error) {
        
    }];

}

/**
 广告点击事件回调
 */
- (void)launchAdvert:(MYLaunchAdvert *)launchAdvert clickAndOpenModel:(id)openModel clickPoint:(CGPoint)clickPoint {
    
    NSLog(@"广告点击事件");
    
    /** openModel即配置广告数据设置的点击广告时打开页面参数(configuration.openModel) */
    if (!openModel) {
        return;
    }
    [launchAdvert removeAndAnimated:YES];
    WebViewController *VC = [[WebViewController alloc] init];
    NSString *urlString = (NSString *)openModel;
    VC.URLString = urlString;
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    [rootVC.childViewControllers.firstObject.childViewControllers.firstObject.navigationController pushViewController:VC animated:YES];
    
}

@end
