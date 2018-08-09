//
//  MYImageCornerRadiusViewCell.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/9.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYImageCornerRadiusViewCell.h"
#import "UtilsMacros.h"
#import <MYKit.h>
#import <Masonry.h>
#import <UIImageView+WebCache.h>

@interface MYImageCornerRadiusViewCell ()

@property (nonatomic, strong) UIImageView *originImageView;

@end

@implementation MYImageCornerRadiusViewCell

static NSString *identifier = @"MYImageCornerRadiusViewCell";

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    MYImageCornerRadiusViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[MYImageCornerRadiusViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {

    weakSelf(weakSelf)
    [self.originImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.centerY.equalTo(weakSelf.contentView.mas_centerY);
        make.right.equalTo(weakSelf.contentView).offset(-15);
    }];
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    
    [self.originImageView sd_setImageWithURL:[NSURL URLWithString:imageURL]
                            placeholderImage:[UIImage createImageWithColor:[UIColor lightGrayColor]]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIImageView *)originImageView {
    if (!_originImageView) {
        _originImageView = [[UIImageView alloc] initWithRoundingRectImageView];
        _originImageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:_originImageView];
    }
    return _originImageView;
}

@end
