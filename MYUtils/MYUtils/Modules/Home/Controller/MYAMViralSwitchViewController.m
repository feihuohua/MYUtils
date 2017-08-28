//
//  MYAMViralSwitchViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/28.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYAMViralSwitchViewController.h"
#import "AMViralSwitch.h"

@interface MYAMViralSwitchViewController ()

@property (weak, nonatomic) IBOutlet AMViralSwitch *blueSwitch;
@property (weak, nonatomic) IBOutlet AMViralSwitch *greenSwitch;

@property (weak, nonatomic) IBOutlet UIView *greenView;
@property (weak, nonatomic) IBOutlet UILabel *blueLabel;
@property (weak, nonatomic) IBOutlet UIButton *infoButton;

@end

@implementation MYAMViralSwitchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.blueSwitch.completionOn = ^{
        NSLog(@"Animation On");
    };
    
    self.blueSwitch.completionOff = ^{
        NSLog(@"Animation Off");
    };
    
    self.blueSwitch.animationElementsOn =
    @[
      @{ AMElementView: self.blueLabel,
         AMElementKeyPath: @"textColor",
         AMElementToValue: [UIColor whiteColor] },
      @{ AMElementView: self.infoButton,
         AMElementKeyPath: @"tintColor",
         AMElementToValue: [UIColor whiteColor] }
      ];
    
    self.blueSwitch.animationElementsOff =
    @[
      @{ AMElementView: self.blueLabel,
         AMElementKeyPath: @"textColor",
         AMElementToValue: [UIColor blackColor] },
      @{ AMElementView: self.infoButton,
         AMElementKeyPath: @"tintColor",
         AMElementToValue: [UIColor blackColor] }
      ];
    
    self.blueSwitch.completionOn = ^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    };
    
    self.blueSwitch.completionOff = ^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    };
    
    self.greenSwitch.animationElementsOn = @[
                                             @{ AMElementView: self.greenView.layer,
                                                AMElementKeyPath: @"backgroundColor",
                                                AMElementFromValue: (id)[UIColor clearColor].CGColor,
                                                AMElementToValue: (id)[UIColor whiteColor].CGColor }
                                             ];
    
    self.greenSwitch.animationElementsOff = @[
                                              @{ AMElementView: self.greenView.layer,
                                                 AMElementKeyPath: @"backgroundColor",
                                                 AMElementFromValue: (id)[UIColor whiteColor].CGColor,
                                                 AMElementToValue: (id)[UIColor clearColor].CGColor }
                                              ];
}

@end
