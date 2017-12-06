//
//  AppDelegate.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "AppDelegate.h"
#import "HKTabBarControllerConfig.h"
#import "TBCityIconFont.h"
#import "UncaughtExceptionHandler.h"
#import "MYFPSStatusManager.h"
#import "MYSplashScreenManager.h"
#import <FLEX/FLEX.h>
#import <FBMemoryProfiler/FBMemoryProfiler.h>
#import "CacheCleanerPlugin.h"
#import "RetainCycleLoggerPlugin.h"
#import "CATLog.h"

#define YouLogI(fmt, ...) [CATLog logI:[NSString stringWithFormat:@"[%@:%d] %s %@",[NSString stringWithFormat:@"%s",__FILE__].lastPathComponent,__LINE__,__func__,fmt],##__VA_ARGS__,@""];

@interface AppDelegate ()<UITabBarControllerDelegate, CYLTabBarControllerDelegate, NSURLConnectionDataDelegate, NSURLSessionDataDelegate> {
    FBMemoryProfiler *_memoryProfiler;
}

@property (nonatomic, strong) NSTimer *repeatingLogExampleTimer;
@property (nonatomic, strong) NSMutableArray *connections;
@end

@implementation AppDelegate

/*
 当程序启动时
 
 1、判断launchOptions字典内的UIApplicationLaunchOptionsShortcutItemKey是否为空
 2、当不为空时,application:didFinishLaunchWithOptions方法返回NO，否则返回YES
 3、在application:performActionForShortcutItem:completionHandler方法内处理点击事件
 */

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [[FLEXManager sharedManager] setNetworkDebuggingEnabled:YES];
    [self sendExampleNetworkRequests];
    self.repeatingLogExampleTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(sendExampleLogMessage) userInfo:nil repeats:YES];

    [[MYSplashScreenManager sharedManager] showSplashScreenWithDuration:1.5];
    [[MYSplashScreenManager sharedManager] startDownLoadNewImageWithUrl:@"http://upload-images.jianshu.io/upload_images/4133010-bb1c14196f3241f7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
   
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    HKTabBarControllerConfig *tabBarControllerConfig = [[HKTabBarControllerConfig alloc] init];
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    tabBarController.delegate = self;
    [self.window setRootViewController:tabBarController];
    [tabBarController setViewDidLayoutSubViewsBlock:^(CYLTabBarController *aTabBarController) {
        UIViewController *viewController = aTabBarController.viewControllers[0];
        UIView *tabBadgePointView0 = [UIView cyl_tabBadgePointViewWithClolor:[UIColor redColor] radius:4.5];
        [viewController.tabBarItem.cyl_tabButton cyl_setTabBadgePointView:tabBadgePointView0];
        [viewController cyl_showTabBadgePoint];
        
        UIView *tabBadgePointView1 = [UIView cyl_tabBadgePointViewWithClolor:[UIColor redColor] radius:4.5];
        [aTabBarController.viewControllers[1] cyl_setTabBadgePointView:tabBadgePointView1];
        [aTabBarController.viewControllers[1] cyl_showTabBadgePoint];
        
        UIView *tabBadgePointView2 = [UIView cyl_tabBadgePointViewWithClolor:[UIColor redColor] radius:4.5];
        [aTabBarController.viewControllers[2] cyl_setTabBadgePointView:tabBadgePointView2];
        [aTabBarController.viewControllers[2] cyl_showTabBadgePoint];
    }];
    
    [self.window makeKeyAndVisible];
    
    [TBCityIconFont setFontName:@"iconfont"];
    [self configShortCutItems];
    [[MYFPSStatusManager sharedInstance] start];
    
    //捕捉意外崩溃
    [UncaughtExceptionHandler InstallUncaughtExceptionHandler];
    
    _memoryProfiler = [[FBMemoryProfiler alloc] initWithPlugins:@[[CacheCleanerPlugin new],
                                                                  [RetainCycleLoggerPlugin new]]
                               retainCycleDetectorConfiguration:nil];
    [_memoryProfiler enable];
    
    //Set ExceptionHandler
    NSSetUncaughtExceptionHandler(&uncaughtExceptionHandler);
    
    //Init log
    [CATLog initWithNumberOfDaysToDelete:3];
    
    //Remote Log
    [CATLog setRemoteLogEnable:YES];
    [CATLog setRemoteIp:@"192.168.1.100" port:1111];
    
    //Set log level
    [CATLog setLogLevel:CATLevelV];
    
    //Set Color
    [CATLog setR:200 G:0 B:0 forLevel:CATLevelE];
    [CATLog setBgR:255 G:255 B:255 forLevel:CATLevelE];
    
    //Redefine log
    YouLogI(@"ReDefine Log by yourself");
    
    //Log normal string
    CLogE(@"Normal string");
    
    NSString* normalStt = [NSString stringWithFormat:@"Normal String"];
    CLogE(normalStt);
    
    //Log format string
    CLogD(@"Format String:string1,%@,%@",@"string2",@"string3");
    
    UIImageView* imgView = [[UIImageView alloc]init];
    CLogD(@"Format String %@",imgView);
    
    //Log Color
    CLogE(@"I am error log. Do you like my color?");
    CLogW(@"I am warning log. Do you like my color?");
    CLogI(@"I am info log. Do you like my color?");
    CLogD(@"I am debug log. Do you like my color?");
    CLogV(@"I am verbose log. Do you like my color?");
    
    return YES;
}

