//
//  MYActionSheetCell.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/9/19.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MY_ACTION_SHEET_CELL_NO_HIDDE_LINE_TAG  100
#define MY_ACTION_SHEET_CELL_HIDDE_LINE_TAG     101

NS_ASSUME_NONNULL_BEGIN

@interface MYActionSheetCell : UITableViewCell

/**
 Title label.
 */
@property (nonatomic, weak) UILabel *titleLabel;

/**
 Line.
 */
@property (nonatomic, weak) UIView *lineView;

/**
 Cell's separator color.
 */
@property (nonatomic, strong) UIColor *cellSeparatorColor;

@end

NS_ASSUME_NONNULL_END
