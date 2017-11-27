//
//  MYCountDownManager.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kMYCountDownNotification;

@interface MYCountDownManager : NSObject

/** 时间差(单位:秒) */
@property (nonatomic, assign) NSInteger timeInterval;

/** 使用单例 */
+ (instancetype)manager;

/** 开始倒计时 */
- (void)start;

/** 停止倒计时 */
- (void)invalidate;

/** 刷新倒计时(如使用identifier标识的时间差, 请调用reloadAllSource方法) */
- (void)reload;

/** 添加倒计时源 */
- (void)addSourceWithIdentifier:(NSString *)identifier;

/** 获取时间差 */
- (NSInteger)timeIntervalWithIdentifier:(NSString *)identifier;

/** 刷新倒计时源 */
- (void)reloadSourceWithIdentifier:(NSString *)identifier;

/** 刷新所有倒计时源 */
- (void)reloadAllSource;

/** 清除倒计时源 */
- (void)removeSourceWithIdentifier:(NSString *)identifier;

/** 清除所有倒计时源 */
- (void)removeAllSource;

@end
