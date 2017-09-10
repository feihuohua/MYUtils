//
//  MYWebViewJavascriptBridge1ViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYWebViewJavascriptBridge1ViewController.h"
#import "UtilsMacros.h"
#import <WebViewJavascriptBridge.h>

@interface MYWebViewJavascriptBridge1ViewController ()<UIWebViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@property (nonatomic, strong) WebViewJavascriptBridge *webViewBridge;

@end

@implementation MYWebViewJavascriptBridge1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIWebView--WebViewJavascriptBridge";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"webViewJavascriptBridge" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadHTMLString:appHtml baseURL:baseURL];
    
    _webViewBridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [_webViewBridge setWebViewDelegate:self];
    
    // 添加JS 要调用的Native 功能
    [self registerNativeFunctions];
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

- (void)registScanFunction
{
    // 注册的handler 是供 JS调用Native 使用的。
    [_webViewBridge registerHandler:@"scanClick" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"扫一扫");
        NSString *scanResult = @"http://www.baidu.com";
        responseCallback(scanResult);
    }];
}

- (void)registShareFunction
{
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

- (void)regitstBGColorFunction
{
    weakSelf(self)
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

- (void)registPayFunction
{
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

- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        _webView.delegate = self;
        _webView.scrollView.bounces = YES;
        _webView.scrollView.delegate = self;
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
        _webView.scrollView.showsVerticalScrollIndicator = NO;
        _webView.scrollView.showsHorizontalScrollIndicator = NO;
        _webView.opaque = NO;
        [self.view addSubview:_webView];
    }
    return _webView;
}

@end
