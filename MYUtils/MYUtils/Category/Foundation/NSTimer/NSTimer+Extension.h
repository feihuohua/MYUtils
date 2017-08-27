//
//  NSTimer+Extension.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (Extension)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds block:(void (^)(NSTimer *timer))block repeats:(BOOL)repeats;

/** 
 暂停NSTimer 
 */
- (void)pauseTimer;

/** 
 开始NSTimer 
 */
- (void)resumeTimer;

/** 
 延迟开始NSTimer 
 */
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
