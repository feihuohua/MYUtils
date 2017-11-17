//
//  DynamicSizeCell.m
//  DynamicHeightCellLayoutDemo
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "DynamicSizeCell.h"
#import "MYFeedModel.h"

@implementation DynamicSizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)filleCellWithFeed:(MYFeedModel *)feedModel
{
    self.imageView.image = feedModel.image;
}

@end
