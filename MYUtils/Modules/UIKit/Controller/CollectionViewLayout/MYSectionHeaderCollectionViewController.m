//
//  MYSectionHeaderCollectionViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/12/7.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYSectionHeaderCollectionViewController.h"
#import "MYSectionHeaderCollectionViewLayout.h"

@interface MYSectionHeaderCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *sectionColor;

@end

@implementation MYSectionHeaderCollectionViewController

static NSString * const cellIndentifier = @"cellIndentifier";
static NSString * const sectionIndentifier = @"sectionHeaderIndentifier";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setupUI];
    
    self.sectionColor  = @[[UIColor redColor],
                           [UIColor orangeColor],
                           [UIColor greenColor],
                           [UIColor yellowColor],
                           [UIColor grayColor],
                           [UIColor blueColor],
                           [UIColor purpleColor]];
}

- (void)setupUI {
    
    MYSectionHeaderCollectionViewLayout *layout = [[MYSectionHeaderCollectionViewLayout alloc] init];
    layout.minimumInteritemSpacing = 10.f;
    layout.minimumLineSpacing = 10.f;
    CGFloat itemWidth = (([UIScreen mainScreen].bounds.size.width - 20) - 6 * 10) / 5.f;
    layout.itemSize = CGSizeMake(itemWidth, itemWidth);
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, self.view.bounds.size.width, self.view.bounds.size.height) collectionViewLayout:layout];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellIndentifier];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionIndentifier];
    [self.view addSubview:self.collectionView];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIndentifier forIndexPath:indexPath];
    NSInteger index = MIN(6, indexPath.row % 20);
    cell.backgroundColor = self.sectionColor[index];;
    return cell;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 30;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 37;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    return CGSizeMake([UIScreen mainScreen].bounds.size.width - 20, 60);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        UICollectionReusableView *sectionHeaderView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:sectionIndentifier forIndexPath:indexPath];
        
        NSInteger index = MIN(6, indexPath.section % 20);
        sectionHeaderView.backgroundColor = self.sectionColor[index];
        return sectionHeaderView;
    }
    return nil;
}

- (void)dealloc {
    
}

@end
