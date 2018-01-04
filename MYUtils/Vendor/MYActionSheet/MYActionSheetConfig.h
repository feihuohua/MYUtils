//
//  MYActionSheetConfig.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/9/19.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMYActionSheetColor(r, g, b)        kMYActionSheetColorA(r, g, b, 1.0f)
#define kMYActionSheetColorA(r, g, b, a)    [UIColor colorWithRed:(r)/255.0f\
                                                            green:(g)/255.0f\
                                                             blue:(b)/255.0f\
                                                            alpha:a]

NS_ASSUME_NONNULL_BEGIN

@interface MYActionSheetConfig : NSObject

/**
 Title.
 */
@property (nullable, nonatomic, copy) NSString *title;

/**
 Cancel button's title.
 */
@property (nullable, nonatomic, copy) NSString *cancelButtonTitle;

/**
 Cancel button's index.
 */
@property (nonatomic, assign, readonly) NSInteger cancelButtonIndex;

/**
 All destructive buttons' set. You should give it the `NSNumber` type items.
 */
@property (nullable, nonatomic, strong) NSIndexSet *destructiveButtonIndexSet;

/**
 Destructive button's color. Default is RGB(254, 67, 37).
 */
@property (nonatomic, strong) UIColor *destructiveButtonColor;

/**
 Title's color. Default is `[UIColor blackColor]`.
 */
@property (nonatomic, strong) UIColor *titleColor;
/**
 Buttons' color, without destructive buttons. Default is `[UIColor blackColor]`.
 */
@property (nonatomic, strong) UIColor *buttonColor;
/**
 Title's font. Default is `[UIFont systemFontOfSize:14.0f]`.
 */
@property (nonatomic, strong) UIFont *titleFont;
/**
 All buttons' font. Default is `[UIFont systemFontOfSize:18.0f]`.
 */
@property (nonatomic, strong) UIFont *buttonFont;
/**
 All buttons' height. Default is 49.0f;
 */
@property (nonatomic, assign) CGFloat buttonHeight;

/**
 If buttons' bottom view can scrolling. Default is NO.
 */
@property (nonatomic, assign, getter=canScrolling) BOOL scrolling;

/**
 Visible buttons' count. You have to set `scrolling = YES` if you want to set it.
 */
@property (nonatomic, assign) CGFloat visibleButtonCount;

/**
 Animation duration. Default is 0.3 seconds.
 */
@property (nonatomic, assign) CGFloat animationDuration;

/**
 Opacity of dark background. Default is 0.3f.
 */
@property (nonatomic, assign) CGFloat darkOpacity;

/**
 If you can tap darkView to dismiss. Defalut is NO, you can tap dardView to dismiss.
 */
@property (nonatomic, assign) BOOL darkViewNoTaped;

/**
 Clear blur effect. Default is NO, don't clear blur effect.
 */
@property (nonatomic, assign) BOOL unBlur;

/**
 Style of blur effect. Default is `UIBlurEffectStyleExtraLight`. iOS 8.0 +
 */
@property (nonatomic, assign) UIBlurEffectStyle blurEffectStyle;

/**
 Title's edge insets. Default is `UIEdgeInsetsMake(15.0f, 15.0f, 15.0f, 15.0f)`.
 */
@property (nonatomic, assign) UIEdgeInsets titleEdgeInsets;

/**
 Cell's separator color. Default is `RGBA(170/255.0f, 170/255.0f, 170/255.0f, 0.5f)`.
 */
@property (nonatomic, strong) UIColor *separatorColor;

/**
 Blur view's background color. Default is `RGBA(255.0/255.0f, 255.0/255.0f, 255.0/255.0f, 0.5f)`.
 */
@property (nonatomic, strong) UIColor *blurBackgroundColor;

/**
 Title can be limit in numberOfTitleLines. Default is 0.
 */
@property (nonatomic, assign) NSInteger numberOfTitleLines;

/**
 Auto hide when the device rotated. Default is NO, won't auto hide.
 */
@property (nonatomic, assign) BOOL autoHideWhenDeviceRotated;

/**
 MYActionSheetConfig shared instance.
 */
@property (class, nonatomic, strong, readonly) MYActionSheetConfig *config;

@end

NS_ASSUME_NONNULL_END
