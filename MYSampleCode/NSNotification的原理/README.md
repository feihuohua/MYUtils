# 探索通知的原理

在主线程中注册观察者，在子线程中发送通知，是发送通知的线程处理的通知事件

```
// 往通知中心添加观察者
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(handleNotification:)
                                             name:@"MyNAME"
                                           object:nil];
NSLog(@"register notifcation thread = %@", [NSThread currentThread]);
// 创建子线程，在子线程中发送通知
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	NSLog(@"post notification thread = %@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNAME" object:nil userInfo:nil];
});

- (void)handleNotification:(NSNotification *)notification {
    //打印处理通知方法的线程
    NSLog(@"handle notification thread = %@", [NSThread currentThread]);
}

```
![image.png](http://upload-images.jianshu.io/upload_images/588630-dbdda123792ccf4d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


在主线程中注册观察者，主线程中发送通知，是发送通知的线程处理的通知事件

```
// 往通知中心添加观察者
[[NSNotificationCenter defaultCenter] addObserver:self
                                         selector:@selector(handleNotification:)
                                             name:@"MyNAME"
                                           object:nil];
    
NSLog(@"register notifcation thread = %@", [NSThread currentThread]);
    
// 创建子线程，在子线程中发送通知
dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
	NSLog(@"post notification thread = %@", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MyNAME" object:nil userInfo:nil];
});
    
- (void)handleNotification:(NSNotification *)notification {
    //打印处理通知方法的线程
    NSLog(@"handle notification thread = %@", [NSThread currentThread]);
}
```
![image.png](http://upload-images.jianshu.io/upload_images/588630-dee057a3614a9d88.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 通知的原理：

在发送通知的子线程处理通知的事件时，将NSNotification暂存，然后通过MachPort往相应线程的RunLoop中发送事件。相应的线程收到该事件后，取出在队列中暂存的NSNotification, 然后在当前线程中调用处理通知的方法。
![image.png](http://upload-images.jianshu.io/upload_images/588630-7ddc2c7fab912f4d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
