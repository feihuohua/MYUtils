//
//  MYCountDownViewCell.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYCountDownViewCell.h"
#import "MYCountDownModel.h"

@interface MYCountDownViewCell()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation MYCountDownViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self.link = [CADisplayLink displayLinkWithTarget:self selector:@selector(countDown)];
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void)setCountDownModel:(MYCountDownModel *)countDownModel {
    _countDownModel = countDownModel;
    self.textLabel.text = countDownModel.title;
}

- (void)countDown {
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = @"HH:mm:ss";
    self.detailTextLabel.text = [NSString stringWithFormat:@"倒计时%@", [dateformatter stringFromDate:[NSDate date]]];
}

@end