void uncaughtExceptionHandler(NSException *exception){
    [CATLog logCrash:exception];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - CYLTabBarControllerDelegate
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    [[self cyl_tabBarController] updateSelectionStatusIfNeededForTabBarController:tabBarController shouldSelectViewController:viewController];
    return YES;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectControl:(UIControl *)control {
    UIView *animationView;
    
    if ([control cyl_isTabButton]) {
        // 更改红标状态
        if ([[self cyl_tabBarController].selectedViewController cyl_isShowTabBadgePoint]) {
            [[self cyl_tabBarController].selectedViewController cyl_removeTabBadgePoint];
        } else {
            [[self cyl_tabBarController].selectedViewController cyl_showTabBadgePoint];
        }
        
        animationView = [control cyl_tabImageView];
    }
    
    if ([self cyl_tabBarController].selectedIndex % 2 == 0) {
        [self addScaleAnimationOnView:animationView repeatCount:1];
    } else {
        [self addRotateAnimationOnView:animationView];
    }
}

// 缩放动画
- (void)addScaleAnimationOnView:(UIView *)animationView repeatCount:(float)repeatCount {
    //需要实现的帧动画，这里根据需求自定义
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.repeatCount = repeatCount;
    animation.calculationMode = kCAAnimationCubic;
    [animationView.layer addAnimation:animation forKey:nil];
}

// 旋转动画
- (void)addRotateAnimationOnView:(UIView *)animationView {
    // 针对旋转动画，需要将旋转轴向屏幕外侧平移，最大图片宽度的一半
    // 否则背景与按钮图片处于同一层次，当按钮图片旋转时，转轴就在背景图上，动画时会有一部分在背景图之下。
    // 动画结束后复位
    CGFloat oldZPosition = animationView.layer.zPosition;//0
    animationView.layer.zPosition = 65.f / 2;
    [UIView animateWithDuration:0.32 delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
        animationView.layer.transform = CATransform3DMakeRotation(M_PI, 0, 1, 0);
    } completion:nil];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [UIView animateWithDuration:0.70 delay:0 usingSpringWithDamping:1 initialSpringVelocity:0.2 options:UIViewAnimationOptionCurveEaseOut animations:^{
            animationView.layer.transform = CATransform3DMakeRotation(2 * M_PI, 0, 1, 0);
        } completion:nil];
    });
}

/** 创建shortcutItems */
- (void)configShortCutItems {
    NSMutableArray *shortcutItems = [NSMutableArray array];
    UIApplicationShortcutItem *item1 = [[UIApplicationShortcutItem alloc] initWithType:@"1" localizedTitle:@"测试1"];
    UIApplicationShortcutItem *item2 = [[UIApplicationShortcutItem alloc] initWithType:@"2" localizedTitle:@"测试2"];
    [shortcutItems addObject:item1];
    [shortcutItems addObject:item2];
    
    [[UIApplication sharedApplication] setShortcutItems:shortcutItems];
}

