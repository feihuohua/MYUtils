//
//  AuthenticationWIFIManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "AuthenticationWIFIManager.h"
#import <WebKit/WebKit.h>
#import <SafariServices/SafariServices.h>

@interface AuthenticationWIFIManager ()<WKNavigationDelegate,UIAlertViewDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, assign) BOOL needAlert;
/// 预期加载的url
@property (nonatomic, copy) NSURL *expectUrl;
/// 实际加载的url
@property (nonatomic, copy) NSURL *trueUrl;

@end

@implementation AuthenticationWIFIManager

static AuthenticationWIFIManager *shareManager = nil;

+ (instancetype)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shareManager == nil) {
            shareManager = [[self alloc] init];
            shareManager.expectUrl = [NSURL URLWithString:@"http://www.baidu.com"];
        }
    });
    return shareManager;
}

/// 检查当前wifi是否需要验证密码
- (void)checkIsWifiNeedAuthPasswordWithComplection:(NetworkCheckComplection)complection
                                         needAlert:(BOOL)needAlert {
    self.needAlert = needAlert;
    self.complection = complection;
    NSURLRequest *request = [NSURLRequest requestWithURL:self.expectUrl cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20];
    [self.webView loadRequest:request];
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    decisionHandler(WKNavigationActionPolicyAllow);
    
    self.trueUrl = navigationAction.request.URL;
    if (self.openTestMode) {
        // 测试用 这个url是上海花生地铁wifi的认证页，连上上海花生地铁wifi后，未认证时访问所有网页都会被重定向到该地址
        self.trueUrl= [NSURL URLWithString:@"http://portal.wifi8.com/wifiapp"];
    }
    if ([self.trueUrl.host containsString:@"baidu.com"]) {
        if (self.complection) {
            self.complection(NO);
            self.complection = nil;
        }
    } else {
        // 网页被重定向到了self.trueUrl，wifi需要认证
        if (self.complection) {
            self.complection(YES);
            self.complection = nil;
        }
        
//        if (self.needAlert) {
//#pragma clang diagnostic push
//#pragma clang diagnostic ignored "-Wdeprecated-declarations"
//            [UIAlertView alertViewWithTitle:@"WI-FI认证提醒" message:@"检测到当前WI-FI需要认证才能使用，请尝试去认证网络" cancelButtonTitle:@"取消" otherButtonTitles:@[@"认证"] didDismissConfirmButtionBlock:^(NSInteger buttonIndex) {
//                if (buttonIndex == 1) { // 认证网络
//                    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
//                    if (systemVersion >= 9.0 && systemVersion < 11.0) {
//                        // iOS11下，SFSafariViewController有些问题，页面会白屏...原因暂时未知，如果你知道求告知~
//                        SFSafariViewController *safariVc = [[SFSafariViewController alloc] initWithURL:self.trueUrl];
//                        UIViewController *currentVc = [UIApplication sharedApplication].delegate.window.rootViewController;
//                        if (currentVc.presentedViewController) {
//                            [currentVc.presentedViewController presentViewController:safariVc animated:YES completion:nil];
//                        } else if (currentVc) {
//                            [currentVc presentViewController:safariVc animated:YES completion:nil];
//                        }
//                    } else {
//                        if ([[UIApplication sharedApplication] canOpenURL:self.trueUrl]) {
//                            [[UIApplication sharedApplication] openURL:self.trueUrl];
//                        }
//                    }
//                }
//            } didDismissCancelButtonBlock:nil];
//        }
    }
//#pragma clang diagnostic pop
}

- (WKWebView *)webView {
    if (!_webView) {
        _webView = [[WKWebView alloc] init];
        _webView.frame = CGRectZero;
        _webView.navigationDelegate = self;
    }
    return _webView;
}

@end

