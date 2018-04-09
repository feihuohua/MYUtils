//
//  MYBasicViewController.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/4/9.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger, BasicInfoType) {
    BasicInfoTypeHardWare,
    BasicInfoTypeBattery,
    BasicInfoTypeIpAddress,
    BasicInfoTypeCPU,
    BasicInfoTypeDisk,
};

@interface MYBasicViewController : UIViewController

- (instancetype)initWithType:(BasicInfoType)type;

@end