/** 处理shortcutItem */
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler {
    switch (shortcutItem.type.integerValue) {
        case 1: { // 测试1
            
        }
        case 2: { // 测试2
            
        }   break;
        default:
            break;
    }
}

- (void)sendExampleLogMessage
{
    // To show off the system log viewer, send 20 example log messages at 1 second intervals.
    static NSInteger count = 0;
    NSLog(@"Example log %ld", (long)count++);
    if (count > 20) {
        [self.repeatingLogExampleTimer invalidate];
    }
}

- (void)sendExampleNetworkRequests
{
    // Async NSURLConnection
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://api.github.com/repos/Flipboard/FLEX/issues"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
    }];
    
    // Sync NSURLConnection
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [NSURLConnection sendSynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://lorempixel.com/320/480/"]] returningResponse:NULL error:NULL];
    });
    
    // NSURLSession
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.timeoutIntervalForRequest = 10.0;
    NSURLSession *mySession = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
    
    NSMutableArray *pendingTasks = [NSMutableArray array];
    
    // NSURLSessionDataTask with delegate
    [pendingTasks addObject:[mySession dataTaskWithURL:[NSURL URLWithString:@"http://cdn.flipboard.com/serviceIcons/v2/social-icon-flipboard-96.png"]]];
    
    // NSURLSessionDownloadTask with delegate
    [pendingTasks addObject:[mySession downloadTaskWithURL:[NSURL URLWithString:@"https://assets-cdn.github.com/images/icons/emoji/unicode/1f44d.png?v5"]]];
    
    // Async NSURLSessionDownloadTask
    [pendingTasks addObject:[[NSURLSession sharedSession] downloadTaskWithURL:[NSURL URLWithString:@"http://lorempixel.com/1024/1024/"] completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
    }]];
    
    // Async NSURLSessionDataTask
    [pendingTasks addObject:[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:@"https://api.github.com/emojis"] completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
    }]];
    
    // Async NSURLSessionUploadTask
    NSMutableURLRequest *uploadRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://google.com/"]];
    uploadRequest.HTTPMethod = @"POST";
    NSData *data = [@"q=test" dataUsingEncoding:NSUTF8StringEncoding];
    [pendingTasks addObject:[mySession uploadTaskWithRequest:uploadRequest fromData:data completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
    }]];
    
    // Remaining requests made through NSURLConnection with a delegate
    NSArray *requestURLStrings = @[ @"http://lorempixel.com/400/400/",
                                    @"http://google.com",
                                    @"http://search.cocoapods.org/api/pods?query=FLEX&amount=1",
                                    @"https://api.github.com/users/Flipboard/repos",
                                    @"http://info.cern.ch/hypertext/WWW/TheProject.html",
                                    @"https://api.github.com/repos/Flipboard/FLEX/issues",
                                    @"https://cloud.githubusercontent.com/assets/516562/3971767/e4e21f58-27d6-11e4-9b07-4d1fe82b80ca.png",
                                    @"http://hipsterjesus.com/api?paras=1&type=hipster-centric&html=false",
                                    @"http://lorempixel.com/750/1334/" ];
    
    NSTimeInterval delayTime = 10.0;
    const NSTimeInterval stagger = 1.0;
    
    // Send off the NSURLSessionTasks (staggered)
    for (NSURLSessionTask *task in pendingTasks) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [task resume];
        });
        delayTime += stagger;
    }
    
    // Begin the NSURLConnection requests (staggered)
    self.connections = [NSMutableArray array];
    for (NSString *urlString in requestURLStrings) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
            [self.connections addObject:[[NSURLConnection alloc] initWithRequest:request delegate:self]];
        });
        delayTime += stagger;
    }
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    [self.connections removeObject:connection];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    [self.connections removeObject:connection];
}

@end
