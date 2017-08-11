//
//  MYBannerViewCell.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/11.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYBannerViewCell.h"
#import "UIColor+Extension.h"

@implementation MYBannerViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.backgroundColor = [UIColor randomColor];
    }
    return self;
}

@end
