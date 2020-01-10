//
//  XPYDropdownItemModel.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/3.
//  Copyright © 2020 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, XPYDropdownCellStyle) {
    XPYDropdownCellStyleIconAndTitle,
    XPYDropdownCellStyleIcon,
    XPYDropdownCellStyleTitle
};

NS_ASSUME_NONNULL_BEGIN

@interface XPYDropdownItemModel : NSObject

/// 构造Model
/// @param index index
/// @param icon 图片
/// @param title 文字
/// @param titleColor 文字颜色
+ (instancetype)makeModel:(NSInteger)index
                    icon:(nullable UIImage *)icon
                    title:(nullable NSString *)title
               titleColor:(nullable UIColor *)titleColor;

/// index
@property (nonatomic, assign) NSInteger itemIndex;

/// 图片，最大size(cellHeight - 5, cellHeight)，不压缩不拉伸
@property (nonatomic, strong, nullable) UIImage *itemIcon;

/// 文字
@property (nonatomic, copy, nullable) NSString *itemTitle;

/// 单独一项文字颜色，默认为空（统一颜色）
@property (nonatomic, strong, nullable) UIColor *itemTitleColor;

/// 风格（图片加文字、单图片、单文字）
@property (nonatomic, assign) XPYDropdownCellStyle cellStyle;

@end

NS_ASSUME_NONNULL_END
