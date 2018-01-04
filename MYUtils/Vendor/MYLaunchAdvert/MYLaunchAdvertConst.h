//
//  MYLaunchAdvertConst.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MYWeakSelf __weak typeof(self) weakSelf = self;

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

#define MYISURLString(string)  ([string hasPrefix:@"https://"] || [string hasPrefix:@"http://"]) ? YES:NO
#define MYStringContainsSubString(string,subString)  ([string rangeOfString:subString].location == NSNotFound) ? NO:YES

#ifdef DEBUG
#define MYLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define MYLog(...)
#endif

#define MYISGIFTypeWithData(data)\
({\
BOOL result = NO;\
if(!data) result = NO;\
uint8_t c;\
[data getBytes:&c length:1];\
if(c == 0x47) result = YES;\
(result);\
})

#define MYISVideoTypeWithPath(path)\
({\
BOOL result = NO;\
if([path hasSuffix:@".mp4"])  result =  YES;\
(result);\
})

#define MYDataWithFileName(name)\
({\
NSData *data = nil;\
NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];\
if([[NSFileManager defaultManager] fileExistsAtPath:path]){\
data = [NSData dataWithContentsOfFile:path];\
}\
(data);\
})

#define DISPATCH_SOURCE_CANCEL_SAFE(time) if(time)\
{\
dispatch_source_cancel(time);\
time = nil;\
}

#define REMOVE_FROM_SUPERVIEW_SAFE(view) if(view)\
{\
[view removeFromSuperview];\
view = nil;\
}

UIKIT_EXTERN NSString *const MYCacheImageUrlStringKey;
UIKIT_EXTERN NSString *const MYCacheVideoUrlStringKey;

UIKIT_EXTERN NSString *const MYLaunchAdWaitDataDurationArriveNotification;
UIKIT_EXTERN NSString *const MYLaunchAdDetailPageWillShowNotification;
UIKIT_EXTERN NSString *const MYLaunchAdDetailPageShowFinishNotification;
/** GIFImageCycleOnce = YES(GIF不循环)时, GIF动图播放完成通知 */
UIKIT_EXTERN NSString *const MYLaunchAdGIFImageCycleOnceFinishNotification;
/** videoCycleOnce = YES(视频不循环时) ,video播放完成通知 */
UIKIT_EXTERN NSString *const MYLaunchAdVideoCycleOnceFinishNotification;


/** 启动图来源 */
typedef NS_ENUM(NSInteger, MYLaunchImageViewSourceType) {
    /** LaunchImage(default) */
    MYLaunchImageViewSourceTypeLaunchImage = 1,
    /** LaunchScreen.storyboard */
    MYLaunchImageViewSourceTypeLaunchScreen = 2,
};

typedef NS_ENUM(NSInteger, LaunchImagesSource){
    LaunchImagesSourceLaunchImage = 1,
    LaunchImagesSourceLaunchScreen = 2,
};

typedef NS_ENUM(NSInteger, MYLaunchAdvertButtonSkipType) {
    MYLaunchAdvertButtonSkipTypeNone            = 1,  //无
    /** 方形 */
    MYLaunchAdvertButtonSkipTypeSquareTime,           //方形:倒计时
    MYLaunchAdvertButtonSkipTypeSquareText,           //方形:跳过
    MYLaunchAdvertButtonSkipTypeSquareTimeText,       //方形:倒计时+跳过 (default)
    /** 圆形 */
    MYLaunchAdvertButtonSkipTypeRoundTime,            //圆形:倒计时
    MYLaunchAdvertButtonSkipTypeRoundText,            //圆形:跳过
    MYLaunchAdvertButtonSkipTypeRoundProgressTime,    //圆形:进度圈+倒计时
    MYLaunchAdvertButtonSkipTypeRoundProgressText,    //圆形:进度圈+跳过
};

typedef NS_OPTIONS(NSUInteger, MYLaunchAdvertImageOptions) {
    /** 有缓存,读取缓存,不重新下载,没缓存先下载,并缓存 */
    MYLaunchAdvertImageDefault = 1 << 0,
    /** 只下载,不缓存 */
    MYLaunchAdvertImageOnlyLoad = 1 << 1,
    /** 先读缓存,再下载刷新图片和缓存 */
    MYLaunchAdvertImageRefreshCached = 1 << 2 ,
    /** 后台缓存本次不显示,缓存OK后下次再显示(建议使用这种方式)*/
    MYLaunchAdvertImageCacheInBackground = 1 << 3
};

