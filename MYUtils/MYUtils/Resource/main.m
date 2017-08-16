//
//  main.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/8/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Parent.h"
#import "Child.h"

int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
//    }
    
    Child *child = [[Child alloc] init];
    
    NSLog(@"%@",child);
    
}
