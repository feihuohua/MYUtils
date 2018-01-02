//
//  MYVerticalWaterfallModel.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/2.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MYVerticalWaterfallModel : NSObject

/** 高度 */
@property (assign, nonatomic) CGFloat h;

/** 宽度 */
@property (assign, nonatomic) CGFloat w;

/** 价格 */
@property (nonatomic, copy) NSString *price;

/** 图标 */
@property (nonatomic, copy) NSString *img;

/** name */
@property (nonatomic, copy) NSString *name;

/** 宽度 */
@property (assign, nonatomic) CGFloat width;

/** 高度 */
@property (assign, nonatomic) CGFloat height;

/** image1 */
@property (nonatomic, copy) NSString *image1;

@end
