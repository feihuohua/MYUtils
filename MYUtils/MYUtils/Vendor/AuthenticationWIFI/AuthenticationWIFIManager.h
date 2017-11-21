//
//  AuthenticationWIFIManager.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/21.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^NetworkCheckComplection)(BOOL needAuthPassword);

@interface AuthenticationWIFIManager : NSObject

/// 开启测试模式，开启后，每次验证都会提示需要认证WIFI
@property (nonatomic, assign) BOOL openTestMode;
@property (nonatomic, copy) NetworkCheckComplection complection;

+ (instancetype)shareManager;

/**
 *  检查当前wifi是否需要验证密码
 *  needAlert: 为YES时，若当前wifi需要验证密码，则会弹出警告框提示用户
 */
- (void)checkIsWifiNeedAuthPasswordWithComplection:(NetworkCheckComplection)complection
                                         needAlert:(BOOL)needAlert;


@end

