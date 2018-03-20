//
//  MYTextFieldViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/30.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYTextFieldViewController.h"
#import "MYTextField.h"
#import "UIFloatLabelTextField.h"

@interface MYTextFieldViewController ()<MYTextFieldDelegate, UITextFieldDelegate>

@property (nonatomic, strong) MYTextField *bankTextField;
@property (nonatomic, strong) MYTextField *phoneTextField;
@property (nonatomic, strong) MYTextField *idCardTextField;
@property (nonatomic, strong) UIFloatLabelTextField *firstNameTextField;

@end

@implementation MYTextFieldViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"自定义UITexField";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self loadTextFieldWithFrame];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(phoneFieldEditingChanged) name:UITextFieldTextDidBeginEditingNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.phoneTextField.textField becomeFirstResponder];
}

- (void)phoneFieldEditingChanged {
    
}

- (void)loadTextFieldWithFrame {
    
    //固定4个进行分隔
    self.bankTextField = [[MYTextField alloc] initWithSeparateCount:4];
    self.bankTextField.frame = CGRectMake(20, 100, 300, 45);
    self.bankTextField.delegate = self;
    self.bankTextField.limitCount = 19;//可以不设置，但是那样的话，就可以无限输入了
    self.bankTextField.layer.cornerRadius = 4.0;
    self.bankTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.bankTextField.layer.borderWidth = 2.0;
    self.bankTextField.placeholder = @"XXXX XXXX XXXX XXXX XXX";
    [self.view addSubview:self.bankTextField];
    
    
    //按照数组中的进行分隔，假如分隔电话号码@[@"3",@"4",@"4"]即可
    self.phoneTextField = [[MYTextField alloc] initWithSeparateArray:@[@"3",@"4",@"4"]];
    self.phoneTextField.frame = CGRectMake(20, CGRectGetMaxY(self.bankTextField.frame) + 10, 300, 45);
    self.phoneTextField.delegate = self;
    self.phoneTextField.limitCount = 11;//可以不设置，但是那样的话，就可以无限输入了
    self.phoneTextField.layer.cornerRadius = 4.0;
    self.phoneTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.phoneTextField.layer.borderWidth = 2.0;
    self.phoneTextField.placeholder = @"XXX XXXX XXXX";
    [self.view addSubview:self.phoneTextField];
    
    
    //输入身份证号
    self.idCardTextField = [[MYTextField alloc] initWithSeparateArray:@[@"6",@"8",@"4"]];
    self.idCardTextField.frame = CGRectMake(20, CGRectGetMaxY(self.phoneTextField.frame) + 10, 300, 45);
    self.idCardTextField.placeholder = @"XXXXXX XXXXXXXX XXXX";
    self.idCardTextField.delegate = self;
    self.idCardTextField.limitCount = 18;//可以不设置，但是那样的话，就可以无限输入了
    self.idCardTextField.layer.cornerRadius = 4.0;
    self.idCardTextField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.idCardTextField.layer.borderWidth = 2.0;
    
    [self.view addSubview:self.idCardTextField];
    
    UIFloatLabelTextField *firstNameTextField = [[UIFloatLabelTextField alloc] init];
    firstNameTextField.backgroundColor = [UIColor lightGrayColor];
    firstNameTextField.frame = CGRectMake(20, CGRectGetMaxY(self.idCardTextField.frame) + 10, 300, 50);
    firstNameTextField.floatLabelActiveColor = [UIColor orangeColor];
    firstNameTextField.placeholder = @"First Name";
    firstNameTextField.text = @"Arthur";
    firstNameTextField.delegate = self;
    [self.view addSubview:firstNameTextField];
    
    UIFloatLabelTextField *lastNameTextField = [[UIFloatLabelTextField alloc] init];
    lastNameTextField.backgroundColor = [UIColor lightGrayColor];
    lastNameTextField.frame = CGRectMake(20, CGRectGetMaxY(firstNameTextField.frame) + 10, 300, 50);
    lastNameTextField.floatLabelActiveColor = [UIColor purpleColor];
    lastNameTextField.placeholder = @"Last Name";
    [self.view addSubview:lastNameTextField];
    
    UIFloatLabelTextField *twitterTextField = [[UIFloatLabelTextField alloc] init];
    twitterTextField.backgroundColor = [UIColor lightGrayColor];
    twitterTextField.frame = CGRectMake(20, CGRectGetMaxY(lastNameTextField.frame) + 10, 300, 50);
    twitterTextField.placeholder = @"Twitter Moniker";
    twitterTextField.dismissKeyboardWhenClearingTextField = @YES;
    twitterTextField.clearButtonMode = UITextFieldViewModeNever;
    [self.view addSubview:twitterTextField];
    
}

#pragma mark - UIResponder
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    if(![touch.view isMemberOfClass:[UITextField class]]) {
        [touch.view endEditing:YES];
    }
}

@end
