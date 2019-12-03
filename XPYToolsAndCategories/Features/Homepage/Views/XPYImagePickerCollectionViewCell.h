//
//  XPYImagePickerCollectionViewCell.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/13.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYImagePickerCollectionViewCell : UICollectionViewCell

/// 主图片控件
@property (nonatomic, strong) UIImageView *pickedImageView;

/// 删除图片闭包
@property (nonatomic, copy) void (^deleteHandler)(void);

/// 设置图片
/// @param image 图片对象
/// @param isAdd 是否是最后一个添加按钮
- (void)setupImage:(UIImage *)image isAddItem:(BOOL)isAdd;

@end

NS_ASSUME_NONNULL_END
