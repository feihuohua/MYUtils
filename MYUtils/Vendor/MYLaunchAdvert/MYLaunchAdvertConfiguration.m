//
//  MYLaunchAdvertConfiguration.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYLaunchAdvertConfiguration.h"

@implementation MYLaunchAdvertConfiguration

@end

#pragma mark - 图片广告相关
@implementation MYLaunchImageAdvertConfiguration

+ (MYLaunchImageAdvertConfiguration *)defaultConfiguration {
    //配置广告数据
    MYLaunchImageAdvertConfiguration *configuration = [MYLaunchImageAdvertConfiguration new];
    //广告停留时间
    configuration.duration = 5;
    //广告frame
    configuration.frame = [UIScreen mainScreen].bounds;
    //设置GIF动图是否只循环播放一次(仅对动图设置有效)
    configuration.GIFImageCycleOnce = NO;
    //缓存机制
    configuration.imageOption = MYLaunchAdvertImageDefault;
    //图片填充模式
    configuration.contentMode = UIViewContentModeScaleToFill;
    //广告显示完成动画
    configuration.showFinishAnimate =ShowFinishAnimateFadein;
    //显示完成动画时间
    configuration.showFinishAnimateTime = showFinishAnimateTimeDefault;
    //跳过按钮类型
    configuration.skipButtonType = MYLaunchAdvertButtonSkipTypeSquareTimeText;
    //后台返回时,是否显示广告
    configuration.showEnterForeground = NO;
    return configuration;
}

@end

#pragma mark - 视频广告相关
@implementation MYLaunchVideoAdvertConfiguration

+ (MYLaunchVideoAdvertConfiguration *)defaultConfiguration {
    //配置广告数据
    MYLaunchVideoAdvertConfiguration *configuration = [MYLaunchVideoAdvertConfiguration new];
    //广告停留时间
    configuration.duration = 5;
    //广告frame
    configuration.frame = [UIScreen mainScreen].bounds;
    //视频填充模式
    configuration.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //是否只循环播放一次
    configuration.videoCycleOnce = NO;
    //广告显示完成动画
    configuration.showFinishAnimate =ShowFinishAnimateFadein;
    //显示完成动画时间
    configuration.showFinishAnimateTime = showFinishAnimateTimeDefault;
    //跳过按钮类型
    configuration.skipButtonType = MYLaunchAdvertButtonSkipTypeSquareTimeText;
    //后台返回时,是否显示广告
    configuration.showEnterForeground = NO;
    return configuration;
}

@end
