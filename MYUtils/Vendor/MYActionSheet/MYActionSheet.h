//
//  MYActionSheet.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/9/19.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MYActionSheet;

NS_ASSUME_NONNULL_BEGIN

#pragma mark - MYActionSheet Block
/**
 Handle click button.
 */
typedef void(^MYActionSheetClickedHandler)(MYActionSheet *actionSheet, NSInteger buttonIndex);

/**
 Handle action sheet will present.
 */
typedef void(^MYActionSheetWillPresentHandler)(MYActionSheet *actionSheet);
/**
 Handle action sheet did present.
 */
typedef void(^MYActionSheetDidPresentHandler)(MYActionSheet *actionSheet);

/**
 Handle action sheet will dismiss.
 */
typedef void(^MYActionSheetWillDismissHandler)(MYActionSheet *actionSheet, NSInteger buttonIndex);
/**
 Handle action sheet did dismiss.
 */
typedef void(^MYActionSheetDidDismissHandler)(MYActionSheet *actionSheet, NSInteger buttonIndex);

#pragma mark - MYActionSheet Delegate

@protocol MYActionSheetDelegate <NSObject>

@optional

/**
 Handle click button.
 */
- (void)actionSheet:(MYActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

/**
 Handle action sheet will present.
 */
- (void)willPresentActionSheet:(MYActionSheet *)actionSheet;
/**
 Handle action sheet did present.
 */
- (void)didPresentActionSheet:(MYActionSheet *)actionSheet;

/**
 Handle action sheet will dismiss.
 */
- (void)actionSheet:(MYActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;
/**
 Handle action sheet did dismiss.
 */
- (void)actionSheet:(MYActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex;

@end

@interface MYActionSheet : UIView

#pragma mark - Properties

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
 MYActionSheet's delegate.
 */
@property (nullable, nonatomic, weak) id<MYActionSheetDelegate> delegate;

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
 MYActionSheet clicked handler.
 */
@property (nullable, nonatomic, copy) MYActionSheetClickedHandler     clickedHandler;
/**
 MYActionSheet will present handler.
 */
@property (nullable, nonatomic, copy) MYActionSheetWillPresentHandler willPresentHandler;
/**
 MYActionSheet did present handler.
 */
@property (nullable, nonatomic, copy) MYActionSheetDidPresentHandler  didPresentHandler;
/**
 MYActionSheet will dismiss handler.
 */
@property (nullable, nonatomic, copy) MYActionSheetWillDismissHandler willDismissHandler;
/**
 MYActionSheet did dismiss handler.
 */
@property (nullable, nonatomic, copy) MYActionSheetDidDismissHandler  didDismissHandler;


/**
 Initialize an instance of MYActionSheet (Delegate).
 
 @param title             title
 @param delegate          delegate
 @param cancelButtonTitle cancelButtonTitle
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of MYActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
                      delegate:(nullable id<MYActionSheetDelegate>)delegate
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
             otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of MYActionSheet with title array (Delegate).
 
 @param title                 title
 @param delegate              delegate
 @param cancelButtonTitle     cancelButtonTitle
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of MYActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
                      delegate:(nullable id<MYActionSheetDelegate>)delegate
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
         otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;

/**
 Initialize an instance of MYActionSheet (Delegate).
 
 @param title             title
 @param delegate          delegate
 @param cancelButtonTitle cancelButtonTitle
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of MYActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                     delegate:(nullable id<MYActionSheetDelegate>)delegate
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
            otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of MYActionSheet with title array (Delegate).
 
 @param title                 title
 @param delegate              delegate
 @param cancelButtonTitle     cancelButtonTitle
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of MYActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                     delegate:(nullable id<MYActionSheetDelegate>)delegate
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
        otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;


#pragma mark Block

/**
 Initialize an instance of MYActionSheet (Block).
 
 @param title             title
 @param cancelButtonTitle cancelButtonTitle
 @param clickedHandler    clickedHandler
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of MYActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                       clicked:(nullable MYActionSheetClickedHandler)clickedHandler
             otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of MYActionSheet with title array (Block).
 
 @param title                 title
 @param cancelButtonTitle     cancelButtonTitle
 @param clickedHandler        clickedHandler
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of MYActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                       clicked:(nullable MYActionSheetClickedHandler)clickedHandler
         otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;

/**
 Initialize an instance of MYActionSheet (Block).
 
 @param title             title
 @param cancelButtonTitle cancelButtonTitle
 @param clickedHandler    clickedHandler
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of MYActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      clicked:(nullable MYActionSheetClickedHandler)clickedHandler
            otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of MYActionSheet with title array (Block).
 
 @param title                 title
 @param cancelButtonTitle     cancelButtonTitle
 @param clickedHandler        clickedHandler
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of MYActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                      clicked:(nullable MYActionSheetClickedHandler)clickedHandler
        otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;



/**
 Initialize an instance of MYActionSheet (Block).
 
 @param title             title
 @param cancelButtonTitle cancelButtonTitle
 @param didDismissHandler didDismissHandler
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of MYActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    didDismiss:(nullable MYActionSheetDidDismissHandler)didDismissHandler
             otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of MYActionSheet with title array (Block).
 
 @param title                 title
 @param cancelButtonTitle     cancelButtonTitle
 @param didDismissHandler     didDismissHandler
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of MYActionSheet.
 */
+ (instancetype)sheetWithTitle:(nullable NSString *)title
             cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                    didDismiss:(nullable MYActionSheetDidDismissHandler)didDismissHandler
         otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;

/**
 Initialize an instance of MYActionSheet (Block).
 
 @param title             title
 @param cancelButtonTitle cancelButtonTitle
 @param didDismissHandler didDismissHandler
 @param otherButtonTitles otherButtonTitles
 
 @return An instance of MYActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                   didDismiss:(nullable MYActionSheetDidDismissHandler)didDismissHandler
            otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Initialize an instance of MYActionSheet with title array (Block).
 
 @param title                 title
 @param cancelButtonTitle     cancelButtonTitle
 @param didDismissHandler     didDismissHandler
 @param otherButtonTitleArray otherButtonTitleArray
 
 @return An instance of MYActionSheet.
 */
- (instancetype)initWithTitle:(nullable NSString *)title
            cancelButtonTitle:(nullable NSString *)cancelButtonTitle
                   didDismiss:(nullable MYActionSheetDidDismissHandler)didDismissHandler
        otherButtonTitleArray:(nullable NSArray<NSString *> *)otherButtonTitleArray;


#pragma mark Append & Show

/**
 Append buttons with titles.
 
 @param titles titles
 */
- (void)appendButtonsWithTitles:(nullable NSString *)titles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 Append button at index with title.
 
 @param title title
 @param index index
 */
- (void)appendButtonWithTitle:(nullable NSString *)title atIndex:(NSInteger)index;

/**
 Append buttons at indexSet with titles.
 
 @param titles  titles
 @param indexes indexes
 */
- (void)appendButtonsWithTitles:(NSArray<NSString *> *)titles atIndexes:(NSIndexSet *)indexes;

/**
 Show the instance of MYActionSheet.
 */
- (void)show;

/**
 Get button title with index
 
 @param index index
 @return button title
 */
- (NSString *)buttonTitleAtIndex:(NSInteger)index;

@end

NS_ASSUME_NONNULL_END
