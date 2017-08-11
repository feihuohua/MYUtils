### MYUtils
MYUtils项目中会记录日常常用的一些工具类和一些常用的demo等等。

本次新增功能：
* UILabel设置行间距、指定显示行数
* iconfont实战
* 使用UIImageView设置圆角
* UICollectionView实现轮播图

#### UILabel设置行间距、指定显示行数
* 在iOS中，有时候显示文本，需要设置文本的行间距、指定显示行数、文本内容超出显示行数，省略结尾部分的内容以……方式省略。这些都可以使用UILabel来是实现，前提是你扩展了UILabel这方面的特性。

#### iconfont实战

* 使用IconFont减小iOS应用体积。

#### 使用UIImageView设置圆角

* 使用UIImageView分类设置圆角

#### UICollectionView实现轮播图

* FXBannerCycleView是用UICollectionView实现的，使用的时候也特别简单，就跟使用UICollectionView一样的清爽。

![FXBannerCycleView.gif](http://upload-images.jianshu.io/upload_images/588630-ed997a60d2dbc4a9.gif?imageMogr2/auto-orient/strip)

* 首先，FXBannerCyclePageControlPosition是确定pageControl的位置，默认值是中间位置。

```
FXBannerCyclePageControlPositionCenter
FXBannerCyclePageControlPositionLeft
FXBannerCyclePageControlPositionRight
```

* 然后，FXBannerCycleView的代理方法

```
/**
*  代理方法取轮播总数（参考UITableView或UICollectionView）
*
*  @param cycleView 轮播视图
*
*  @return 轮播总数
*/
- (NSInteger)numberOfRowsInCycleView:(FXBannerCycleView *)cycleView;

/**
*  代理方法取轮播子视图（参考UITableView或UICollectionView）
*
*  @param cycleView 轮播视图
*  @param row       子视图索引
*
*  @return 轮播子视图（继承自系统UICollectionViewCell）
*/
- (UICollectionViewCell *)cycleView:(FXBannerCycleView *)cycleView cellForItemAtRow:(NSInteger)row;

/**
*  代理方法取子视图大小
*
*  @param cycleView 轮播视图
*  @param row       子视图索引
*
*  @return 子视图大小
*/
- (CGSize)cycleView:(FXBannerCycleView *)cycleView sizeForItemAtRow:(NSInteger)row;

/**
*  代理方法视图滚动到子视图时回调
*
*  @param cycleView 滚动视图
*  @param row       子视图索引
*/
- (void)cycleView:(FXBannerCycleView *)cycleView didScrollToItemAtRow:(NSInteger)row;

/**
*  代理方法子视图点击时回调
*
*  @param cycleView 滚动视图
*  @param row       子视图索引
*/
- (void)cycleView:(FXBannerCycleView *)cycleView didSelectItemAtRow:(NSInteger)row;

```

* 最后，设置定时器的属性

```
/** 是否循环(default = YES) */
@property (nonatomic, assign) BOOL cycleEnabled;
/** 自动滚动间隔(default = 0) */
@property (nonatomic, assign) CGFloat timeInterval;
```

