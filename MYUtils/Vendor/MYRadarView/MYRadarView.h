//
//  MYRadarView.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/6.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYRadarView : UIView

//fill color
@property (nonatomic, strong) UIColor *fillColor;

//instance count
@property (nonatomic, assign) NSInteger instanceCount;

//instance delay
@property (nonatomic, assign) CFTimeInterval instanceDelay;

//opacity
@property (nonatomic, assign) CGFloat opacityValue;

//animation duration
@property (nonatomic, assign) CFTimeInterval animationDuration;

/**
 *  start animation
 */
- (void)startAnimation;

/**
 *  stop animation
 */
- (void)stopAnimation;

@end
