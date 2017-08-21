### MYUtils
MYUtils项目中会记录日常常用的一些工具类和一些常用的demo等等。

本次新增功能：
* UILabel设置行间距、指定显示行数
* iconfont实战
* 使用UIImageView设置圆角
* UICollectionView实现轮播图
* WebView与H5页面交互

#### UILabel设置行间距、指定显示行数
* 在iOS中，有时候显示文本，需要设置文本的行间距、指定显示行数、文本内容超出显示行数，省略结尾部分的内容以……方式省略。这些都可以使用UILabel来是实现，前提是你扩展了UILabel这方面的特性。

#### iconfont实战

* 使用IconFont减小iOS应用体积。

#### 使用UIImageView设置圆角

* 使用UIImageView分类设置圆角

#### UICollectionView实现轮播图

* FXBannerCycleView是用UICollectionView实现的，使用的时候也特别简单，就跟使用UICollectionView一样的清爽。

![FXBannerCycleView.gif](http://upload-images.jianshu.io/upload_images/588630-ed997a60d2dbc4a9.gif?imageMogr2/auto-orient/strip)

* 首先，FXBannerCyclePageControlPosition是确定pageControl的位置，默认值是中间位置。


```
FXBannerCyclePageControlPositionCenter
FXBannerCyclePageControlPositionLeft
FXBannerCyclePageControlPositionRight
```

* 然后，FXBannerCycleView的代理方法


```
/**
*  代理方法取轮播总数（参考UITableView或UICollectionView）
*
*  @param cycleView 轮播视图
*
*  @return 轮播总数
*/
- (NSInteger)numberOfRowsInCycleView:(FXBannerCycleView *)cycleView;

/**
*  代理方法取轮播子视图（参考UITableView或UICollectionView）
*
*  @param cycleView 轮播视图
*  @param row       子视图索引
*
*  @return 轮播子视图（继承自系统UICollectionViewCell）
*/
- (UICollectionViewCell *)cycleView:(FXBannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row;

/**
*  代理方法取子视图大小
*
*  @param cycleView 轮播视图
*  @param row       子视图索引
*
*  @return 子视图大小
*/
- (CGSize)cycleView:(FXBannerCycleView *)cycleView sizeForItemAtRow:(NSInteger)row;

/**
*  代理方法视图滚动到子视图时回调
*
*  @param cycleView 滚动视图
*  @param row       子视图索引
*/
- (void)cycleView:(FXBannerCycleView *)cycleView didScrollToItemAtRow:(NSInteger)row;

/**
*  代理方法子视图点击时回调
*
*  @param cycleView 滚动视图
*  @param row       子视图索引
*/
- (void)cycleView:(FXBannerCycleView *)cycleView didSelectItemAtRow:(NSInteger)row;

```

* 最后，设置定时器的属性

```
/** 是否循环(default = YES) */
@property (nonatomic, assign) BOOL cycleEnabled;
/** 自动滚动间隔(default = 0) */
@property (nonatomic, assign) CGFloat timeInterval;
```

#### WebView与H5页面交互

##### 第一种`JavaScriptCore`

在`iOS 7`之后，苹果添加了一个新的库`JavaScriptCore`用来做与H5页面交互，因此`JS`与原生`OC`交互也变得简单了许多。

* `JS`调用原生`OC`

首先导入`JavaScriptCore`库, 然后在`OC`中获取`JS`的上下文:

```
JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
```

然后定义好`JS`需要调用的方法，例如在`JS`要调用`share`方法：

```
JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
// 定义好JS要调用的方法, share就是调用的share方法名
context[@"share"] = ^() {
NSLog(@"+++++++Begin Log+++++++");
};
```

* `OC`调用`JS`篇

###### 方式一
```
NSString *jsStr = [NSString stringWithFormat:@"showAlert('%@')",@"这里是JS中alert弹出的message"];
[self.webView stringByEvaluatingJavaScriptFromString:jsStr];
```

###### 方式二
```
JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
NSString *textJS = @"showAlert('这里是JS中alert弹出的message')";
[context evaluateScript:textJS];
```

注意：
**该方法会同步返回一个字符串，因此是一个同步方法，可能会阻塞UI。**
`stringByEvaluatingJavaScriptFromString`是一个同步的方法，使用它执行`JS`方法时，如果`JS`方法比较耗的时候，会造成界面卡顿。尤其是`JS`弹出`alert`的时候。`alert`也会阻塞界面，等待用户响应，而`stringByEvaluatingJavaScriptFromString`又会等待`JS`执行完毕返回，这就造成了死锁。
**官方推荐使用`WKWebView`的`evaluateJavaScript:completionHandler:`代替这个方法。**

##### 第二种`WKScriptMessageHandler `

`WKWebView`在初始化的时候，会初始化`WKWebViewConfiguration`类型的参数，然后初始化`WKWebViewConfiguration`参数里面的`WKUserContentController`类型参数。
在`WKUserContentController`对象有一个方法`- addScriptMessageHandler:name:`，`WKScriptMessageHandler`其实就是一个遵循的协议，它能让网页通过`JS`把消息发送给`OC`。

`WKWebView`的代理方法
该代理提供的方法，可以用来追踪加载过程（页面开始加载、加载完成、加载失败）、决定是否执行跳转。
```
// 页面开始加载时调用
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation;

// 当内容开始返回时调用
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation;

// 页面加载完成之后调用
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation;

// 页面加载失败时调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation;
```
页面跳转的代理方法有三种，分为（收到跳转与决定是否跳转两种）：
```
// 接收到服务器跳转请求之后调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation;

// 在收到响应后，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler;

// 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler;
```

`WKUIDelegate`的代理方法
```
// 创建一个新的webView
- (WKWebView**)webView:(WKWebView***)webView createWebViewWithConfiguration:(WKWebViewConfiguration *)configuration forNavigationAction:(WKNavigationAction *)navigationAction windowFeatures:(WKWindowFeatures *)windowFeatures;

```

web界面的三种提示框（警告框、确认框、输入框）分别对应三种代理方法。
```
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler;

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler;

- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable result))completionHandler;
```

```
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;
```
它能让网页通过`JS`把消息发送给`OC`。

使用`WKWebView`的`MessageHandler`新特性
* 在性能、稳定性、功能方面有很大提升（最直观的体现就是加载网页是占用的内存，模拟器加载百度与开源中国网站时，WKWebView占用23M，而UIWebView占用85M）；
* 支持了更多的HTML5特性；
* 高达60fps的滚动刷新率以及内置手势；
* 将UIWebViewDelegate与UIWebView重构成了14类与3个协议。

* `JS`调用原生`OC`

首先，可以理解为注入`JS`的方法
```
[self.webView.configuration.userContentController addScriptMessageHandler:self name:@"share"];
```
注意： 
`addScriptMessageHandler`方法，很容易导致循环引用，导致控制器无法被释放，所以使用`addScriptMessageHandler`之后要及时`removeScriptMessageHandlerForName`。

```
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
if ([message.name isEqualToString:@"share"]) {
NSLog(@"分享");
} 
}
```
可以根据`WKScriptMessage`的`name`属性来区分执行不同的方法。
然后，在H5中的`JS`处理：
```
function shareClick() {
window.webkit.messageHandlers.share.postMessage({title:'测试分享的标题',content:'测试分享的内容',url:'http://www.baidu.com'});
}
```
注意：
1、`window.webkit.messageHandlers.share`中的`share`方法要和你注入的方法名保持一致。
2、`window.webkit.messageHandlers`在H5中不能执行，会报`window.webkit  undefined`这个错误。对于这个问题的解决方法：
* 关闭H5中的代码校验功能；
* `webkit`这个对象是在iOS环境下生成的，所有使用`webkit`肯定要判断是安卓的环境、iOS的环境还是PC浏览器的环境。
* 当你在iOS环境下访问页面的时候，会注入协议的。

* 原生`OC`调用`JS`
```
NSString *jsStr = [NSString stringWithFormat:@""];
[self.webView evaluateJavaScript:jsStr completionHandler:^(id _Nullable result, NSError * _Nullable error) {
NSLog(@"%@----%@",result, error);
}];
```
