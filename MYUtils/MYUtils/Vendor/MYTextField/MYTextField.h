//
//  MYTextField.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/30.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYTextField : UITextField


/**
 限制输入数量

 @param count 限制输入的数量
 @return
 */
- (instancetype)initWithSeparateCount:(NSInteger)count;

/**
 限制输入数量

 @param frame 视图的frame
 @param count 限制输入的数量
 @return
 */
- (instancetype)initWithFrame:(CGRect)frame
                separateCount:(NSInteger)count;


/**
 根据数组限制输入字符数量

 @param countArray 数组
 @return
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

@end
