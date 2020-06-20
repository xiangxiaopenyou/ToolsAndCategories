//
//  XPYEnlargeViewManager.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/6/19.
//  Copyright © 2020 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYEnlargeViewManager : UIView

+ (instancetype)sharedManager;

/// 显示半透明背景和开始位置图片
/// @param image 图片
/// @param frame 图片位置
- (void)showTranslucentBackgroundWithOriginImage:(UIImage *)image imageFrame:(CGRect)frame;

/// 根据不透明度更新背景颜色
/// @param alpha 不透明度
- (void)updateTranslucentBackgroundWithAlpha:(CGFloat)alpha;

/// 原始图放大
- (void)enlargeImage;

/// 隐藏大图
- (void)dismiss;

/// 根据手指滑动更新大图位置
/// @param changedY 手指滑动距离
- (void)updateLargeImageOriginY:(CGFloat)changedY;

/// 是否已经显示半透明背景
@property (nonatomic, assign, readonly) BOOL isShowingTranslucentBackground;

/// 是否已经显示大图
@property (nonatomic, assign, readonly) BOOL isShowingLargeImage;

/// 是否已经显示菜单(点赞、保存图片等操作)
@property (nonatomic, assign, readonly) BOOL isShowingMenu;

@end

NS_ASSUME_NONNULL_END
