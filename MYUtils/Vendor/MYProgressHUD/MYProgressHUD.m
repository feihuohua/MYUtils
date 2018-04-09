//
//  MYProgressHUD.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/4.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYProgressHUD.h"
#import <MBProgressHUD.h>
#import <NSString+Extension.h>

@implementation MYProgressHUD

+ (void)showMessage:(NSString *)text {
    
    [self showStatus:MYProgressHUDStatusWaitting text:text toView:nil];
}

+ (void)showMessage:(NSString *)text toView:(UIView *)view {
    
    [self showStatus:MYProgressHUDStatusWaitting text:text toView:view];
}

+ (void)showStatus:(MYProgressHUDStatus)status text:(NSString *)text toView:(UIView *)view {
    
    if ([NSString isEmpty:text]) {
        return;
    }
    if (!view) {
        view = [[UIApplication sharedApplication].windows firstObject];
    }
    
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    
    NSString *bundlePath = [[NSBundle bundleForClass:[self class]] pathForResource:@"MYProgressHUD" ofType:@"bundle"];
    
    switch (status) {
            
        case MYProgressHUDStatusSuccess: {
            
            NSString *sucPath = [bundlePath stringByAppendingPathComponent:@"hud_success@2x.png"];
            UIImage *sucImage = [UIImage imageWithContentsOfFile:sucPath];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *sucView = [[UIImageView alloc] initWithImage:sucImage];
            hud.customView = sucView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        case MYProgressHUDStatusError: {
            
            NSString *errPath = [bundlePath stringByAppendingPathComponent:@"hud_error@2x.png"];
            UIImage *errImage = [UIImage imageWithContentsOfFile:errPath];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *errView = [[UIImageView alloc] initWithImage:errImage];
            hud.customView = errView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        case MYProgressHUDStatusWaitting: {
            
            hud.mode = MBProgressHUDModeIndeterminate;
        }
            break;
            
        case MYProgressHUDStatusMessage: {
            
            NSString *infoPath = [bundlePath stringByAppendingPathComponent:@"hud_info@2x.png"];
            UIImage *infoImage = [UIImage imageWithContentsOfFile:infoPath];
            
            hud.mode = MBProgressHUDModeCustomView;
            UIImageView *infoView = [[UIImageView alloc] initWithImage:infoImage];
            hud.customView = infoView;
            [hud hide:YES afterDelay:2.0f];
        }
            break;
            
        default:
            break;
    }
}

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message {
    return [self showLoadingMessage:message toView:nil];
}

+ (MBProgressHUD *)showLoadingMessage:(NSString *)message toView:(UIView *)view {
    if (!view) {
        view = [[UIApplication sharedApplication].windows firstObject];
    }
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

+ (void)hide {
    [self hideHUDForView:nil];
}

+ (void)hideHUDForView:(UIView *)view {
    if (!view) {
        view = [[UIApplication sharedApplication].windows firstObject];
    }
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
}

@end
