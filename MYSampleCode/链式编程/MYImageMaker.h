//
//  MYImageMaker.h
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MYImageMaker;

/// API 的入口, 从这里开始进行 chaining 式的 image making
extern MYImageMaker* _Nonnull nvm_beginImage(CGSize imageSize);

@interface MYImageMaker : NSObject

/// image fill color
- (MYImageMaker* _Nonnull (^_Nonnull)(UIColor* _Nonnull imageFillColor))fillColor;
/// image border color
- (MYImageMaker* _Nonnull (^_Nonnull)(UIColor* _Nonnull imageBorderColor))borderColor;
/// border 的 width, 默认 1 px, 仅当设置了 border color 才有效果
- (MYImageMaker* _Nonnull (^_Nonnull)(CGFloat imageBorderWidth))borderWidth;
/// corner radius
- (MYImageMaker* _Nonnull (^_Nonnull)(CGFloat imageCornerRadius))cornerRadius;
/// 透明度, 范围 0 - 1, 会应用在整个 image 上
- (MYImageMaker* _Nonnull (^_Nonnull)(CGFloat opacity))opacity;

/// 生成 image 返回
- (nonnull UIImage *)make;

- (nonnull instancetype)init NS_UNAVAILABLE;

@end
