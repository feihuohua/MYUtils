//
//  MYHeaderTabViewBar.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYHeaderTabViewBar.h"
#import <UIColor+Hex.h>
#import <NSString+Contains.h>
#import <UIView+Position.h>

@interface MYHeaderTabViewBar ()

@property (nonatomic, strong) NSMutableArray *buttons;
/// 当前选中的索引
@property (nonatomic, assign) NSInteger currentIndex;
/// scrollView
@property (nonatomic, strong) UIScrollView *contentView;
/// 分割线
@property (nonatomic, strong) UIView *seperatorView;
/// 记录刚开始时的偏移量
@property (nonatomic, assign) NSInteger startOffsetX;

@end

@implementation MYHeaderTabViewBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        // 变量初始化
        [self variableInitialization];
        
        // 设置子控件
        [self setupSubViews];
    }
    return self;
}

/// 初始化变量
- (void)variableInitialization {
    _seperatorViewHidden = YES;
    _margin = 12.0f;
    _padding = 12.0f;
    _startOffsetX = 0.0f;
    _cornerRadius = 14.0f;
    
    // 默认12号字体
    _titleFont = [UIFont systemFontOfSize:12.0];
    _titleNormalColor = [UIColor colorWithHexString:@"#666666"];
    _titleSelectedColor = [UIColor redColor];
}

/// 设置子控件
- (void)setupSubViews {
    
    // 1、添加 UIScrollView
    [self addSubview:self.contentView];
    
    // 2、添加底部分割线
    [self addSubview:self.seperatorView];
}

#pragma mark -

- (void)tabWillScrollFromIndex:(NSInteger)index offsetX:(CGFloat)contentOffsetX {
    
    self.startOffsetX = contentOffsetX;
}

- (void)tabScrollXOffset:(CGFloat)contentOffsetX {
    
}

- (void)tabDidScrollToIndex:(NSInteger)index {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        btn.enabled = YES;
    }];
    _currentIndex = index;
    
    [self updateContentViewContentOffset];
}

// 更新contentView的offsetX
- (void)updateContentViewContentOffset {
    UIButton *currentButton = [self buttonAtIndex:_currentIndex];
    
    currentButton.enabled = NO;
    
    // 计算偏移量
    CGFloat offsetX = currentButton.center.x - self.bounds.size.width * 0.5;
    if (offsetX < 0) {
        offsetX = 0;
    }
    // 获取最大滚动范围
    CGFloat maxOffsetX = self.contentView.contentSize.width - self.bounds.size.width;
    if (offsetX > maxOffsetX) {
        offsetX = maxOffsetX;
    }
    if (offsetX < 0) {
        return;
    }
    // 滚动标题滚动条
    [self.contentView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

#pragma mark -
- (void)reloadTabIndex:(NSInteger)index {
    if (index >= self.buttons.count) {
        return;
    }
    
    UIButton *btn = [self.buttons objectAtIndex:index];
    NSString *title = [self.delegate tabViewBar:self titleForIndex:index];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateDisabled];
    
}

- (void)reloadTabBar {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        [btn removeFromSuperview];
    }];
    NSInteger count = [self.delegate numberOfTabForTabViewBar:self];
    
    CGFloat btnX = _padding;
    
    for (NSInteger index = 0; index < count; index++) {
        UIButton *button = [self createButton];
        button.tag = index;
        NSString *title = [self.delegate tabViewBar:self titleForIndex:index];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateDisabled];
        
        CGFloat cellWidth = [self sizeWithTitle:title].width + _padding * 2;
        CGFloat cellHeight = self.height - _padding * 2;
        button.frame = CGRectMake(btnX, _padding, cellWidth, cellHeight);
        btnX = cellWidth + btnX + _margin;
        [self.buttons addObject:button];
        [self.contentView addSubview:button];
    }
    self.contentView.contentSize = CGSizeMake(CGRectGetMaxX(self.contentView.subviews.lastObject.frame) + _padding, CGRectGetHeight(self.bounds));
    
    if (self.buttons.count < 1) {
        return;
    }
    [self tabDidScrollToIndex:_currentIndex];
}

- (CGSize)sizeWithTitle:(NSString *)title {
    
    // 缺省字符处理
    if ([self wordsCount:title] < 4) {
        title = @"全民直播";
    }
    NSDictionary *attrs = @{NSFontAttributeName : _titleFont};
    return [title boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (int)wordsCount:(NSString *)text {
    NSInteger n = text.length;
    int i;
    int l = 0, a = 0, b = 0;
    unichar c;
    for (i = 0; i < n; i++) {
        c = [text characterAtIndex:i];
        if (isblank(c)) {
            b++;
        } else if (isascii(c)) {
            a++;
        } else {
            l++;
        }
    }
    if (a == 0 && l == 0) {
        return 0;
    }
    return l + (int)ceilf((float)(a + b) / 2.0);
}

- (UIButton *)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = _titleFont;
    button.layer.cornerRadius = _cornerRadius;
    [button setTitleColor:_titleNormalColor forState:UIControlStateNormal];
    [button setTitleColor:_titleSelectedColor forState:UIControlStateDisabled];
    [button setBackgroundColor:[UIColor colorWithRed:243.0f/255.0f green:243.0f/255.0f blue:243.0f/255.0f alpha:0.72f]];
    [button addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return button;
}

- (void)onBtnClick:(UIButton *)sender {
    if ([self.delegate respondsToSelector:@selector(tabViewBar:didSelectIndex:)]) {
        [self.delegate tabViewBar:self didSelectIndex:sender.tag];
    }
}

- (UIButton *)buttonAtIndex:(NSInteger)index {
    if (index < 0 || index >= self.buttons.count) {
        return nil;
    }
    return self.buttons[index];
}

- (void)setSeperatorViewHidden:(BOOL)seperatorViewHidden {
    _seperatorViewHidden = seperatorViewHidden;
    self.seperatorView.hidden = seperatorViewHidden;
}

- (NSMutableArray *)buttons {
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}

- (UIScrollView *)contentView {
    if (!_contentView) {
        _contentView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _contentView.backgroundColor = [UIColor clearColor];
        _contentView.showsHorizontalScrollIndicator = NO;
        _contentView.showsVerticalScrollIndicator = NO;
        _contentView.alwaysBounceHorizontal = YES;
    }
    return _contentView;
}

- (UIView *)seperatorView {
    if (!_seperatorView) {
        _seperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(self.bounds) - 0.5, CGRectGetWidth(self.bounds), 0.5)];
        _seperatorView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.1];
        _seperatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
        _seperatorView.hidden = _seperatorViewHidden;
    }
    return _seperatorView;
}

@end
