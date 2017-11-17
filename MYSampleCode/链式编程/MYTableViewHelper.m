//
//  MYTableViewHelper.m
//  MYSampleCode
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 MYSampleCode. All rights reserved.
//

#import "MYTableViewHelper.h"

@interface MYTableViewHelper ()

@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, strong) Class Cls;
@property (nonatomic, assign) NSInteger sections;
@property (nonatomic, assign) NSInteger currentSection;
@property (nonatomic, strong) NSMutableArray *sectionRows;
@property (nonatomic, strong) NSArray *models;

@end

@implementation MYTableViewHelper

- (MYTableViewHelper *(^)(UITableView *, Class))bindTb {
    return ^(UITableView *tableView, Class Cls) {
        tableView.dataSource = self;
        self.tableView = tableView;
        self.Cls = Cls;
        NSCAssert([Cls isSubclassOfClass:[UITableViewCell class]], @"%@必须是UITableViewCell或者它的子类", Cls);
        [tableView registerClass:Cls forCellReuseIdentifier:NSStringFromClass(Cls)] ;
        
        return self;
    };
}


- (NSMutableArray *)sectionRows {
    if (_sectionRows == nil) {
        _sectionRows = @[].mutableCopy;
    }
    return _sectionRows;
}

- (MYTableViewHelper *(^)(NSInteger))totalSection {
    return ^(NSInteger sections){
        self.sections = sections;
        return self;
    };
}

- (MYTableViewHelper *(^)(NSInteger))section {
    return ^(NSInteger section){
        NSCAssert(section <= self.sections-1, @"section越界");
        self.currentSection = section;
        return self;
    };
}

- (MYTableViewHelper *(^)(NSInteger))row {
    return ^(NSInteger rows){
        [self.sectionRows insertObject:[NSNumber numberWithInteger:rows] atIndex:self.currentSection];
        return self;
    };
}

- (MYTableViewHelper *(^)(NSArray *))configureCell {
    return ^(NSArray *models) {
        self.models = models;
        return self;
    };
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSInteger i = 0;
    for (NSNumber *num in self.sectionRows) {
        if (section == i) {
            return num.integerValue;
        }
        i++;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(self.Cls) forIndexPath:indexPath];
    cell.textLabel.text = self.models[indexPath.row];
    return cell;
}

- (void)dealloc {
    NSLog(@"==%@", NSStringFromSelector(_cmd));
}

@end
