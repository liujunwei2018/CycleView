//
//  LJW_CycleView.m
//  轮播
//
//  Created by 刘君威 on 2019/5/6.
//  Copyright © 2019 liujunwei. All rights reserved.
//

#import "LJW_CycleView.h"

#pragma mark - 自定义cell

@interface CycleViewCell : UICollectionViewCell
@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation CycleViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

- (void)setupSubViews {
    self.imageView = [[UIImageView alloc] init];
    self.imageView.frame = self.bounds;
    self.imageView.userInteractionEnabled = YES;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:self.imageView];
}

@end

#pragma mark - 滚动视图(collectionView)

#define kViewWidth self.bounds.size.width
#define kViewHeight self.bounds.size.height
static NSString * const kCellID = @"kCellID";
static NSInteger const defaultCount = 3;

@interface LJW_CycleView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger currentPage;
// 定时器,自动滚播
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LJW_CycleView

- (void)dealloc {
    [self removeCycleTimer];
}

- (instancetype)initWithFrame:(CGRect)frame {
    if(self = [super initWithFrame:frame]) {
        [self setupSubViews];
    }
    return self;
}

#pragma mark setup

- (void)setupSubViews {
    self.backgroundColor = UIColor.whiteColor;
    [self addSubview:self.collectionView];
    
    [self addSubview:self.pageControl];
}

- (void)addCycleTimer {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(scrollCollectionView) userInfo:nil repeats:YES];
}

- (void)removeCycleTimer {
    [self.timer invalidate]; //从运行循环中移除
    self.timer = nil;
}

#pragma mark action

- (void)scrollCollectionView {
    CGFloat currentOffsetX = self.collectionView.contentOffset.x;
    CGFloat offsetX = kViewWidth + currentOffsetX;
    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
}

//- (void)pageControlValueChange:(UIPageControl *)pageControl {
//    NSLog(@"%d",(int)pageControl.currentPage);
//    CGFloat currentOffsetX = self.collectionView.contentOffset.x;
//    CGFloat offsetX = (pageControl.currentPage - self.currentPage) * kViewWidth + currentOffsetX;
//    [self.collectionView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
//    self.currentPage = pageControl.currentPage;
//}

#pragma mark UICollectionViewDelegate, UICollectionViewDataSource

// 点击事件
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.images) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(cycleView:didSelectItemAtIndex:)]) {
            [self.delegate cycleView:self didSelectItemAtIndex:(indexPath.item % self.images.count)];
        }
    }
  
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (self.images.count > 0) {
        // 实现无限轮播
        return self.images.count * 10000;
    }
    // 默认值: 3
    return defaultCount  * 10000;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CycleViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCellID forIndexPath:indexPath];
    
    // 设置默认图片
    if (self.placeholderImage && self.images.count == 0) {
        cell.imageView.image = self.placeholderImage;
    }
    
    // 有数据时设置图片
    if (self.images.count > 0) {
        // 取余数 获取数据
        cell.imageView.image = self.images[indexPath.item % self.images.count];
    }
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    // 获取滚动偏移量,
    // + scrollView.bounds.size.width *0.5 作用: 滚动超过屏幕一半宽度时 currentPage 就改变
    CGFloat offsetX = scrollView.contentOffset.x + scrollView.bounds.size.width *0.5;
    if (self.images.count > 0) {
        self.pageControl.currentPage = (NSInteger)(offsetX / kViewWidth) % self.images.count;
    } else {
        self.pageControl.currentPage = (NSInteger)(offsetX / kViewWidth) % defaultCount;
    }
    self.currentPage = self.pageControl.currentPage;
}

// 当用户拖动时取消定时滚播
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self removeCycleTimer];
}

// 当用户拖动结束开启定时滚播
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self addCycleTimer];
}

#pragma mark getter

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(kViewWidth, kViewHeight);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.backgroundColor = UIColor.whiteColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[CycleViewCell class] forCellWithReuseIdentifier:kCellID];
       
    }
    
    return _collectionView;
}

- (UIPageControl *)pageControl {
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(50, kViewHeight - 30, kViewWidth - 50 * 2, 20)];
        _pageControl.currentPage = 0;
        _pageControl.userInteractionEnabled = NO;
    }
    return _pageControl;
}

#pragma mark setter

- (void)setPlaceholderImage:(UIImage *)placeholderImage {
    _placeholderImage = placeholderImage;
    
    [_collectionView reloadData];
    self.pageControl.numberOfPages = defaultCount;
    [self removeCycleTimer];
    [self addCycleTimer];
}

- (void)setImages:(NSArray *)images {
    _images = images;
    
    [self.collectionView reloadData];
    self.pageControl.numberOfPages = images.count;
    [self removeCycleTimer];
    [self addCycleTimer];
}

@end
