//
//  XPYCategoryContentView.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/6.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYCategoryContentView.h"

static NSString * const kXPYCategoryContentCellIdentifier = @"XPYCategoryContentCell";

@interface XPYCategoryContentView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIViewController *parentViewController;

@property (nonatomic, copy) NSArray *viewControllersArray;
@end


@implementation XPYCategoryContentView

- (instancetype)initWithFrame:(CGRect)frame parentController:(UIViewController *)parentController controllers:(NSArray *)viewControllers {
    self = [super initWithFrame:frame];
    if (self) {
        self.parentViewController = parentController;
        self.viewControllersArray = [viewControllers copy];
        
        [self setupContentView];
    }
    return self;
}

#pragma mark - UI
- (void)setupContentView {
    
    for (UIViewController *childViewController in self.viewControllersArray) {
        [self.parentViewController addChildViewController:childViewController];
    }
    [self addSubview:self.collectionView];
}

#pragma mark - Instance methods
- (void)selectPageAtIndex:(NSInteger)index {
    CGFloat pageWidth = CGRectGetWidth(self.frame);
    [self.collectionView setContentOffset:CGPointMake(pageWidth * index, 0) animated:YES];
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.viewControllersArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXPYCategoryContentCellIdentifier forIndexPath:indexPath];
    UIViewController *controller = self.viewControllersArray[indexPath.item];
    controller.view.frame = cell.contentView.frame;
    [cell.contentView addSubview:controller.view];
    return cell;
}

#pragma mark - Scroll view delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = floor(scrollView.contentOffset.x) / floor(CGRectGetWidth(scrollView.frame));
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryContentView:didEndDecelerating:)]) {
        [self.delegate categoryContentView:self didEndDecelerating:index];
    }
}

#pragma mark - Getters
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = self.frame.size;
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:flowLayout];
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        _collectionView.bounces = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:kXPYCategoryContentCellIdentifier];
    }
    return _collectionView;
}


@end
