//
//  MYImageCornerRadiusViewCell.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/9.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYImageCornerRadiusViewCell : UITableViewCell

@property (nonatomic, copy) NSString *imageURL;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
