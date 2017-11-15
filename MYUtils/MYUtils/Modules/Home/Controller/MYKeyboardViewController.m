//
//  MYKeyboardViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/23.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYKeyboardViewController.h"
#import <ZYKeyboardUtil.h>

#define MARGIN_KEYBOARD 10

@interface MYKeyboardViewController ()<UITextFieldDelegate>

@property (nonatomic, strong) ZYKeyboardUtil *keyboardUtil;
@property (nonatomic, weak) IBOutlet UITextField *mainTextField;
@property (nonatomic, weak) IBOutlet UIView *inputViewBorderView;
@property (nonatomic, weak) IBOutlet UITextField *secondTextField;
@property (nonatomic, weak) IBOutlet UITextField *thirdTextField;

@end

@implementation MYKeyboardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mainTextField.delegate = self;
    self.secondTextField.delegate = self;
    self.thirdTextField.delegate = self;
    [self configKeyBoardRespond];
}

- (void)dealloc {
    self.mainTextField.delegate = nil;
    self.secondTextField.delegate = nil;
    self.thirdTextField.delegate = nil;
}

- (void)configKeyBoardRespond {
    self.keyboardUtil = [[ZYKeyboardUtil alloc] initWithKeyboardTopMargin:MARGIN_KEYBOARD];
    __weak MYKeyboardViewController *weakSelf = self;
#pragma explain - 全自动键盘弹出/收起处理 (需调用keyboardUtil 的 adaptiveViewHandleWithController:adaptiveView:)
#pragma explain - use animateWhenKeyboardAppearBlock, animateWhenKeyboardAppearAutomaticAnimBlock will be invalid.
    [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
        [keyboardUtil adaptiveViewHandleWithController:weakSelf adaptiveView:weakSelf.inputViewBorderView, weakSelf.secondTextField, weakSelf.thirdTextField, nil];
    }];
    /*  or
     [_keyboardUtil setAnimateWhenKeyboardAppearAutomaticAnimBlock:^(ZYKeyboardUtil *keyboardUtil) {
     [keyboardUtil adaptiveViewHandleWithAdaptiveView:weakSelf.inputViewBorderView, weakSelf.secondTextField, weakSelf.thirdTextField, nil];
     }];
     */
    
#pragma explain - 自定义键盘弹出处理(如配置，全自动键盘处理则失效)
#pragma explain - use animateWhenKeyboardAppearAutomaticAnimBlock, animateWhenKeyboardAppearBlock must be nil.
    /*
     [_keyboardUtil setAnimateWhenKeyboardAppearBlock:^(int appearPostIndex, CGRect keyboardRect, CGFloat keyboardHeight, CGFloat keyboardHeightIncrement) {
     NSLog(@"\n\n键盘弹出来第 %d 次了~  高度比上一次增加了%0.f  当前高度是:%0.f"  , appearPostIndex, keyboardHeightIncrement, keyboardHeight);
     //do something
     }];
     */
    
#pragma explain - 自定义键盘收起处理(如不配置，则默认启动自动收起处理)
#pragma explain - if not configure this Block, automatically itself.
    /*
     [_keyboardUtil setAnimateWhenKeyboardDisappearBlock:^(CGFloat keyboardHeight) {
     NSLog(@"\n\n键盘在收起来~  上次高度为:+%f", keyboardHeight);
     //do something
     }];
     */
    
#pragma explain - 获取键盘信息
    [_keyboardUtil setPrintKeyboardInfoBlock:^(ZYKeyboardUtil *keyboardUtil, KeyboardInfo *keyboardInfo) {
        NSLog(@"\n\n拿到键盘信息 和 ZYKeyboardUtil对象");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark delegate
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.mainTextField resignFirstResponder];
    [self.secondTextField resignFirstResponder];
    [self.thirdTextField resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.mainTextField resignFirstResponder];
    [self.secondTextField resignFirstResponder];
    [self.thirdTextField resignFirstResponder];
    return YES;
}

@end
