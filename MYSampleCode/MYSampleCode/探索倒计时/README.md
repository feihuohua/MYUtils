# 探索倒计时的实现

- 第一种就是直接在TableView的Cell上使用NSTimer。
- 第二种是将NSTimer添加到当前线程所对应的RunLoop中的commonModes中。
- 第三种是通过Dispatch中的TimerSource来实现定时器。
- 第四种是使用CADisplayLink来实现。

## 一、在Cell中直接使用NSTimer

首先我们按照常规做法，直接在UITableView的Cell上添加相应的NSTimer, 并使用scheduledTimer执行相应的代码块。这种方式没有什么特殊的就是对Timer的直接使用。代码如下所示 ：

```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCountDownModel:(MYCountDownModel *)countDownModel {
    _countDownModel = countDownModel;
    
    self.textLabel.text = countDownModel.title;
}

- (void)countDown:(NSTimer *)timer {

    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"HH:mm:ss";
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时:%@", [dateformatter stringFromDate:[NSDate date]]];
}

```

上述代码比较简单，就是在Cell上添加了一个定时器，然后没1秒更新一次时间，并在Cell的timeLabel上显示。当我们滑动TableView时，该定时器就停止了工作。具体原因就是当前线程的RunLoop在TableView滑动时将DefaultMode切换到了TrackingRunLoopMode。因为Timer默认是添加在RunLoop上的DefaultMode上的，当Mode切换后Timer就停止了运行。

但是当停止滑动后，Mode又切换了回来，所以Timer有可以正常工作了。

为了进一步看一下Mode的切换，我们可以在相应的地方获取当前线程的RunLoop并且打印对应的Mode。下方代码就是在TableView所对应的控制器上添加的，我们在viewDidLoad()、viewDidAppear()以及scrollViewDidScroll()这个代理方法中对当前线程所对应的RunLoop下的currentMode进行了打印，其代码如下。
```
- (instancetype)init {
    self = [super init];
    if (self) {
        NSLog(@"初始化当前的runloopMode:%@",[NSRunLoop mainRunLoop].currentMode);
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    [self.tableView registerClass:[MYCountDownViewCell class] forCellReuseIdentifier:identifier];
    
    NSLog(@"viewDidLoad当前的runloopMode:%@",[NSRunLoop mainRunLoop].currentMode);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"viewDidAppear当前的runloopMode:%@",[NSRunLoop mainRunLoop].currentMode);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"scrollView滑动时当前的runloopMode:%@",[NSRunLoop mainRunLoop].currentMode);
}

```

![image.png](http://upload-images.jianshu.io/upload_images/588630-b3ff4f76a19500ea.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

在viewDidLoad()、viewDidAppear()以及刚开始调用scrollViewDidScroll()方法中打印的Current Mode为kCFRunLoopDefaultMode, 当我们去滑动TableView，然后在scrollViewDidScroll()代理方法中打印滑动时当前RunLoop所对应的currentModel为UITrackingRunLoopMode。当停止滑动后，点击Show Current Mode按钮获取当前Mode时，打印的有时RunLoopDefaultMode。
 

## 二、将Timer添加到CommonMode中

上一部分的定时器是不能正常运行的，因为NSTimer对象默认添加到了当前RunLoop的DefaultMode中，而在切换成TrackingRunLoopMode时，定时器就停止了工作。解决该问题最直接方法是，将NSTimer在TrackingRunLoopMode中也添加一份。这样的话无论是在DefaultMode还是TrackingRunLoopMode中，定时器都会正常的工作。

如果对RunLoop比较熟悉的话，可以知道CommonModes就是DefaultMode和TrackingRunLoopMode的集合，所以我们只需要将NSTimer对象与当前线程所对应的RunLoop中的CommonModes关联即可，具体代码如下所示：


```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(countDown:) userInfo:nil repeats:YES];
	[[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCountDownModel:(MYCountDownModel *)countDownModel {
    _countDownModel = countDownModel;
    
    self.textLabel.text = countDownModel.title;
}

- (void)countDown:(NSTimer *)timer {

    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"HH:mm:ss";
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时:%@", [dateformatter stringFromDate:[NSDate date]]];
}

```

当该TableView滚动式，其Cell上的定时器是可以正常工作的。但是当我们滑动右上角的这个TableView时，第一个的TableView中的定时器也是不能正常工作的，因为这些TableView都在主线程中工作，也就是说这些TableView所在的RunLoop是同一个。


## 三、DispatchTimerSource

接下来我们就不使用NSTimer来实现定时器了。在之前的博客中聊GCD时其中用到了DispatchTimerSource来实现定时器。接下来我们就在TableView的Cell上添加DispatchTimerSource，然后看一下运行效果。当然下方代码片段我们是在全局队列中添加的DispatchTimerSource，在主线程中进行更新。当然我们也可以在mainQueue中添加DispatchTimerSource，这样也是可以正常工作的。当然我们不建议在MainQueue中做，因为在编程时尽量的把一些和主线程关联不太大的操作放到子线程中去做。代码如下所示：

```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
        // 倒计时时间
        __block NSInteger timeOut = 60.0f;
        dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
        // 每秒执行一次
        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
        dispatch_source_set_event_handler(_timer, ^{
            
            // 倒计时结束，关闭
            if (timeOut <= 0) {
                dispatch_source_cancel(_timer);
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.detailTextLabel.text = @"倒计时结束";
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
                    dateformatter.dateFormat = @"HH:mm:ss";
                    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时%@", [dateformatter stringFromDate:[NSDate date]]];
                });
                timeOut--;
            }
        });
        dispatch_resume(_timer);
    }
    return self;
}

```

## 四、CADisplayLink

接下来我们来使用CADisplayLink来实现定时器功能，CADisplayLink可以添加到RunLoop中，RunLoop的每一次循环都会触发CADisplayLink所关联的方法。在屏幕不卡顿的情况下，每次循环的时间时1/60秒。

下方代码，为了不让屏幕的卡顿等引起的主线程所对应的RunLoop阻塞所造成的定时器不精确的问题。我们开启了一个新的线程，并且将CADisplayLink对象添加到这个子线程的RunLoop中，然后在主线程中更新UI即可。具体代码如下：

```
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDown)];
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCountDownModel:(MYCountDownModel *)countDownModel {
    _countDownModel = countDownModel;
    self.textLabel.text = countDownModel.title;
}

- (void)countDown {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"HH:mm:ss";
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时%@", [dateformatter stringFromDate:[NSDate date]]];
}
```
