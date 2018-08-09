//
//  MYShowTextViewCell.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYShowTextViewCell.h"
#import "MYShowTextCellModel.h"
#import <UILabel+LimitLines.h>
#import "NSString+Size.h"

#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH  CGRectGetWidth([[UIScreen mainScreen] bounds])
#define QSTextLineSpacing 5
#define QSTextFontSize 15

@interface MYShowTextViewCell ()

@property (nonatomic, strong) MYShowTextCellModel *cellModel;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *openContentButton;

@end

@implementation MYShowTextViewCell

+ (CGFloat)cellHeightWithModel:(MYShowTextCellModel *)model {
    BOOL isLimitedToLines;
    CGSize textSize = [model.content textSizeWithFont:[UIFont systemFontOfSize:QSTextFontSize] numberOfLines:model.contentLines lineSpacing:QSTextLineSpacing constrainedWidth:SCREEN_WIDTH - 30 isLimitedToLines:&isLimitedToLines];
    
    CGFloat height = textSize.height + 54 + 25;
    if (!isLimitedToLines && (model.contentLines != 0)) {
        height -= 25;
    }
    return height;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentLabel];
        [self.contentView addSubview:self.openContentButton];
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
        self.openContentButton.hidden = YES;
    } else {
        self.openContentButton.hidden = NO;
        self.openContentButton.selected = self.cellModel.isOpen;
    }
    
    if (!self.openContentButton.hidden) {
        self.openContentButton.frame = CGRectMake(15, CGRectGetMaxY(_contentLabel.frame) + 5, 80, 20);
    }
}

- (void)onOpenContentAction:(UIButton *)sender {
    if (self.openContentBlock) {
        sender.selected = !sender.selected;
        self.cellModel.isOpen = sender.selected;
        self.openContentBlock(self.cellModel);
        [self layoutSubviewsWithModel:self.cellModel];
    }
}

#pragma mark - getter & setter
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, SCREEN_WIDTH - 30, 16)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textColor = [UIColor grayColor];
    }
    return _titleLabel;
}

- (UILabel *)contentLabel {
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

- (UIButton *)openContentButton {
    if (!_openContentButton) {
        _openContentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _openContentButton.backgroundColor = [UIColor lightTextColor];
        _openContentButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_openContentButton setTitle:@"显示全文" forState:UIControlStateNormal];
        [_openContentButton setTitle:@"收起全文" forState:UIControlStateSelected];
        [_openContentButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [_openContentButton addTarget:self action:@selector(onOpenContentAction:) forControlEvents:UIControlEventTouchUpInside];
        _openContentButton.hidden = YES;
    }
    return _openContentButton;
}

@end
