//
//  MYActionSheetConfig.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/9/19.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYActionSheetConfig.h"

#define kMYActionSheetButtonHeight              49.0f

#define kMYActionSheetRedColor                  kMYActionSheetColor(254, 67, 37)

#define kMYActionSheetTitleFont                 [UIFont systemFontOfSize:14.0f]

#define kMYActionSheetButtonFont                [UIFont systemFontOfSize:18.0f]

#define kMYActionSheetAnimationDuration         0.3f

#define kMYActionSheetDarkOpacity               0.3f

#define kMYActionSheetBlurBgColorNormal         [[UIColor whiteColor] colorWithAlphaComponent:0.5]

@implementation MYActionSheetConfig

+ (MYActionSheetConfig *)config {
    static id _config = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _config = [[self alloc] initSharedInstance];
    });
    return _config;
}

+ (instancetype)shared {
    return self.config;
}

- (instancetype)initSharedInstance {
    if (self = [super init]) {
        self.titleFont              = kMYActionSheetTitleFont;
        self.buttonFont             = kMYActionSheetButtonFont;
        self.destructiveButtonColor = kMYActionSheetRedColor;
        self.titleColor             = kMYActionSheetColor(111, 111, 111);
        self.buttonColor            = [UIColor blackColor];
        
        self.buttonHeight           = kMYActionSheetButtonHeight;
        self.animationDuration      = kMYActionSheetAnimationDuration;
        self.darkOpacity            = kMYActionSheetDarkOpacity;
        
        self.titleEdgeInsets        = UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f);
        
        self.separatorColor         = kMYActionSheetColorA(150, 150, 150, 0.3f);
        self.blurBackgroundColor    = kMYActionSheetBlurBgColorNormal;
    }
    return self;
}

- (instancetype)init {
    return MYActionSheetConfig.config;
}

- (NSInteger)cancelButtonIndex {
    return 0;
}

@end
