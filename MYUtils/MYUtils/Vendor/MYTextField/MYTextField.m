//
//  MYTextField.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/30.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYTextField.h"

// placeHolder的左侧距离
static const NSInteger placeHolderLeft = 10;

@interface MYTextField ()<UITextFieldDelegate>

/**
 *  每隔多少字符分割
 **/
@property (nonatomic, assign) NSInteger separateCount;

/**
 *  分割的array
 **/
@property (nonatomic, strong) NSMutableArray *separateArray;

/**
 *  Location
 **/
@property (nonatomic, assign) NSInteger locationIndex;

@end
@implementation MYTextField

- (instancetype)initWithSeparateCount:(NSInteger)count {
    if (self = [super init]) {
        
        self.separateCount = count;
        self.locationIndex = 0;
        
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;//键盘类型
        self.font = [UIFont systemFontOfSize:20.0];
        self.tintColor = [UIColor grayColor];//光标颜色
        
        // 左侧填充视图
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, placeHolderLeft, 0)];
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame separateCount:(NSInteger)count {
    if (self = [super initWithFrame:frame]) {
        self.separateCount = count;
        self.locationIndex = 0;
        
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;//键盘类型
        self.font = [UIFont systemFontOfSize:20.0];
        self.tintColor = [UIColor grayColor];//光标颜色
        
        // 左侧填充视图
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, placeHolderLeft, frame.size.height)];
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (instancetype)initWithSeparateArray:(NSArray *)countArray {
    if (self = [super init]) {
        self.separateArray = [NSMutableArray arrayWithArray:countArray];
        
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;//键盘类型
        self.font = [UIFont systemFontOfSize:20.0];
        self.tintColor = [UIColor grayColor];//光标颜色
        
        // 左侧填充视图
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, placeHolderLeft, 0)];
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame separateArray:(NSArray *)countArray {
    if (self = [super initWithFrame:frame]) {
        self.separateArray = [NSMutableArray arrayWithArray:countArray];
        
        self.delegate = self;
        self.keyboardType = UIKeyboardTypeNumberPad;//键盘类型
        self.font = [UIFont systemFontOfSize:20.0];
        self.tintColor = [UIColor grayColor];//光标颜色
        
        // 左侧填充视图
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, placeHolderLeft, frame.size.height)];
        self.leftView = view;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

- (NSString *)userInputContent {
    NSString *text = self.text;
    
    NSMutableString *mutableText = [NSMutableString stringWithString:text];
    
    NSString *contentStr = [mutableText stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return contentStr;
}

#pragma mark - textField代理
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    if (![string isEqualToString:@""]) {
        
        // 处理之后的字符串
        NSString *dealString = [self changeStringWithOperateString:string withOperateRange:range withOriginString:textField.text];
        
        textField.text = dealString;
    }
    
    if ([string isEqualToString:@""]) {
        
        // 处理之后的字符串
        NSString *dealString = [self changeStringWithOperateString:string withOperateRange:range withOriginString:textField.text];
        textField.text = dealString;
    }
    
    // 设置光标位置
    [self setSelectedRange:NSMakeRange(self.locationIndex, 0)];
    return NO;
}

#pragma mark - 设置光标
- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

- (NSString *)changeStringWithOperateString:(NSString *)string withOperateRange:(NSRange)range withOriginString:(NSString *)originString {
    
    self.locationIndex = range.location;
    
    // 原始字符串
    NSMutableString *originStr = [NSMutableString stringWithString:originString];
    
    // 截取操作的位置之前的字符串
    NSMutableString *subStr = [NSMutableString stringWithString:[originStr substringToIndex:range.location]];
    // 光标前的字符串 剔除空格符号
    NSString *subNoSpace = [subStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 得到操作处前面 空格的总数目
    NSInteger originSpaceCount = subStr.length - subNoSpace.length;
    
    if ([string isEqualToString:@""]) {
        // 删除字符
        [originStr deleteCharactersInRange:range];
    } else {
        NSMutableString *originMutableStr = [NSMutableString stringWithString:originString];
        NSString *originNoString = [originMutableStr stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (self.limitCount > 0 && originNoString.length >= self.limitCount) {
            return originString;
        }
        // 插入字符
        [originStr insertString:string atIndex:range.location];
        // 插入后，index要加1
        self.locationIndex += 1;
    }
    NSString *originNoSpaceString = [originStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 原始字符串，全部剔除空格
    NSMutableString *newString = [NSMutableString stringWithString:originNoSpaceString];
    if (self.separateCount > 0) {
        // 如果是等量分割
        for (NSInteger i = newString.length; i > 0; i--) {
            if (i % self.separateCount == 0) {
                // 插入空格符
                [newString insertString:@" " atIndex:i];
            }
        }
    }
    
    if (self.separateArray.count > 0) {
        // 应该操作的index
        NSMutableArray *indexArray = [NSMutableArray array];
        NSInteger currentIndex = 0;
        for (int i = 0; i< self.separateArray.count; i++) {
            // 从用户设置的数组中取值
            id object = self.separateArray[i];
            if ([object isKindOfClass:[NSString class]]) {
                // 第n次按照多少个分隔
                NSInteger count = [object integerValue];
                // 累加
                currentIndex += count;
                // 拿到分割处的index
                NSNumber *indexNumber = [NSNumber numberWithInteger:currentIndex];
                // 添加到数组中
                [indexArray addObject:indexNumber];
            }
        }
        
        // 倒序插入空格符
        for (NSInteger j = indexArray.count - 1; j >= 0; j--) {
            NSNumber *indexObject = indexArray[j];
            NSInteger index = [indexObject integerValue];
            // 不可越界
            if (index < newString.length) {
                [newString insertString:@" " atIndex:index];
            }
        }
    }
    
    NSString *newSubString;
    if (self.locationIndex > newString.length) {
        // 如果是删除最后一位数字，且数字的左侧为空格时，防止越界
        newSubString = [NSString stringWithFormat:@"%@",newString];
        self.locationIndex -= 1;
    } else {
        // 添加字符后，光标的左侧文本
        newSubString = [newString substringToIndex:self.locationIndex];
    }
    // 光标左侧文本
    NSMutableString *newSubMutableString = [NSMutableString stringWithString:newSubString];
    // 将操作后的左侧文本 剔除空格
    NSString *newNoSpaceString = [newSubMutableString stringByReplacingOccurrencesOfString:@" " withString:@""];
    // 操作后的左侧文本，空格的数量
    NSInteger newSpaceCount = newSubString.length - newNoSpaceString.length;
    // 如果操作前的空格数量等于操作后的空格数量
    if (originSpaceCount == newSpaceCount) {
        if ([string isEqualToString:@""]) {
            // 删除的时候，如果删了该数字后，左侧为空格，则需要光标再左移1位
            if (range.location > 0) {
                NSString *originSubS = [originStr substringWithRange:NSMakeRange(range.location - 1, 1)];
                if ([originSubS isEqualToString:@" "]) {
                    self.locationIndex -= 1;
                }
            }
        }
    } else {
        // 如果操作前的空格数量不等于操作后的空格数量，说明新增文本前，又添加了空格，需要将光标右移1位
        if (![string isEqualToString:@""]) {
            self.locationIndex += 1;
        }
    }
    return newString;
}

@end
