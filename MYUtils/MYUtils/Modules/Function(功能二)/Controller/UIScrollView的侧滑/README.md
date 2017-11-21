
(1)、创建一个UIPanGestureRecognizer手势，该手势触发时执行侧滑返回的action，为了使用方便，我将其写在分类里面，代码如下：
```
- (UIPanGestureRecognizer *)tz_popGestureRecognizer {
UIPanGestureRecognizer *pan = objc_getAssociatedObject(self, _cmd);
if (!pan) {
// 侧滑返回手势 手势触发的时候，让target执行action
id target = self.tz_PopDelegate;
SEL action = NSSelectorFromString(@"handleNavigationTransition:");
pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:action];
pan.maximumNumberOfTouches = 1;
pan.delegate = self;
self.interactivePopGestureRecognizer.enabled = NO;
objc_setAssociatedObject(self, _cmd, pan, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
return pan;
}
```

(2)、模仿一下系统侧滑返回手势的触发条件，给这个手势限定合适的触发条件（滑动位置在屏幕左边缘+向右滑），代码如下：
```
- (BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
if ([[self valueForKey:@"_isTransitioning"] boolValue]) {
return NO;
}
if (self.childViewControllers.count <= 1) {
return NO;
}
// 侧滑手势触发位置
CGPoint location = [gestureRecognizer locationInView:self.view];
CGPoint offSet = [gestureRecognizer translationInView:gestureRecognizer.view];
BOOL ret = (0 < offSet.x && location.x <= 40);
NSLog(@"%@ %@",NSStringFromCGPoint(location),NSStringFromCGPoint(offSet));
return ret;
}
```

(3)、侧滑手势优先，侧滑手势失效时，才触发UISrcollView的滑动：

```
// 只有当系统侧滑手势失败了，才去触发ScrollView的滑动
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
return YES;
}
```

(4)、手势已经定义好了，接下来把它加在合适的UISrcollView上面即可，我于是给UIViewController写了个分类，新增方法：
```
- (void)tz_addPopGestureToView:(UIView *)view;
```
在需要UISrcollView滑动和系统侧滑同时并存的界面中，只需要在控制器中调用这个方法即可解决：
```
// scrollView需要支持侧滑返回
[self my_addPopGestureToView:scrollView];
```
