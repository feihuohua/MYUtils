//
//  MYFPSStatusManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/20.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYFPSStatusManager.h"
#import "UtilsMacros.h"

@interface MYFPSStatusManager ()

@property (strong, nonatomic) UILabel *displayLabel;
@property (strong, nonatomic) CADisplayLink *link;
@property (assign, nonatomic) NSInteger count;
@property (assign, nonatomic) NSTimeInterval lastTime;
@property (strong, nonatomic) UIFont *font;
@property (strong, nonatomic) UIFont *subFont;

@end

@implementation MYFPSStatusManager

+ (instancetype)sharedInstance {
    static MYFPSStatusManager *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MYFPSStatusManager alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initDisplayLabel];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(applicationDidBecomeActiveNotification)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(applicationWillResignActiveNotification)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
    }
    return self;
}

- (void)initDisplayLabel {
    CGRect frame = CGRectMake(MYScreenWidth - 100, MYScreenHeight - 100, 80, 30);
    self.displayLabel = [[UILabel alloc] initWithFrame: frame];
    
    self.displayLabel.layer.cornerRadius = 5;
    self.displayLabel.clipsToBounds = YES;
    self.displayLabel.textAlignment = NSTextAlignmentCenter;
    self.displayLabel.userInteractionEnabled = NO;
    self.displayLabel.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.700];
    
    _font = [UIFont fontWithName:@"Menlo" size:14];
    if (_font) {
        _subFont = [UIFont fontWithName:@"Menlo" size:4];
    } else {
        _font = [UIFont fontWithName:@"Courier" size:14];
        _subFont = [UIFont fontWithName:@"Courier" size:4];
    }
    
    [self initCADisplayLink];
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.displayLabel];
}

- (void)start {
    
    [self.link setPaused:NO];
}

- (void)stop {
  
    [self.link setPaused:YES];
}

- (void)initCADisplayLink {
    self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
    [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)applicationDidBecomeActiveNotification {
    [self.link setPaused:NO];
}

- (void)applicationWillResignActiveNotification {
    [self.link setPaused:YES];
}

- (void)tick:(CADisplayLink *)link {
    if (self.lastTime == 0) {           //对LastTime进行初始化
        self.lastTime = link.timestamp;
        return;
    }
    
    self.count += 1;   //记录tick在1秒内执行的次数
    NSTimeInterval delta = link.timestamp - self.lastTime;  //计算本次刷新和上次更新FPS的时间间隔
    
    //大于等于1秒时，来计算FPS
    if (delta >= 1) {
        self.lastTime = link.timestamp;
        float fps = self.count / delta;         // 次数 除以 时间 = FPS （次/秒）
        self.count = 0;
        [self updateDisplayLabelText: fps];
    }
}

- (void)updateDisplayLabelText: (float) fps {
    CGFloat progress = fps / 60.0;
    UIColor *color = [UIColor colorWithHue:0.27 * (progress - 0.2) saturation:1 brightness:0.9 alpha:1];
    self.displayLabel.text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    self.displayLabel.textColor = color;
}

- (void)dealloc {
    [_link invalidate];
}

@end
