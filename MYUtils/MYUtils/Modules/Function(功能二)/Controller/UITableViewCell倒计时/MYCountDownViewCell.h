//
//  MYCountDownViewCell.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYCountDownModel;

typedef void(^MYCountDownFinishBlock)(MYCountDownModel *countDownModel);

@interface MYCountDownViewCell : UITableViewCell

@property (nonatomic, strong) MYCountDownModel *countDownModel;
@property (nonatomic, copy) MYCountDownFinishBlock finishBlock;

@end
