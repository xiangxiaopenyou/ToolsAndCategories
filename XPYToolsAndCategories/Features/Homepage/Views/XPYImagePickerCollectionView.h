//
//  XPYImagePickerCollectionView.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/13.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

static CGFloat const kXPYImagePickerCollectionViewLineSpacing = 10;
static CGFloat const kXPYImagePickerCollectionViewInteritemSpacing = 10;
static CGFloat const kXPYImagePickerCollectionViewTopSpacing = 10;
static CGFloat const kXPYImagePickerCollectionViewBottomSpacing = 10;
static CGFloat const kXPYImagePickerCollectionViewLeftSpacing = 10;
static CGFloat const kXPYImagePickerCollectionViewRightSpacing = 10;

#define kXPYImagePickerCollectionViewItemWidth (CGRectGetWidth([UIScreen mainScreen].bounds) - 20 - 2 * kXPYImagePickerCollectionViewInteritemSpacing) / 3.0
#define kXPYImagePickerCollectionViewItemHeight kXPYImagePickerCollectionViewItemWidth

@protocol XPYImagePickerCollectionViewDelegate <NSObject>

- (void)imagePickerCollectionViewDidClickAdd;

@end

@interface XPYImagePickerCollectionView : UICollectionView

@property (nonatomic, weak) id <XPYImagePickerCollectionViewDelegate> imagePickerDelegate;

- (void)setupData:(NSMutableArray *)images;

@end

NS_ASSUME_NONNULL_END
