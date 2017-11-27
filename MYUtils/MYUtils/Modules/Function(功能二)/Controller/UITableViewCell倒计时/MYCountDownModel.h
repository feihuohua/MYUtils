//
//  MYCountDownModel.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MYCountDownModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger count;

/// 表示时间已经到了
@property (nonatomic, assign) BOOL timeOut;

/// 倒计时源
@property (nonatomic, copy) NSString *countDownSource;

@end
