//
//  DynamicHeightCell.m
//  DynamicHeightCellLayoutDemo
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "DynamicHeightCell.h"
#import "MYFeedModel.h"

@implementation DynamicHeightCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    //minus 20 pixel is cell's width, cell's width minus 16 pixel is contentLabel's width
    self.contentLabel.preferredMaxLayoutWidth = [UIScreen mainScreen].bounds.size.width - 20 - 16;
}

- (void)filleCellWithFeed:(MYFeedModel *)feedModel {
    self.textlabel.text = feedModel.title;
    self.imageView.image = feedModel.image;
    self.contentLabel.text = feedModel.content;
}


@end
