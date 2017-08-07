//
//  MYShowTextCellModel.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYShowTextCellModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, assign) NSInteger contentLines;
@property (nonatomic, assign) BOOL isOpen;

- (instancetype)initWithContent:(NSString *)content
                   contentLines:(CGFloat)contentLines
                         isOpen:(BOOL)isOpen;

@end
