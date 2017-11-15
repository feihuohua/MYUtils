//
//  HKNumberButton.m
//  FXVIP
//
//  Created by sunjinshuai on 2017/9/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "HKNumberButton.h"

@interface HKNumberButton ()<UITextFieldDelegate>

/// 控件自身的宽
@property (nonatomic, assign) CGFloat width;
/// 控件自身的高
@property (nonatomic, assign) CGFloat height;
/// 快速加减定时器
@property (nonatomic, strong) NSTimer *timer;
/// 减按钮
@property (nonatomic, strong) UIButton *decreaseButton;
/// 加按钮
@property (nonatomic, strong) UIButton *increaseButton;
/// 数量展示/输入框
@property (nonatomic, strong) UITextField *textField;

@end

@implementation HKNumberButton

- (instancetype)init {
    if (self = [super init]) {
        [self setupUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
        // 整个控件的默认尺寸(和某宝上面的按钮同样大小)
        if (CGRectIsEmpty(frame)) {
            self.frame = CGRectMake(0, 0, 110, 30);
        };
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    _minValue = 1;
    _maxValue = NSIntegerMax;
    _inputFieldFont = 15;
    _buttonTitleFont = 17;
    _longPressSpaceTime = 0.1f;
  
    [self addSubview:self.decreaseButton];
    [self addSubview:self.increaseButton];
    [self addSubview:self.textField];
    
    self.clipsToBounds = YES;
    self.layer.cornerRadius = 3.f;
    self.backgroundColor = [UIColor whiteColor];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _width =  self.frame.size.width;
    _height = self.frame.size.height;
    _textField.frame = CGRectMake(_height, 0, _width - 2 * _height, _height);
    _increaseButton.frame = CGRectMake(_width - _height, 0, _height, _height);
    
    if (_decreaseHide && _textField.text.integerValue < _minValue) {
        _decreaseButton.frame = CGRectMake(_width - _height, 0, _height, _height);
    } else {
        _decreaseButton.frame = CGRectMake(0, 0, _height, _height);
    }
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self checkTextFieldNumberWithUpdate];
    [self buttonClickCallBackWithIncreaseStatus:NO];
}

#pragma mark - Event Response
/// 点击: 单击逐次加减,长按连续快速加减
- (void)touchDown:(UIButton *)sender {
    [_textField resignFirstResponder];
    
    if (sender == _increaseButton) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_longPressSpaceTime target:self selector:@selector(increase) userInfo:nil repeats:YES];
    } else {
        _timer = [NSTimer scheduledTimerWithTimeInterval:_longPressSpaceTime target:self selector:@selector(decrease) userInfo:nil repeats:YES];
    }
    [_timer fire];
}

/// 手指松开
- (void)touchUp:(UIButton *)sender {
    [self cleanTimer];
}

/// 加运算
- (void)increase {
    [self checkTextFieldNumberWithUpdate];
    
    NSInteger number = _textField.text.integerValue + 1;
    
    if (number <= _maxValue) {
        // 当按钮为"减号按钮隐藏模式",且输入框值==设定最小值,减号按钮展开
        if (_decreaseHide && number == _minValue) {
            [self rotationAnimationMethod];
            [UIView animateWithDuration:0.3f animations:^{
                _decreaseButton.alpha = 1;
                _decreaseButton.frame = CGRectMake(0, 0, _height, _height);
            } completion:^(BOOL finished) {
                _textField.hidden = NO;
            }];
        }
        _textField.text = [NSString stringWithFormat:@"%ld", number];
        
        [self buttonClickCallBackWithIncreaseStatus:YES];
    } else {
        if (_shakeAnimation) {
            [self shakeAnimationMethod];
        }
    }
}

/// 减运算
- (void)decrease {
    [self checkTextFieldNumberWithUpdate];
    
    NSInteger number = [_textField.text integerValue] - 1;
    
    if (number >= _minValue) {
        _textField.text = [NSString stringWithFormat:@"%ld", number];
        [self buttonClickCallBackWithIncreaseStatus:NO];
    } else {
        // 当按钮为"减号按钮隐藏模式",且输入框值 < 设定最小值,减号按钮隐藏
        if (_decreaseHide && number<_minValue) {
            _textField.hidden = YES;
            _textField.text = [NSString stringWithFormat:@"%ld",_minValue - 1];
            
            [self buttonClickCallBackWithIncreaseStatus:NO];
            [self rotationAnimationMethod];
            
            [UIView animateWithDuration:0.3f animations:^{
                _decreaseButton.alpha = 0;
                _decreaseButton.frame = CGRectMake(_width - _height, 0, _height, _height);
            }];
            
            return;
        }
        if (_shakeAnimation) {
            [self shakeAnimationMethod];
        }
    }
}

/// 点击响应
- (void)buttonClickCallBackWithIncreaseStatus:(BOOL)increaseStatus {
    _editCompletion ? _editCompletion(_textField.text.integerValue, increaseStatus) : nil;
    if ([_delegate respondsToSelector:@selector(numberButton: number: increaseStatus:)]) {
        [_delegate numberButton:self number:_textField.text.integerValue increaseStatus:increaseStatus];
    }
}

/// 检查TextField中数字的合法性,并修正
- (void)checkTextFieldNumberWithUpdate {
    NSString *minValueString = [NSString stringWithFormat:@"%ld",_minValue];
    NSString *maxValueString = [NSString stringWithFormat:@"%ld",_maxValue];
    
    if ([_textField.text isNotBlank] == NO || _textField.text.integerValue < _minValue) {
        _textField.text = _decreaseHide ? [NSString stringWithFormat:@"%ld",minValueString.integerValue-1] : minValueString;
    }
    _textField.text.integerValue > _maxValue ? _textField.text = maxValueString : nil;
}

