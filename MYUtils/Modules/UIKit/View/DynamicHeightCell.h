//
//  DynamicHeightCell.h
//  DynamicHeightCellLayoutDemo
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYFeedModel;

@interface DynamicHeightCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *textlabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

- (void)filleCellWithFeed:(MYFeedModel *)feedModel;

@end
