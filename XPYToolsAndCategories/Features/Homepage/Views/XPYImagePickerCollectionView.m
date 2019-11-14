//
//  XPYImagePickerCollectionView.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/13.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYImagePickerCollectionView.h"
#import "XPYImagePickerCollectionViewCell.h"
#import "UIView+XPYSnapshotImage.h"

static NSString * const kXPYImagePickerCollectionViewCellIdentifier = @"XPYImagePickerCollectionViewCell";

@interface XPYImagePickerCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray *imagesArray;
@property (nonatomic, strong) UILongPressGestureRecognizer *pressGesture;
@property (nonatomic, strong) NSIndexPath *movingIndexPath;
@property (nonatomic, strong) UIImageView *movingImageView;

@property (nonatomic, assign) BOOL isTouchedAdd;

@end

@implementation XPYImagePickerCollectionView

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[XPYImagePickerCollectionViewCell class] forCellWithReuseIdentifier:kXPYImagePickerCollectionViewCellIdentifier];
        
        self.pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressGestureAction:)];
        self.pressGesture.minimumPressDuration = 0.3;
        [self addGestureRecognizer:self.pressGesture];
        
    }
    return self;
}

#pragma mark - Instance methods
- (void)setupData:(NSMutableArray *)images {
    self.imagesArray = [images mutableCopy];
    [self reloadData];
}

#pragma mark - Action
- (void)addImageAction {
    if (self.imagePickerDelegate && [self.imagePickerDelegate respondsToSelector:@selector(imagePickerCollectionViewDidClickAdd)]) {
        [self.imagePickerDelegate imagePickerCollectionViewDidClickAdd];
    }
}
- (void)pressGestureAction:(UILongPressGestureRecognizer *)press {
    CGPoint point = [press locationInView:self];
    switch (press.state) {
        case UIGestureRecognizerStateBegan: {
            //获取触摸点位置所在Cell的indexPath，可能为nil
            NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
            if (!indexPath) {
                return;
            }
            //触摸点在增加图片按钮
            if (indexPath.item >= self.imagesArray.count) {
                _isTouchedAdd = YES;
                return;
            }
            //保存开始触摸点的indexPath
            self.movingIndexPath = indexPath;
            //对触摸点所在Cell截图
            [self createSnapshotImage:point];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            NSIndexPath *indexPath = [self indexPathForItemAtPoint:point];
            if (_isTouchedAdd) {
                return;
            }
            //截图跟着手指移动
            self.movingImageView.center = point;
            //手指位置进入可以移动的Cell，更新数据、交换位置
            if (indexPath && ![indexPath isEqual:self.movingIndexPath]) {
                if (indexPath.item < self.imagesArray.count) {
                    
                    UIImage *image = self.imagesArray[self.movingIndexPath.item];
                    [self.imagesArray removeObjectAtIndex:self.movingIndexPath.item];
                    [self.imagesArray insertObject:image atIndex:indexPath.item];
                    
                    [self moveItemAtIndexPath:self.movingIndexPath toIndexPath:indexPath];
                    self.movingIndexPath = indexPath;
                }
            }
        }
            break;
        case UIGestureRecognizerStateEnded: {
            [self endDrag];
        }
            break;
            
        default: {
            [self endDrag];
        }
            break;
    }
}

#pragma mark - Private methods
- (void)createSnapshotImage:(CGPoint)touchPoint {
    XPYImagePickerCollectionViewCell *movingCell = (XPYImagePickerCollectionViewCell *)[self cellForItemAtIndexPath:self.movingIndexPath];
    UIImage *snapshotImage = [movingCell snapshotImage];
    self.movingImageView = [[UIImageView alloc] initWithImage:snapshotImage];
    [self addSubview:self.movingImageView];
    self.movingImageView.center = movingCell.center;
    movingCell.hidden = YES;
    [UIView animateWithDuration:0.2 animations:^{
        self.movingImageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
        self.movingImageView.alpha = 0.9;
    }];
}
//结束排序
- (void)endDrag {
    XPYImagePickerCollectionViewCell *cell = (XPYImagePickerCollectionViewCell *)[self cellForItemAtIndexPath:self.movingIndexPath];
    cell.hidden = NO;
    cell.alpha = 0;
    _isTouchedAdd = NO;
    [UIView animateWithDuration:0.2 animations:^{
        self.movingImageView.center = cell.center;
        self.movingImageView.alpha = 0;
        self.movingImageView.transform = CGAffineTransformIdentity;
        cell.alpha = 1;
    } completion:^(BOOL finished) {
        [self.movingImageView removeFromSuperview];
        self.movingImageView = nil;
        self.movingIndexPath = nil;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
    }];
    
    
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.imagesArray.count < 9 ? self.imagesArray.count + 1 : 9;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XPYImagePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXPYImagePickerCollectionViewCellIdentifier forIndexPath:indexPath];
    if (indexPath.item == self.imagesArray.count) {
        [cell setupImage:[UIImage imageNamed:@"add_image"]];
    } else {
        [cell setupImage:(UIImage *)self.imagesArray[indexPath.item]];
    }
    return cell;
}

#pragma mark - Collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.imagesArray.count) {
        [self addImageAction];
    }
}


#pragma mark - Collection view delegate flow layout
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return kXPYImagePickerCollectionViewLineSpacing;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return kXPYImagePickerCollectionViewInteritemSpacing;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(kXPYImagePickerCollectionViewTopSpacing, kXPYImagePickerCollectionViewLeftSpacing, kXPYImagePickerCollectionViewBottomSpacing, kXPYImagePickerCollectionViewRightSpacing);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(kXPYImagePickerCollectionViewItemWidth - 1, kXPYImagePickerCollectionViewItemHeight - 1);
}

@end
