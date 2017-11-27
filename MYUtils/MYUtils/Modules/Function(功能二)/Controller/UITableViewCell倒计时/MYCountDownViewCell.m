//
//  MYCountDownViewCell.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYCountDownViewCell.h"
#import "MYCountDownModel.h"
#import "MYCountDownManager.h"

@implementation MYCountDownViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        
        // 监听通知
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(countDownNotification)
                                                     name:kMYCountDownNotification
                                                   object:nil];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

- (void)setCountDownModel:(MYCountDownModel *)countDownModel {
    _countDownModel = countDownModel;
    
    self.textLabel.text = countDownModel.title;
    // 手动刷新数据
    [self countDownNotification];
}

- (void)countDownNotification {
    
    NSInteger timeInterval;
    if (self.countDownModel.countDownSource) {
        timeInterval = [[MYCountDownManager manager] timeIntervalWithIdentifier:self.countDownModel.countDownSource];
    } else {
        timeInterval = [MYCountDownManager manager].timeInterval;
    }
    NSInteger countDown = self.countDownModel.count - timeInterval;
    /// 当倒计时到了进行回调
    if (countDown <= 0) {
        self.detailTextLabel.text = @"活动开始";
        // 回调给控制器
        if (self.finishBlock) {
            self.finishBlock(self.countDownModel);
        }
        return;
    }
    /// 重新赋值
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时%02zd:%02zd:%02zd", countDown/3600, (countDown/60)%60, countDown%60];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
