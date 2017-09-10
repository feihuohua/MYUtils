//
//  CIImage+Extension.h
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/27.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <CoreImage/CoreImage.h>
#import <UIKit/UIKit.h>

@interface CIImage (Extension)

/*
 * 根据CIImage生成指定大小的UIImage
 *
 * @param size 图片宽度
 */
- (UIImage *)createNonInterpolatedWithSize:(CGFloat)size;

@end
