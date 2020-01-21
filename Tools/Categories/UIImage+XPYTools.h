//
//  UIImage+XPYTools.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/20.
//  Copyright © 2020 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (XPYTools)

/// 根据颜色和大小获取纯色图片
/// @param color 颜色
/// @param size 大小
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

/// 根据颜色、大小和圆角大小获取图片
/// @param color 颜色
/// @param size 大小
/// @param radius 圆角大小
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
                     radius:(CGFloat)radius;

/// 根据颜色、大小、圆角大小和边框获取图片
/// @param color 颜色
/// @param size 大小
/// @param radius 圆角大小
/// @param borderWidth 边框宽度
/// @param borderColor 边框颜色
+ (UIImage *)imageWithColor:(UIColor *)color
                       size:(CGSize)size
                     radius:(CGFloat)radius
                borderWidth:(CGFloat)borderWidth
                borderColor:(UIColor *)borderColor;

@end

NS_ASSUME_NONNULL_END
