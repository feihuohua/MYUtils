//
//  MYFPSStatusManager.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/20.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYFPSStatusManager.h"
#import <Masonry.h>

@interface MYFPSStatusManager ()

@property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) NSTimeInterval lastTime;
@property (nonatomic, assign) NSUInteger count;
@property (nonatomic, strong) UILabel *fpsLabel;

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
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(applicationDidBecomeActiveNotification)
                                                     name:UIApplicationDidBecomeActiveNotification
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector: @selector(applicationWillResignActiveNotification)
                                                     name:UIApplicationWillResignActiveNotification
                                                   object:nil];
        CADisplayLink *displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
        [displayLink setPaused:YES];
        [displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        self.displayLink = displayLink;
        
        [self setupSubViews];
    }
    return self;
}

- (void)applicationDidBecomeActiveNotification {
    [self.displayLink setPaused:NO];
}

- (void)applicationWillResignActiveNotification {
    [self.displayLink setPaused:YES];
}

- (void)setupSubViews {
    UIView *currentView = [UIApplication sharedApplication].delegate.window.rootViewController.view;
    [self.fpsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 20));
        make.right.equalTo(currentView).offset(-20.0f);
        make.bottom.equalTo(currentView).offset(-59.0f);
    }];
}

- (void)displayLinkTick:(CADisplayLink *)link {
    if (self.lastTime == 0) {
        self.lastTime = link.timestamp;
        return;
    }
    
    self.count++;
    NSTimeInterval interval = link.timestamp - self.lastTime;
    if (interval < 1) {
        return;
    }
    self.lastTime = link.timestamp;
    float fps = self.count / interval;
    self.count = 0;
    
    NSString *text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    [self.fpsLabel setText:text];
}

- (void)start {

    [self.displayLink setPaused:NO];
}

- (void)stop {
    NSArray *rootVCViewSubViews=[[UIApplication sharedApplication].delegate window].rootViewController.view.subviews;
    for (UIView *label in rootVCViewSubViews) {
        if ([label isKindOfClass:[UILabel class]] && label.tag == 100000) {
            [label removeFromSuperview];
            return;
        }
    }
    [self.displayLink setPaused:YES];
}

- (UILabel *)fpsLabel {
    if (!_fpsLabel) {
        _fpsLabel = [[UILabel alloc] init];
        _fpsLabel.tag = 100000;
        _fpsLabel.font = [UIFont boldSystemFontOfSize:12];
        _fpsLabel.textColor = [UIColor greenColor];
        _fpsLabel.backgroundColor = [UIColor clearColor];
        _fpsLabel.textAlignment = NSTextAlignmentRight;
        [[UIApplication sharedApplication].delegate.window.rootViewController.view addSubview:_fpsLabel];
        [[UIApplication sharedApplication].delegate.window.rootViewController.view bringSubviewToFront:_fpsLabel];
    }
    return _fpsLabel;
}

@end
