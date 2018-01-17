//
//  MYHeaderTabViewBar.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYHeaderTabViewBar.h"
#import <UIView+Position.h>

@interface MYHeaderTabViewBar ()

@property (nonatomic, strong) NSMutableArray *buttons;
/// 当前选中的索引
@property (nonatomic, assign) NSInteger currentIndex;
/// scrollView
@property (nonatomic, strong) UIScrollView *contentView;
/// 分割线
@property (nonatomic, strong) UIView *seperatorView;
/// 指示器
@property (nonatomic, strong) UIView *indicatorView;
/// 记录刚开始时的偏移量
@property (nonatomic, assign) NSInteger startOffsetX;

@end

@implementation MYHeaderTabViewBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        [self initialization];
        [self setupSubViews];
    }
    return self;
}

/// 初始化变量
- (void)initialization {
    _seperatorViewHidden = NO;
    _indicatorStyle = MYIndicatorStyleDefault;
    _indicatorCornerRadius = 0;
    _indicatorBorderWidth = 0;
    _indicatorBorderColor = [UIColor clearColor];
    _indicatorAdditionalWidth = 0;
    _itemSpacing = 20.0;
    _indicatorHeight = 2.0;
    _startOffsetX = 0.0;
    _titleFont = [UIFont systemFontOfSize:14.0];
    _indicatorColor = [UIColor colorWithRed:29.0f/255.0f green:154.0f/255.0f blue:255.0f/255.0f alpha:1];
    _titleNormalColor = [UIColor colorWithWhite:0 alpha:0.2];
    _titleSelectedColor = [UIColor colorWithRed:29.0f/255.0f green:154.0f/255.0f blue:255.0f/255.0f alpha:1];
}

/// 设置子控件
- (void)setupSubViews {
    
    // 1、添加 UIScrollView
    [self addSubview:self.contentView];
    
    // 2、添加底部分割线
    [self addSubview:self.seperatorView];
    
    // 3、添加指示器
    [self.contentView addSubview:self.indicatorView];
}

#pragma mark -

- (void)tabWillScrollFromIndex:(NSInteger)index offsetX:(CGFloat)contentOffsetX {
    
    self.startOffsetX = contentOffsetX;
}

- (void)tabScrollXOffset:(CGFloat)contentOffsetX {
    
    CGFloat progress = 0;
    NSInteger originalIndex = 0;
    NSInteger targetIndex = 0;
    // 判断是左滑还是右滑
    CGFloat currentOffsetX = contentOffsetX;
    CGFloat scrollViewW = self.contentView.bounds.size.width;
    if (currentOffsetX > self.startOffsetX) { // 左滑
        // 1、计算 progress
        progress = currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW);
        // 2、计算 originalIndex
        originalIndex = currentOffsetX / scrollViewW;
        // 3、计算 targetIndex
        targetIndex = originalIndex + 1;
        if (targetIndex >= self.buttons.count) {
            progress = 1;
            targetIndex = originalIndex;
        }
        // 4、如果完全划过去
        if (currentOffsetX - self.startOffsetX == scrollViewW) {
            progress = 1;
            targetIndex = originalIndex;
        }
    } else { // 右滑
        // 1、计算 progress
        progress = 1 - (currentOffsetX / scrollViewW - floor(currentOffsetX / scrollViewW));
        // 2、计算 targetIndex
        targetIndex = currentOffsetX / scrollViewW;
        // 3、计算 originalIndex
        originalIndex = targetIndex + 1;
        if (originalIndex >= self.buttons.count) {
            originalIndex = self.buttons.count - 1;
        }
    }
    
    UIButton *originalBtn = self.buttons[originalIndex];
    UIButton *targetBtn = self.buttons[targetIndex];
    
    // 1、计算 targetBtn／originalBtn 之间的 x 差值
    CGFloat totalOffsetX = targetBtn.origin.x - originalBtn.origin.x;
    // 2、计算 targetBtn／originalBtn 之间的差值
    CGFloat totalDistance = CGRectGetMaxX(targetBtn.frame) - CGRectGetMaxX(originalBtn.frame);
    /// 计算 indicatorView 滚动时 x 的偏移量
    CGFloat offsetX = 0.0;
    /// 计算 indicatorView 滚动时宽度的偏移量
    CGFloat distance = 0.0;
    
    offsetX = totalOffsetX * progress + + 0.5 * _itemSpacing;
    distance = progress * (totalDistance - totalOffsetX) - _itemSpacing;
    
    /// 计算 indicatorView 新的 frame
    if (self.indicatorStyle == MYIndicatorStyleCover) {
        _indicatorView.x = originalBtn.origin.x + offsetX - self.indicatorAdditionalWidth / 2;
        _indicatorView.width = originalBtn.width + distance + self.indicatorAdditionalWidth;
    } else {
        _indicatorView.x = originalBtn.origin.x + offsetX;
        _indicatorView.width = originalBtn.width + distance;
    }
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
    id title = [self.delegate tabViewBar:self titleForIndex:index];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateDisabled];
    
}

