//
//  CaculatorMaker.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/16.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "CaculatorMaker.h"

@implementation CaculatorMaker

- (CaculatorMaker *(^)(int))add {
    return ^CaculatorMaker *(int value) {
        self.result += value;
        return self;
    };
}

- (CaculatorMaker *(^)(int))subtraction {
    return ^CaculatorMaker *(int value) {
        self.result -= value;
        return self;
    };
}

- (CaculatorMaker *(^)(int))muilt {
    return ^CaculatorMaker *(int value) {
        self.result *= value;
        return self;
    };
}

- (CaculatorMaker *(^)(int))divide {
    return ^CaculatorMaker *(int value) {
        self.result /= value;
        return self;
    };
}

@end
