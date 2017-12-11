//
//  MYRunLoopOperationManager.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef BOOL(^MYRunLoopOperation)(void);

@interface MYRunLoopOperationManager : NSObject

@property (nonatomic, assign) NSUInteger maximumQueueLength;

+ (instancetype)sharedManager;

- (void)addTask:(MYRunLoopOperation)operation withKey:(id)key;

- (void)removeAllTasks;

@end
