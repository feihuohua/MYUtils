//
//  MYPassWordView.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/20.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYPassWordView;

@protocol MYPassWordViewDelegate<NSObject>

@optional
/**
 *  监听输入的改变
 */
- (void)passWordDidChange:(MYPassWordView *)passWord;

/**
 *  监听输入的完成时
 */
- (void)passWordCompleteInput:(MYPassWordView *)passWord;

/**
 *  监听开始输入
 */
- (void)passWordBeginInput:(MYPassWordView *)passWord;

@end

IB_DESIGNABLE

@interface MYPassWordView : UIView

@property (nonatomic, weak) IBOutlet id<MYPassWordViewDelegate> delegate;

/**
 * 密码的位数
 */
@property (nonatomic, assign) IBInspectable NSUInteger passWordNum;

/**
 * 正方形的大小
 */
@property (nonatomic, assign) IBInspectable CGFloat squareWidth;

/**
 * 黑点的半径
 */
@property (nonatomic, assign) IBInspectable CGFloat pointRadius;

/**
 * 黑点的颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *pointColor;

/**
 * 边框的颜色
 */
@property (nonatomic, strong) IBInspectable UIColor *rectColor;

/**
 * 保存密码的字符串
 */
@property (nonatomic, strong, readonly) NSMutableString *textStore;

@end
