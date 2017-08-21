//
//  MYWebViewJavascriptBridge2ViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYWebViewJavascriptBridge2ViewController.h"
#import <WebKit/WebKit.h>
#import <WebViewJavascriptBridge.h>

@interface MYWebViewJavascriptBridge2ViewController ()<WKNavigationDelegate,WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@property (nonatomic, strong) WebViewJavascriptBridge *webViewBridge;

@end

@implementation MYWebViewJavascriptBridge2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"WKWebView--WebViewJavascriptBridge";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initWKWebView];
    
    _webViewBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [_webViewBridge setWebViewDelegate:self];
    
    [self registerNativeFunctions];
    
    [self initProgressView];
    
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

#pragma mark - KVO
// 计算wkWebView进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.webView && [keyPath isEqualToString:@"estimatedProgress"]) {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1) {
            [self.progressView setProgress:1.0 animated:YES];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.7 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressView.hidden = YES;
                [self.progressView setProgress:0 animated:NO];
            });
        } else {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}

#pragma mark - WKNavigationDelegate
#pragma mark - WKUIDelegate
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提醒" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)initWKWebView {
    WKWebViewConfiguration *configuration = [[WKWebViewConfiguration alloc] init];
    configuration.userContentController = [WKUserContentController new];
    
    WKPreferences *preferences = [WKPreferences new];
    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    preferences.minimumFontSize = 30.0;
    configuration.preferences = preferences;
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:configuration];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"webViewJavascriptBridge" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadHTMLString:appHtml baseURL:baseURL];
    
    self.webView.UIDelegate = self;
    [self.view addSubview:self.webView];
}

- (void)initProgressView {
    CGFloat kScreenWidth = [[UIScreen mainScreen] bounds].size.width;
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 2)];
    progressView.tintColor = [UIColor redColor];
    progressView.trackTintColor = [UIColor lightGrayColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
}

- (void)dealloc {
    NSLog(@"%s",__FUNCTION__);
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

#pragma mark - private method
- (void)registerNativeFunctions {
    [self registScanFunction];
    
    [self registShareFunction];
    
    [self registLocationFunction];
    
    [self regitstBGColorFunction];
    
    [self registPayFunction];
}

- (void)registLocationFunction {
    [_webViewBridge registerHandler:@"locationClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // 获取位置信息
        
        NSString *location = @"北京市朝阳区望京SOHO";
        // 将结果返回给js
        responseCallback(location);
    }];
}

- (void)registScanFunction {
    // 注册的handler 是供 JS调用Native 使用的。
    [_webViewBridge registerHandler:@"scanClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"扫一扫");
        NSString *scanResult = @"http://www.baidu.com";
        responseCallback(scanResult);
    }];
}

- (void)registShareFunction {
    [_webViewBridge registerHandler:@"shareClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        // 在这里执行分享的操作
        NSString *title = [tempDic objectForKey:@"title"];
        NSString *content = [tempDic objectForKey:@"content"];
        NSString *url = [tempDic objectForKey:@"url"];
        
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"分享成功:%@,%@,%@",title,content,url];
        responseCallback(result);
    }];
}

- (void)regitstBGColorFunction {
    __weak typeof(self) weakSelf = self;
    [_webViewBridge registerHandler:@"colorClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        
        CGFloat r = [[tempDic objectForKey:@"r"] floatValue];
        CGFloat g = [[tempDic objectForKey:@"g"] floatValue];
        CGFloat b = [[tempDic objectForKey:@"b"] floatValue];
        CGFloat a = [[tempDic objectForKey:@"a"] floatValue];
        
        weakSelf.webView.backgroundColor = [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a];
    }];
}

- (void)registPayFunction {
    [_webViewBridge registerHandler:@"payClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        // data 的类型与 JS中传的参数有关
        NSDictionary *tempDic = data;
        
        NSString *orderNo = [tempDic objectForKey:@"order_no"];
        long long amount = [[tempDic objectForKey:@"amount"] longLongValue];
        NSString *subject = [tempDic objectForKey:@"subject"];
        NSString *channel = [tempDic objectForKey:@"channel"];
        // 支付操作...
        
        // 将分享的结果返回到JS中
        NSString *result = [NSString stringWithFormat:@"支付成功:%@,%@,%@",orderNo,subject,channel];
        responseCallback(result);
    }];
}

@end