/// 清除定时器
- (void)cleanTimer {
    if (_timer.isValid) {
        [_timer invalidate];
        _timer = nil;
    }
}

/// 抖动动画
- (void)shakeAnimationMethod {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.x"];
    CGFloat positionX = self.layer.position.x;
    animation.values = @[@(positionX-10),@(positionX),@(positionX+10)];
    animation.repeatCount = 3;
    animation.duration = 0.07;
    animation.autoreverses = YES;
    [self.layer addAnimation:animation forKey:nil];
}

/// 旋转动画
- (void)rotationAnimationMethod {
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = @(M_PI*2);
    rotationAnimation.duration = 0.3f;
    rotationAnimation.fillMode = kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [_decreaseButton.layer addAnimation:rotationAnimation forKey:nil];
}

- (void)setDecreaseHide:(BOOL)decreaseHide {
    if (decreaseHide) {
        if (_textField.text.integerValue <= _minValue) {
            _textField.hidden = YES;
            _decreaseButton.alpha = 0;
            _textField.text = [NSString stringWithFormat:@"%ld",_minValue - 1];
            _decreaseButton.frame = CGRectMake(_width - _height, 0, _height, _height);
        }
        self.backgroundColor = [UIColor clearColor];
    } else {
        _decreaseButton.frame = CGRectMake(0, 0, _height, _height);
    }
    _decreaseHide = decreaseHide;
}

- (void)setEditing:(BOOL)editing {
    _editing = editing;
    _textField.enabled = editing;
}

- (void)setMinValue:(NSInteger)minValue {
    _minValue = minValue;
    _textField.text = [NSString stringWithFormat:@"%ld",minValue];
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [borderColor CGColor];
    
    _decreaseButton.layer.borderWidth = 0.5;
    _decreaseButton.layer.borderColor = [borderColor CGColor];
    
    _increaseButton.layer.borderWidth = 0.5;
    _increaseButton.layer.borderColor = [borderColor CGColor];
}

- (void)setButtonTitleFont:(CGFloat)buttonTitleFont {
    _buttonTitleFont = buttonTitleFont;
    _increaseButton.titleLabel.font = [UIFont boldSystemFontOfSize:buttonTitleFont];
    _decreaseButton.titleLabel.font = [UIFont boldSystemFontOfSize:buttonTitleFont];
}

- (void)setIncreaseTitle:(NSString *)increaseTitle {
    _increaseTitle = increaseTitle;
    [_increaseButton setTitle:increaseTitle forState:UIControlStateNormal];
}

- (void)setDecreaseTitle:(NSString *)decreaseTitle {
    _decreaseTitle = decreaseTitle;
    [_decreaseButton setTitle:decreaseTitle forState:UIControlStateNormal];
}

- (void)setIncreaseImage:(UIImage *)increaseImage {
    _increaseImage = increaseImage;
    [_increaseButton setBackgroundImage:increaseImage forState:UIControlStateNormal];
}

- (void)setDecreaseImage:(UIImage *)decreaseImage {
    _decreaseImage = decreaseImage;
    [_decreaseButton setBackgroundImage:decreaseImage forState:UIControlStateNormal];
}

#pragma mark - 输入框中的内容设置
- (NSInteger)currentNumber {
    return _textField.text.integerValue;
}

- (void)setCurrentNumber:(NSInteger)currentNumber {
    if (_decreaseHide && currentNumber < _minValue) {
        _textField.hidden = YES;
        _decreaseButton.alpha = 0;
        _decreaseButton.frame = CGRectMake(_width -_height, 0, _height, _height);
    } else {
        _textField.hidden = NO;
        _decreaseButton.alpha = 1;
        _decreaseButton.frame = CGRectMake(0, 0, _height, _height);
    }
    _textField.text = [NSString stringWithFormat:@"%ld",currentNumber];
    [self checkTextFieldNumberWithUpdate];
}

- (void)setInputFieldFont:(CGFloat)inputFieldFont {
    _inputFieldFont = inputFieldFont;
    _textField.font = [UIFont systemFontOfSize:inputFieldFont];
}

- (UIButton *)increaseButton {
    if (!_increaseButton) {
        _increaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _increaseButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        [_increaseButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_increaseButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [_increaseButton addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel];
    }
    return _increaseButton;
}

- (UIButton *)decreaseButton {
    if (!_decreaseButton) {
        _decreaseButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _decreaseButton.titleLabel.font = [UIFont boldSystemFontOfSize:12.0f];
        [_decreaseButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_decreaseButton addTarget:self action:@selector(touchDown:) forControlEvents:UIControlEventTouchDown];
        [_decreaseButton addTarget:self action:@selector(touchUp:) forControlEvents:UIControlEventTouchUpOutside|UIControlEventTouchUpInside|UIControlEventTouchCancel];
    }
    return _decreaseButton;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.delegate = self;
        _textField.textAlignment = NSTextAlignmentCenter;
        _textField.keyboardType = UIKeyboardTypeNumberPad;
        _textField.font = [UIFont systemFontOfSize:_inputFieldFont];
        _textField.text = [NSString stringWithFormat:@"%ld",_minValue];
    }
    return _textField;
}

@end

@implementation NSString (NumberButton)

- (BOOL)isNotBlank {
    NSCharacterSet *blank = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    for (NSInteger i = 0; i < self.length; ++i) {
        unichar c = [self characterAtIndex:i];
        if (![blank characterIsMember:c]) {
            return YES;
        }
    }
    return NO;
}

@end
