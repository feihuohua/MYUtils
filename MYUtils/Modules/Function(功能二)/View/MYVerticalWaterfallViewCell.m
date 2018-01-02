//
//  MYVerticalWaterfallViewCell.m
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/2.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import "MYVerticalWaterfallViewCell.h"
#import "MYVerticalWaterfallModel.h"
#import <UIImageView+WebCache.h>

@interface MYVerticalWaterfallViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *shopImagV;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation MYVerticalWaterfallViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setVerticalWaterfallModel:(MYVerticalWaterfallModel *)verticalWaterfallModel {
    _verticalWaterfallModel = verticalWaterfallModel;
    
    self.priceLabel.text = verticalWaterfallModel.name;
    
    [self.shopImagV sd_setImageWithURL:[NSURL URLWithString:verticalWaterfallModel.image1] placeholderImage:[UIImage imageNamed:@"loading"]];
}

@end