- (void)reloadTabBar {
    [self.buttons enumerateObjectsUsingBlock:^(UIButton *btn, NSUInteger idx, BOOL *stop) {
        [btn removeFromSuperview];
    }];
    NSInteger count = [self.delegate numberOfTabForTabViewBar:self];
    
    CGFloat btnX = 0;
    
    for (NSInteger index = 0; index < count; index++) {
        UIButton *button = [self createButton];
        button.tag = index;
        id title = [self.delegate tabViewBar:self titleForIndex:index];
        [button setTitle:title forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateDisabled];
        
        CGFloat cellWidth = [self sizeWithTitle:title].width + _itemSpacing;
        button.frame = CGRectMake(btnX, 0, cellWidth, CGRectGetHeight(self.bounds));
        btnX = cellWidth + btnX;
        [self.buttons addObject:button];
        [self.contentView addSubview:button];
    }
    self.contentView.contentSize = CGSizeMake(CGRectGetMaxX(self.contentView.subviews.lastObject.frame), 44.0);
    
    if (self.buttons.count < 1) {
        return;
    }
    [self tabDidScrollToIndex:_currentIndex];
    
    UIButton *firstButton = self.buttons.firstObject;
    [self updateIndicatorStyle:firstButton];
}

// 更新Indicator的偏移量
- (void)updateIndicatorStyle:(UIButton *)currentButton {
    
    CGFloat indicatorViewWidth = [self sizeWithTitle:currentButton.currentTitle].width;
    CGFloat tempIndicatorViewHeight = [self sizeWithTitle:currentButton.currentTitle].height;
    
    if (self.indicatorStyle == MYIndicatorStyleCover) {
        
        if (self.indicatorHeight < tempIndicatorViewHeight && tempIndicatorViewHeight + self.indicatorAdditionalWidth < self.height) {
            _indicatorView.y = 0.5 * (self.height - tempIndicatorViewHeight - self.indicatorAdditionalWidth);
            _indicatorView.height = tempIndicatorViewHeight + self.indicatorAdditionalWidth;
        } else {
            _indicatorView.y = 0.5 * self.indicatorAdditionalWidth;
            _indicatorView.height = self.height - self.indicatorAdditionalWidth;
        }
        
        _indicatorView.x = (currentButton.width - indicatorViewWidth - self.indicatorAdditionalWidth)/2;
        _indicatorView.width = indicatorViewWidth + self.indicatorAdditionalWidth;
        
        // 圆角处理
        if (self.indicatorCornerRadius > 0.5 * _indicatorView.height) {
            _indicatorView.layer.cornerRadius = 0.5 * _indicatorView.height;
        } else {
            _indicatorView.layer.cornerRadius = self.indicatorCornerRadius;
        }
        // 边框宽度及边框颜色
        _indicatorView.layer.borderWidth = self.indicatorBorderWidth;
        _indicatorView.layer.borderColor = self.indicatorBorderColor.CGColor;
    } else {
        _indicatorView.x = (currentButton.width - indicatorViewWidth)/2;
        _indicatorView.width = indicatorViewWidth;
        _indicatorView.height = _indicatorHeight;
        _indicatorView.y = CGRectGetHeight(self.bounds) - _indicatorHeight;
    }
}

- (CGSize)sizeWithTitle:(NSString *)title {
    NSDictionary *attrs = @{NSFontAttributeName : _titleFont};
    return [title boundingRectWithSize:CGSizeMake(0, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (UIButton *)createButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = _titleFont;
    [btn setTitleColor:_titleNormalColor forState:UIControlStateNormal];
    [btn setTitleColor:_titleSelectedColor forState:UIControlStateDisabled];
    [btn addTarget:self action:@selector(onBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
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

- (void)setIndicatorColor:(UIColor *)indicatorColor {
    _indicatorColor = indicatorColor;
    self.indicatorView.backgroundColor = indicatorColor;
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
    }
    return _seperatorView;
}

- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] initWithFrame:CGRectZero];
        _indicatorView.backgroundColor = _indicatorColor;
    }
    return _indicatorView;
}


@end
