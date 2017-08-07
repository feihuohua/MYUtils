//
//  MYShowTextViewCell.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYShowTextViewCell.h"
#import "MYShowTextCellModel.h"
#import "UILabel+FitLines.h"
#import "NSString+Size.h"

#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH  CGRectGetWidth([[UIScreen mainScreen] bounds])
#define QSTextLineSpacing 5
#define QSTextFontSize 15

@interface MYShowTextViewCell ()

@property (nonatomic, strong) MYShowTextCellModel *cellModel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *openContentBtn;

@end

@implementation MYShowTextViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.openContentBtn];
    }
    return self;
}

- (void)layoutSubviewsWithModel:(MYShowTextCellModel *)model {
    
    _titleLabel.text = @"DESCRIPTION";
    self.cellModel = (MYShowTextCellModel *)model;
    
    _contentLabel.text = model.content;
    BOOL isLimitedToLines = [_contentLabel my_adjustTextToFitLines:model.contentLines];
    _contentLabel.frame = CGRectMake(15, CGRectGetMaxY(self.titleLabel.frame) + 10, CGRectGetWidth( _contentLabel.bounds),CGRectGetHeight(_contentLabel.bounds));
    
    
    if (!isLimitedToLines && (model.contentLines != 0)) {
        self.openContentBtn.hidden = YES;
        
    } else {
        self.openContentBtn.hidden = NO;
        self.openContentBtn.selected = self.cellModel.isOpen;
    }
    
    if (!self.openContentBtn.hidden) {
        self.openContentBtn.frame = CGRectMake(15, CGRectGetMaxY(_contentLabel.frame) + 5, 80, 20);
    }
}

+ (CGFloat)cellHeightWithModel:(MYShowTextCellModel *)model{
    
    BOOL isLimitedToLines;
    CGSize textSize = [model.content textSizeWithFont:[UIFont systemFontOfSize:QSTextFontSize] numberOfLines:model.contentLines lineSpacing:QSTextLineSpacing constrainedWidth:SCREEN_WIDTH - 30 isLimitedToLines:&isLimitedToLines];
    
    CGFloat height = textSize.height + 54 + 25;
    if (!isLimitedToLines && (model.contentLines != 0)) {
        height -= 25;
    }
    return height;
}

- (void)onOpenContentAction:(UIButton *)btn{
    
    if (self.openContentBlock) {
        btn.selected = !btn.selected;
        self.cellModel.isOpen = btn.selected;
        self.openContentBlock(self.cellModel);
        [self layoutSubviewsWithModel:self.cellModel];
    }
}

#pragma mark - getter & setter
- (UILabel *)titleLabel{
    
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 16)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel{
    
    if (!_contentLabel) {
        
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.backgroundColor = [UIColor clearColor];
        _contentLabel.font = [UIFont systemFontOfSize:QSTextFontSize];
        _contentLabel.textColor = [UIColor blackColor];
        _contentLabel.myConstrainedWidth = SCREEN_WIDTH - 30;
        _contentLabel.myLineSpacing = QSTextLineSpacing;
    }
    return _contentLabel;
}


- (UIButton *)openContentBtn{
    
    if (!_openContentBtn) {
        _openContentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _openContentBtn.backgroundColor = [UIColor lightTextColor];
        _openContentBtn.titleLabel.font = [UIFont systemFontOfSize:18];
        
        [_openContentBtn setTitle:@"显示全文" forState:UIControlStateNormal];
        [_openContentBtn setTitle:@"收起全文" forState:UIControlStateSelected];
        [_openContentBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_openContentBtn addTarget:self action:@selector(onOpenContentAction:) forControlEvents:UIControlEventTouchUpInside];
        _openContentBtn.hidden = YES;
    }
    return _openContentBtn;
}


@end
