//
//  MYAutomaticallyCollectionViewCellViewController.m
//  MYUtils
//
//  Created by sunjinshuai on 2017/11/17.
//  Copyright © 2017年 com.51fanxing. All rights reserved.
//

#import "MYAutomaticallyCollectionViewCellViewController.h"
#import "DynamicSizeCell.h"
#import "DynamicHeightCell.h"
#import "UICollectionView+ARDynamicCacheHeightLayoutCell.h"
#import "MYFeedModel.h"
#import "UIBarButtonItem+Extension.h"

@interface MYAutomaticallyCollectionViewCellViewController () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL onlyImage;
@property (nonatomic, strong) NSMutableArray *feedArray;
@property (nonatomic, strong) UICollectionViewFlowLayout *flowLayout;

@end

@implementation MYAutomaticallyCollectionViewCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"动态Cell";
    [self.view addSubview:self.collectionView];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"DynamicHeightCell" bundle:nil] forCellWithReuseIdentifier:@"DynamicHeightCell"];
    [self.collectionView registerNib:[UINib nibWithNibName:@"DynamicSizeCell" bundle:nil] forCellWithReuseIdentifier:@"DynamicSizeCell"];

    NSArray *titles = @[@"AugustRush",
                        @"Dynamic Cell",
                        @"AutoLayout"];
    
    NSArray *contents = @[@"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urnaet arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. \n\nInteger aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus.\n\n\n Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor.\n Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrumLorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum  ***This Is The End***",
                          @"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Curabitur sed tortor. Integer aliquam adipiscing lacus. Ut nec urna et arcu imperdiet ullamcorper. Duis at lacus. Quisque purus sapien, gravida non, sollicitudin a, malesuada id, erat. Etiam vestibulum massa rutrum",
                          @"I'm August rush , he's a boy in a Moivie"];
    
    NSArray *images = @[[UIImage imageNamed:@"1.jpg"],
                        [UIImage imageNamed:@"2.jpg"],
                        [UIImage imageNamed:@"3.jpg"],
                        [UIImage imageNamed:@"Jiker.png"]];

    for (int i = 0; i < 20; i++) {
        MYFeedModel *feed = [[MYFeedModel alloc] init];
        feed.title = titles[arc4random()%3];
        feed.content = contents[arc4random()%3];
        feed.image = images[arc4random()%4];
        
        [self.feedArray addObject:feed];
    }
    
    NSMutableArray *rightBarButtonItems = [NSMutableArray array];
    
    UIBarButtonItem *shareButton = [UIBarButtonItem barButtonItemWithTarget:self
                                                                     action:@selector(addFeed)
                                                                      title:@"Add"
                                                              selectedTitle:@"Add"];
    
    [rightBarButtonItems addObject:shareButton];
    
    UIBarButtonItem *blankItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    blankItem.width = 10.0f;
    [rightBarButtonItems addObject:blankItem];
    
    UIBarButtonItem *collectButton = [UIBarButtonItem barButtonItemWithTarget:self
                                                                       action:@selector(changeLayoutDirection)
                                                                        title:@"OnlyImage"
                                                                selectedTitle:@"OnlyImage"];
    [rightBarButtonItems addObject:collectButton];
    
    self.navigationItem.rightBarButtonItems = rightBarButtonItems;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.feedArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.onlyImage) {
        DynamicSizeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DynamicSizeCell" forIndexPath:indexPath];
        MYFeedModel *feed = self.feedArray[indexPath.row];
        [cell filleCellWithFeed:feed];
        return cell;
    } else {
        DynamicHeightCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DynamicHeightCell" forIndexPath:indexPath];
        MYFeedModel *feed = self.feedArray[indexPath.row];
        [cell filleCellWithFeed:feed];
        return cell;
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    MYFeedModel *feed = self.feedArray[indexPath.row];
    if (self.onlyImage) {
        return [collectionView ar_sizeForCellWithIdentifier:@"DynamicSizeCell"
                                                  indexPath:indexPath
                                              configuration:^(__kindof UICollectionViewCell * cell) {
                                                  [cell filleCellWithFeed:feed];
                                              }];
        
    } else {
        //get screen width & minus 20 points
        CGFloat width = [[UIScreen mainScreen] bounds].size.width - 20;
        return [collectionView ar_sizeForCellWithIdentifier:@"DynamicHeightCell"
                                                  indexPath:indexPath
                                                 fixedWidth:width configuration:^(id cell) {
                                                     [cell filleCellWithFeed:feed];
                                                 }];
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView performBatchUpdates:^{
        [self.feedArray exchangeObjectAtIndex:indexPath.row withObjectAtIndex:0];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    } completion:^(BOOL finished) {
    }];
}

- (void)addFeed {
    MYFeedModel *feed = [[MYFeedModel alloc] init];
    feed.title = @"Dynamic Cell";
    feed.content = @"This just use to test text, what are they funcking talking. let us to see your baby.";
    
    NSArray *images = @[[UIImage imageNamed:@"1.jpg"],
                        [UIImage imageNamed:@"2.jpg"],
                        [UIImage imageNamed:@"3.jpg"],
                        [UIImage imageNamed:@"Jiker.png"]];
    feed.image = images[arc4random()%4];
    
    [self.feedArray addObject:feed];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.feedArray.count - 1 inSection:0];
    [self.collectionView performBatchUpdates:^{
        [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }];
}

- (void)changeLayoutDirection {
    [self.flowLayout invalidateLayout];
    self.onlyImage = !self.onlyImage;
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        self.flowLayout = layout;
        layout.minimumLineSpacing = 10.0f;
        layout.minimumInteritemSpacing = 10.0f;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (NSMutableArray *)feedArray {
    if (!_feedArray) {
        _feedArray = @[].mutableCopy;
    }
    return _feedArray;
}

@end
