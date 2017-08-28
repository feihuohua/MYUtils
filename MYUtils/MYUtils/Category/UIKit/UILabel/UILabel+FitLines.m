//
//  UILabel+FitLines.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "UILabel+FitLines.h"
#import "NSString+Size.h"
#import <objc/runtime.h>

@implementation UILabel (FitLines)

/**
 文本适应于指定的行数
 @return 文本是否被numberOfLines限制
 */
- (BOOL)my_adjustTextToFitLines:(NSInteger)numberOfLines {
    
    if (!self.text || self.text.length == 0) {
        return NO;
    }
    
    self.numberOfLines = numberOfLines;
    BOOL isLimitedToLines = NO;
    
    CGSize textSize = [self.text textSizeWithFont:self.font
                                    numberOfLines:self.numberOfLines
                                      lineSpacing:self.myLineSpacing
                                 constrainedWidth:self.myConstrainedWidth
                                 isLimitedToLines:&isLimitedToLines];
    
    //单行的情况
    if (fabs(textSize.height - self.font.lineHeight) < 0.00001f) {
        self.myLineSpacing = 0.0f;
    }
    
    //设置文字的属性
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
    
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:self.myLineSpacing];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;//结尾部分的内容以……方式省略
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [self.text length])];
    [attributedString addAttribute:NSForegroundColorAttributeName
                             value:self.textColor
                             range:NSMakeRange(0, [self.text length])];
    [attributedString addAttribute:NSFontAttributeName
                             value:self.font
                             range:NSMakeRange(0, [self.text length])];
    
    [self setAttributedText:attributedString];
    self.bounds = CGRectMake(0, 0, textSize.width, textSize.height);
    return isLimitedToLines;
}

#pragma MARK - setter & getter
/**
 行间距
 */
- (void)setMyLineSpacing:(CGFloat)myLineSpacing {
    
    objc_setAssociatedObject(self, @selector(myLineSpacing), [NSNumber numberWithFloat:myLineSpacing], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)myLineSpacing {
    
    return [objc_getAssociatedObject(self, @selector(myLineSpacing)) floatValue];
}

/**
 最大显示宽度
 */
- (void)setMyConstrainedWidth:(CGFloat)myConstrainedWidth {
    
    objc_setAssociatedObject(self, @selector(myConstrainedWidth), [NSNumber numberWithFloat:myConstrainedWidth], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)myConstrainedWidth {
    
    return [objc_getAssociatedObject(self, @selector(myConstrainedWidth)) floatValue];
}

- (void)scheduledTimerWithTimeInterval:(NSInteger)seconds
                        countDownTitle:(NSString *)title
                            completion:(void (^)(void))completion {
    // 倒计时时间
    __block NSInteger timeOut = seconds;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    // 每秒执行一次
    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), 1.0 * NSEC_PER_SEC, 0);
    dispatch_source_set_event_handler(_timer, ^{
        
        // 倒计时结束，关闭
        if (timeOut <= 0) {
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                self.userInteractionEnabled = YES;
                if (completion) {
                    completion();
                }
            });
        } else {
            int allTime = (int)seconds + 1;
            int seconds = timeOut % allTime;
            NSString *timeStr = [NSString stringWithFormat:@"%d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setText:[NSString stringWithFormat:@"%@%@",timeStr,title]];
                self.userInteractionEnabled = NO;
            });
            timeOut--;
        }
    });
    dispatch_resume(_timer);
}

@end
