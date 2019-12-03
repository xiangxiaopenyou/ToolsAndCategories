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

#import <Photos/Photos.h>

static NSString * const kXPYImagePickerCollectionViewCellIdentifier = @"XPYImagePickerCollectionViewCell";

@interface XPYImagePickerCollectionView () <UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) NSMutableArray <UIImage *> *photosArray;
@property (nonatomic, strong) NSMutableArray <PHAsset *> *assetsArray;
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
        
        //添加长按拖动手势
        self.pressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressGestureAction:)];
        self.pressGesture.minimumPressDuration = 0.3;
        [self addGestureRecognizer:self.pressGesture];
        
    }
    return self;
}

#pragma mark - Instance methods
- (void)setupData:(NSMutableArray *)photos assets:(NSMutableArray *)assets {
    self.photosArray = [photos mutableCopy];
    self.assetsArray = [assets mutableCopy];
    [self reloadData];
}

#pragma mark - Actions
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
            if (indexPath.item >= self.photosArray.count) {
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
                //移动到添加图片位置时不需要交换位置
                if (indexPath.item < self.photosArray.count) {
                    
                    UIImage *image = self.photosArray[self.movingIndexPath.item];
                    [self.photosArray removeObjectAtIndex:self.movingIndexPath.item];
                    [self.photosArray insertObject:image atIndex:indexPath.item];
                    
                    PHAsset *asset = self.assetsArray[self.movingIndexPath.item];
                    [self.assetsArray removeObjectAtIndex:self.movingIndexPath.item];
                    [self.assetsArray insertObject:asset atIndex:indexPath.item];
                    
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
    UIImage *snapshotImage = [movingCell.pickedImageView snapshotImage];
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
            if (self.imagePickerDelegate && [self.imagePickerDelegate respondsToSelector:@selector(imagePickerCollectionView:didChangePhotosArray:assetsArray:)]) {
                [self.imagePickerDelegate imagePickerCollectionView:self didChangePhotosArray:self.photosArray assetsArray:self.assetsArray];
            }
            [self reloadData];
        });
    }];
}

#pragma mark - Collection view data source
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.photosArray.count < 9 ? self.photosArray.count + 1 : 9;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XPYImagePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kXPYImagePickerCollectionViewCellIdentifier forIndexPath:indexPath];
    if (indexPath.item == self.photosArray.count) { //最后一项是添加图片
        [cell setupImage:[UIImage imageNamed:@"add_image"] isAddItem:YES];
    } else {
        [cell setupImage:(UIImage *)self.photosArray[indexPath.item] isAddItem:NO];
    }
    cell.deleteHandler = ^{
        [self performBatchUpdates:^{
            //移除数据
            [self.photosArray removeObjectAtIndex:indexPath.item];
            [self.assetsArray removeObjectAtIndex:indexPath.item];
            [self deleteItemsAtIndexPaths:@[indexPath]];
        } completion:^(BOOL finished) {
            [self reloadData];
        }];
        
        if (self.imagePickerDelegate && [self.imagePickerDelegate respondsToSelector:@selector(imagePickerCollectionView:didDeletePhotoAtItem:)]) {
            [self.imagePickerDelegate imagePickerCollectionView:self didDeletePhotoAtItem:indexPath.item];
        }
    };
    return cell;
}

#pragma mark - Collection view delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == self.photosArray.count) { //点击添加图片
        if (self.imagePickerDelegate && [self.imagePickerDelegate respondsToSelector:@selector(imagePickerCollectionViewDidClickAdd)]) {
            [self.imagePickerDelegate imagePickerCollectionViewDidClickAdd];
        }
    } else {                                        //点击选中的图片
        if (self.imagePickerDelegate && [self.imagePickerDelegate respondsToSelector:@selector(imagePickerCollectionView:didSelectItem:)]) {
            [self.imagePickerDelegate imagePickerCollectionView:self didSelectItem:indexPath.item];
        }
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
