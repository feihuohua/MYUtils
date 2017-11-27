//
//  MYIGLDemoViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/4.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYIGLDemoViewController.h"
#import "IGLDropDownMenu.h"
#import "UtilsMacros.h"
#import <Masonry.h>

@interface MYIGLDemoViewController ()<IGLDropDownMenuDelegate>

@property (nonatomic, strong) IGLDropDownMenu *dropDownMenu;
@property (nonatomic, strong) UILabel *textLabel;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation MYIGLDemoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.segmentedControl = [[UISegmentedControl alloc]
                             initWithItems:@[@"Demo1",@"Demo2",@"Demo3",@"Demo4",@"Demo5",@"Demo6",]];
    [self.segmentedControl setFrame:CGRectMake((self.view.bounds.size.width - 300)/2, 84, 300, 30)];
    [self.segmentedControl addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setSelectedSegmentIndex:0];
    [self.view addSubview:self.segmentedControl];
    
    NSArray *dataArray = @[
                           @{@"image":@"sun",@"title":@"Sun"},
                           @{@"image":@"clouds",@"title":@"Clouds"},
                           @{@"image":@"snow",@"title":@"Snow"},
                           @{@"image":@"rain",@"title":@"Rain"},
                           @{@"image":@"windy",@"title":@"Windy"},
                           ];
    NSMutableArray *dropdownItems = [[NSMutableArray alloc] init];
    for (int i = 0; i < dataArray.count; i++) {
        NSDictionary *dict = dataArray[i];
        
        IGLDropDownItem *item = [[IGLDropDownItem alloc] init];
        [item setIconImage:[UIImage imageNamed:dict[@"image"]]];
        [item setText:dict[@"title"]];
        [dropdownItems addObject:item];
    }
    
    self.dropDownMenu = [[IGLDropDownMenu alloc] init];
    self.dropDownMenu.menuText = @"Choose Weather";
    self.dropDownMenu.dropDownItems = dropdownItems;
    self.dropDownMenu.paddingLeft = 15;
    self.dropDownMenu.delegate = self;
    [self.dropDownMenu setFrame:CGRectMake((self.view.bounds.size.width - 200)/2, CGRectGetMaxY(self.segmentedControl.frame) + 20, 200, 45)];
    
    // You can use block instead of delegate if you want
    /*
     __weak typeof(self) weakSelf = self;
     [self.dropDownMenu addSelectedItemChangeBlock:^(NSInteger selectedIndex) {
     __strong typeof(self) strongSelf = weakSelf;
     IGLDropDownItem *item = strongSelf.dropDownMenu.dropDownItems[selectedIndex];
     strongSelf.textLabel.text = [NSString stringWithFormat:@"Selected: %@", item.text];
     }];
     */
    
    [self setUpParamsForDemo1];
    
    [self.dropDownMenu reloadView];
    
    [self.view addSubview:self.dropDownMenu];
    
    self.textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height - 50 - 20, self.view.bounds.size.width, 50)];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.textLabel];
    self.textLabel.text = @"No Selected.";
}

- (void)segmentChanged:(UISegmentedControl*)segment
{
    NSInteger index = segment.selectedSegmentIndex;
    [self.dropDownMenu resetParams];
    switch (index) {
        case 0:
            // Demo 1
            [self setUpParamsForDemo1];
            break;
        case 1:
            // Demo 2
            [self setUpParamsForDemo2];
            break;
        case 2:
            // Demo 3
            [self setUpParamsForDemo3];
            break;
        case 3:
            // Demo 4
            [self setUpParamsForDemo4];
            break;
        case 4:
            // Demo 5
            [self setUpParamsForDemo5];
            break;
        case 5:
            // Demo 6
            [self setUpParamsForDemo6];
            break;
        default:
            break;
    }
    [self.dropDownMenu reloadView];
    self.textLabel.text = @"No Selected.";
}

- (void)setUpParamsForDemo1
{
    self.dropDownMenu.type = IGLDropDownMenuTypeStack;
    self.dropDownMenu.gutterY = 5;
}

- (void)setUpParamsForDemo2
{
    self.dropDownMenu.type = IGLDropDownMenuTypeStack;
    self.dropDownMenu.gutterY = 5;
    self.dropDownMenu.itemAnimationDelay = 0.1;
    self.dropDownMenu.rotate = IGLDropDownMenuRotateRandom;
}

- (void)setUpParamsForDemo3
{
    self.dropDownMenu.type = IGLDropDownMenuTypeStack;
    self.dropDownMenu.gutterY = 5;
    self.dropDownMenu.itemAnimationDelay = 0.04;
    self.dropDownMenu.rotate = IGLDropDownMenuRotateLeft;
}

- (void)setUpParamsForDemo4
{
    self.dropDownMenu.type = IGLDropDownMenuTypeStack;
    self.dropDownMenu.flipWhenToggleView = YES;
}

- (void)setUpParamsForDemo5
{
    self.dropDownMenu.gutterY = 5;
    self.dropDownMenu.type = IGLDropDownMenuTypeSlidingInBoth;
}

- (void)setUpParamsForDemo6
{
    self.dropDownMenu.gutterY = 5;
    self.dropDownMenu.type = IGLDropDownMenuTypeSlidingInBoth;
    self.dropDownMenu.itemAnimationDelay = 0.1;
}

#pragma mark - IGLDropDownMenuDelegate

- (void)dropDownMenu:(IGLDropDownMenu *)dropDownMenu selectedItemAtIndex:(NSInteger)index
{
    IGLDropDownItem *item = dropDownMenu.dropDownItems[index];
    self.textLabel.text = [NSString stringWithFormat:@"Selected: %@", item.text];
}

@end
