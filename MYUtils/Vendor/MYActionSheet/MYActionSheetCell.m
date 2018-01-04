//
//  MYActionSheetCell.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/9/19.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYActionSheetCell.h"
#import "Masonry.h"

@interface MYActionSheetCell ()

/**
 *  Highlighted View.
 */
@property (nonatomic, weak) UIView *highlightedView;

@end

@implementation MYActionSheetCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        [self setupSubView];
    }
    return self;
}

- (void)setupSubView {
    
    [self.highlightedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, 10.0f, 0, 10.0f));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.equalTo(@0.5f);
    }];
}

- (void)setCellSeparatorColor:(UIColor *)cellSeparatorColor {
    _cellSeparatorColor = cellSeparatorColor;
    
    self.highlightedView.backgroundColor = cellSeparatorColor;
    self.lineView.backgroundColor = cellSeparatorColor;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated {
    if (self.tag == MY_ACTION_SHEET_CELL_HIDDE_LINE_TAG) {
        self.lineView.hidden = YES;
    } else {
        self.lineView.hidden = highlighted;
    }
    
    self.highlightedView.hidden = !highlighted;
}

- (UIView *)highlightedView {
    if (!_highlightedView) {
        UIView *highlightedView  = [[UIView alloc] init];
        highlightedView.backgroundColor = self.cellSeparatorColor;
        highlightedView.clipsToBounds   = YES;
        highlightedView.hidden          = YES;
        [self.contentView addSubview:highlightedView];
        _highlightedView = highlightedView;
    }
    return _highlightedView;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:titleLabel];
        _titleLabel = titleLabel;
    }
    return _titleLabel;
}

- (UIView *)lineView {
    if (!_lineView) {
        UIView *lineView  = [[UIView alloc] init];
        lineView.backgroundColor = self.cellSeparatorColor;
        lineView.contentMode   = UIViewContentModeBottom;
        lineView.clipsToBounds = YES;
        [self.contentView addSubview:lineView];
        _lineView = lineView;
    }
    return _lineView;
}

@end
