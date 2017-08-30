//
//  MYTextField.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/30.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MYTextFieldDelegate <NSObject>

@optional
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;
- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (BOOL)textFieldShouldClear:(UITextField *)textField;
- (BOOL)textFieldShouldReturn:(UITextField *)textField;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;

@end

@interface MYTextField : UIView


/**
 限制输入数量
 */
- (instancetype)initWithSeparateCount:(NSInteger)count;
- (instancetype)initWithFrame:(CGRect)frame separateCount:(NSInteger)count;


/**
 根据数组限制输入字符数量
 */
- (instancetype)initWithSeparateArray:(NSArray *)countArray;
- (instancetype)initWithFrame:(CGRect)frame separateArray:(NSArray *)countArray;

/**
 *  用户实际输入的内容
 **/
@property (nonatomic, copy) NSString *userInputContent;

/**
 *  限制用户实际输入的数量，默认无限制
 **/
@property (nonatomic, assign) NSInteger limitCount;

/**
 设置文本字体
 */
@property (nonatomic, strong, nullable) UIFont *textFont;
@property (nonatomic, strong, nullable) UIColor *tintColor;
@property (nonatomic, copy, nullable) NSString *text;
@property (nonatomic, strong, nullable) UIColor *textColor;
@property (nonatomic, copy, nullable) NSString *placeholder;
@property (nonatomic, assign) NSInteger placeHolderLeft;

@property (nonatomic, weak) id<MYTextFieldDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
