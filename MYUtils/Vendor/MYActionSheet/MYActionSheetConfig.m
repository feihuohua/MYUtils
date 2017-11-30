//
//  MYActionSheetConfig.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/9/19.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYActionSheetConfig.h"

#define MY_ACTION_SHEET_BUTTON_HEIGHT       49.0f

#define MY_ACTION_SHEET_RED_COLOR           MY_ACTION_SHEET_COLOR(254, 67, 37)

#define MY_ACTION_SHEET_TITLE_FONT          [UIFont systemFontOfSize:14.0f]

#define MY_ACTION_SHEET_BUTTON_FONT         [UIFont systemFontOfSize:18.0f]

#define MY_ACTION_SHEET_ANIMATION_DURATION  0.3f

#define MY_ACTION_SHEET_DARK_OPACITY        0.3f

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
        self.titleFont              = MY_ACTION_SHEET_TITLE_FONT;
        self.buttonFont             = MY_ACTION_SHEET_BUTTON_FONT;
        self.destructiveButtonColor = MY_ACTION_SHEET_RED_COLOR;
        self.titleColor             = MY_ACTION_SHEET_COLOR(111, 111, 111);
        self.buttonColor            = [UIColor blackColor];
        
        self.buttonHeight           = MY_ACTION_SHEET_BUTTON_HEIGHT;
        self.animationDuration      = MY_ACTION_SHEET_ANIMATION_DURATION;
        self.darkOpacity            = MY_ACTION_SHEET_DARK_OPACITY;
        
        self.titleEdgeInsets        = UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f);
        
        self.separatorColor         = MY_ACTION_SHEET_COLOR_A(150, 150, 150, 0.3f);
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
