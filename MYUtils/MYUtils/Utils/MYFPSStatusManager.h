//
//  MYFPSStatusManager.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/20.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYFPSStatusManager : NSObject

+ (instancetype)sharedInstance;

- (void)start;
- (void)stop;

@end
