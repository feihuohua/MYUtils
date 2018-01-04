//
//  MYLaunchAdvertButton.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MYLaunchAdvertConst.h"

@interface MYLaunchAdvertButton : UIButton

- (instancetype)initWithSkipType:(MYLaunchAdvertButtonSkipType)skipType;
- (void)startRoundDispathTimerWithDuration:(CGFloat)duration;
- (void)setTitleWithSkipType:(MYLaunchAdvertButtonSkipType)skipType duration:(NSInteger)duration;

@end
