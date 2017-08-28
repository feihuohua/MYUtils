//
//  UITextField+Extension.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UITextField+Extension.h"
#import <objc/message.h>

static const void *UITextField_placeholderColorKey = &UITextField_placeholderColorKey;

@implementation UITextField (Extension)

+ (void)load {
    Method setPlaceholderMethod = class_getInstanceMethod(self, @selector(setPlaceholder:));
    Method my_setPlaceholderMethod = class_getInstanceMethod(self, @selector(my_setPlaceholder:));
    
    method_exchangeImplementations(setPlaceholderMethod, my_setPlaceholderMethod);
}


/*
 *【设置占位文字的颜色】
 */
- (void)setPlaceholderColor:(UIColor *)placeholderColor {
    
    // 给成员属性赋值 runtime给系统的类添加成员属性
    // 添加成员属性
    objc_setAssociatedObject(self, UITextField_placeholderColorKey, placeholderColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    // 获取占位文字label控件
    UILabel *placeholderLabel = [self valueForKey:@"placeholderLabel"];
    
    // 设置占位文字颜色
    placeholderLabel.textColor = placeholderColor;
}

- (UIColor *)placeholderColor {
    return objc_getAssociatedObject(self, UITextField_placeholderColorKey);
}

// 设置占位文字 和 文字颜色
- (void)my_setPlaceholder:(NSString *)placeholder {
    [self my_setPlaceholder:placeholder];
    
    self.placeholderColor = self.placeholderColor;
}

@end
