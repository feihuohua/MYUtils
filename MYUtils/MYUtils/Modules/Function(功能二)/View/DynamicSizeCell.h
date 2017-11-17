//
//  DynamicSizeCell.h
//  DynamicHeightCellLayoutDemo
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYFeedModel;

@interface DynamicSizeCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

- (void)filleCellWithFeed:(MYFeedModel *)feedModel;

@end
