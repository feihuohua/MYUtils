//
//  MYShowTextViewCell.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYShowTextCellModel;

typedef void(^ShowTextOpenContentBlock) (MYShowTextCellModel *cellModel);

@interface MYShowTextViewCell : UITableViewCell

@property (nonatomic, copy) ShowTextOpenContentBlock openContentBlock;

- (void)layoutSubviewsWithModel:(MYShowTextCellModel *)model;

+ (CGFloat)cellHeightWithModel:(MYShowTextCellModel *)model;

@end
