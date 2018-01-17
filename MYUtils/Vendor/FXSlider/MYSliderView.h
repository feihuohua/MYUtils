//
//  MYSliderView.h
//  MYUtils
//
//  Created by sunjinshuai on 2018/1/17.
//  Copyright © 2018年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kBorderWidth 1.0 // size of border under the slider
#define kViewCornerRadius 5.0 // view corners radius
#define kAnimationSpeed 0.1 // speed when slider change position on tap

@class MYSliderView;

@protocol MYSliderViewDelegate <NSObject>

@optional

// calls when user is swiping slider
- (void)sliderValueChanged:(MYSliderView *)sender;

// calls when user touchUpInside or toucUpOutside slider
- (void)sliderValueChangeEnded:(MYSliderView *)sender;

@end

@interface MYSliderView : UIControl

@property (nonatomic, weak) id <MYSliderViewDelegate> delegate;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) float value;

- (instancetype)initWithFrame:(CGRect)frame
               handleWith:(CGFloat)handleWidth
              handleImage:(UIImage *)handleImage;

- (void)setBackgroundColor:(UIColor *)backgroundColor
           foregroundColor:(UIColor *)foregroundColor
               handleColor:(UIColor *)handleColor
               borderColor:(UIColor *)borderColor;

- (void)setValue:(float)value
      animation:(BOOL)animation
     completion:(void (^)(BOOL finished))completion;

@end
