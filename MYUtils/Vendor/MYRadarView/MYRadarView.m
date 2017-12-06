//
//  MYRadarView.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYRadarView.h"

@interface MYRadarView()

@property (nonatomic, strong) CAShapeLayer *pulseLayer;
@property (nonatomic, strong) CAReplicatorLayer *replicatorLayer;
@property (nonatomic, strong) CAAnimationGroup *animaGroup;
@property (nonatomic, strong) CABasicAnimation *opacityAnima;

@end

@implementation MYRadarView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
}

- (void)startAnimation {
    
    if (![self.layer.sublayers containsObject:self.replicatorLayer]) {
        [self.layer addSublayer:self.replicatorLayer];
    }
    [self.pulseLayer removeAllAnimations];
    [self.pulseLayer addAnimation:self.animaGroup forKey:@"groupAnimation"];
}

- (void)stopAnimation {
    if (self.pulseLayer) {
        [self.pulseLayer removeAllAnimations];
    }
}

#pragma mark -- Setters & Getters

- (void)setFillColor:(UIColor *)fillColor {
    _fillColor = fillColor;
    self.pulseLayer.fillColor = fillColor.CGColor;
}

- (void)setInstanceCount:(NSInteger)instanceCount {
    _instanceCount = instanceCount;
    self.replicatorLayer.instanceCount = instanceCount;
}

- (void)setInstanceDelay:(CFTimeInterval)instanceDelay {
    _instanceDelay = instanceDelay;
    self.replicatorLayer.instanceDelay = instanceDelay;
}

- (void)setOpacityValue:(CGFloat)opacityValue {
    _opacityValue = opacityValue;
    self.opacityAnima.fromValue = @(opacityValue);
}

- (void)setAnimationDuration:(CFTimeInterval)animationDuration {
    _animationDuration = animationDuration;
    self.animaGroup.duration = animationDuration;
}

- (CAShapeLayer *)pulseLayer {
    if(!_pulseLayer) {
        _pulseLayer = [CAShapeLayer layer];
        _pulseLayer.frame = self.layer.bounds;
        _pulseLayer.path = [UIBezierPath bezierPathWithOvalInRect:_pulseLayer.bounds].CGPath;
        _pulseLayer.fillColor = [UIColor blueColor].CGColor;
        _pulseLayer.opacity = 0.0;
    }
    return _pulseLayer;
}

- (CAReplicatorLayer *)replicatorLayer {
    if(!_replicatorLayer) {
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.frame = self.bounds;
        _replicatorLayer.instanceCount = 6;
        _replicatorLayer.instanceDelay = 1.5;
        [_replicatorLayer addSublayer:self.pulseLayer];
    }
    return _replicatorLayer;
}

- (CAAnimationGroup *)animaGroup {
    if(!_animaGroup) {
        CABasicAnimation *scaleAnima = [CABasicAnimation animationWithKeyPath:@"transform"];
        scaleAnima.fromValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 0.0, 0.0, 0.0)];
        scaleAnima.toValue = [NSValue valueWithCATransform3D:CATransform3DScale(CATransform3DIdentity, 1.0, 1.0, 0.0)];
        
        _animaGroup = [CAAnimationGroup animation];
        _animaGroup.animations = @[self.opacityAnima, scaleAnima];
        _animaGroup.duration = 9;
        _animaGroup.autoreverses = NO;
        _animaGroup.repeatCount = HUGE;
    }
    return _animaGroup;
}

- (CABasicAnimation *)opacityAnima {
    if(!_opacityAnima) {
        _opacityAnima = [CABasicAnimation animationWithKeyPath:@"opacity"];
        _opacityAnima.fromValue = @(0.3);
        _opacityAnima.toValue = @(0.0);
    }
    return _opacityAnima;
}

@end
