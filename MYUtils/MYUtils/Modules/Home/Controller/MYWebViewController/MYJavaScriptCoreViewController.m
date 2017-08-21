//
//  MYJavaScriptCoreViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYJavaScriptCoreViewController.h"
#import "UtilsMacros.h"
#import "UIColor+Extension.h"
#import <JavaScriptCore/JavaScriptCore.h>

@interface MYJavaScriptCoreViewController ()<UIWebViewDelegate, UIScrollViewDelegate>

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation MYJavaScriptCoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"UIWebView-JavaScriptCore";
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSString *htmlPath = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html"];
    NSString *appHtml = [NSString stringWithContentsOfFile:htmlPath encoding:NSUTF8StringEncoding error:nil];
    NSURL *baseURL = [NSURL fileURLWithPath:htmlPath];
    [self.webView loadHTMLString:appHtml baseURL:baseURL];
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    NSLog(@"webViewDidFinishLoad");
    
    [self addCustomActions];
}

#pragma mark - private method
- (void)addCustomActions {
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    [self addScanWithContext:context];
    
    [self addLocationWithContext:context];
    
    [self addSetBGColorWithContext:context];
    
    [self addShareWithContext:context];
    
    [self addPayActionWithContext:context];
}

- (void)addScanWithContext:(JSContext *)context {
    context[@"scan"] = ^() {
        NSLog(@"扫一扫啦");
    };
}

- (void)addLocationWithContext:(JSContext *)context {
    context[@"getLocation"] = ^() {
        // 获取位置信息
        
        // 将结果返回给js
        NSString *jsStr = [NSString stringWithFormat:@"北京市朝阳区望京SOHO"];
        [[JSContext currentContext] evaluateScript:jsStr];
    };
}

- (void)addShareWithContext:(JSContext *)context {
    context[@"share"] = ^() {
        NSArray *args = [JSContext currentArguments];
        
        if (args.count < 3) {
            return ;
        }
        
        NSString *title = [args[0] toString];
        NSString *content = [args[1] toString];
        NSString *url = [args[2] toString];
        // 在这里执行分享的操作
        
        // 将分享结果返回给js
        NSString *jsStr = [NSString stringWithFormat:@"shareResult('%@','%@','%@')",title,content,url];
        [[JSContext currentContext] evaluateScript:jsStr];
    };
}

- (void)addSetBGColorWithContext:(JSContext *)context {
    
    weakSelf(self)
    context[@"setColor"] = ^() {
        NSArray *args = [JSContext currentArguments];
        
        if (args.count < 4) {
            return ;
        }
        weakSelf.view.backgroundColor = [UIColor randomColor];
    };
}

- (void)addPayActionWithContext:(JSContext *)context
{
    context[@"payAction"] = ^() {
        NSArray *args = [JSContext currentArguments];
        
        if (args.count < 4) {
            return ;
        }
        
        NSString *orderNo = [args[0] toString];
        NSString *channel = [args[1] toString];
        long long amount = [[args[2] toNumber] longLongValue];
        NSString *subject = [args[3] toString];
        
        // 支付操作
        NSLog(@"orderNo:%@---channel:%@---amount:%lld---subject:%@",orderNo,channel,amount,subject);
        
        // 将支付结果返回给js
        //        NSString *jsStr = [NSString stringWithFormat:@"payResult('%@')",@"支付成功"];
        //        [[JSContext currentContext] evaluateScript:jsStr];
        [[JSContext currentContext][@"payResult"] callWithArguments:@[@"支付成功"]];
    };
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
