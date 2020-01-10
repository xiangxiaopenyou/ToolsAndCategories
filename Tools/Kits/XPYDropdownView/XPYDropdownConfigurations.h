//
//  XPYDropdownConfigurations.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/2.
//  Copyright © 2020 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYDropdownConfigurations : NSObject

/// 弹出菜单时空白处背景颜色，默认为 [UIColor clearColor]
@property (nonatomic, strong) UIColor *mainBackgroundColor;

/// 下拉菜单背景颜色，默认为 [UIColor whiteColor]
@property (nonatomic, strong) UIColor *dropdownBackgroundColor;

/// 分割线颜色，默认为 [UIColor grayColor]
@property (nonatomic, strong) UIColor *separatorColor;

/// 分割线Insets，默认为 UIEdgeInsetsMake(0, 15, 0, 15)，即左右各留15
@property (nonatomic, assign) UIEdgeInsets separatorEdgeInsets;

/// 是否隐藏分割线，默认NO不隐藏
@property (nonatomic, assign) BOOL isHiddenSeparator;

/// 选中时背景颜色，默认为TableView自带颜色
@property (nonatomic, strong) UIColor *cellSelectedColor;

/// 单项高度，默认为50
@property (nonatomic, assign) CGFloat cellHeight;

/// 下拉菜单宽度， 默认为150
@property (nonatomic, assign) CGFloat dropdownWidth;

/// 下拉菜单圆角，默认为5
@property (nonatomic, assign) CGFloat cornerRadius;

/// 箭头宽度，默认为12，取值(2 — dropdownWidth/2.0)
@property (nonatomic, assign) CGFloat arrowWidth;

/// 箭头高度，默认为8，当该值为0时隐藏箭头
@property (nonatomic, assign) CGFloat arrowHeight;

/// 箭头左底角起始x位置(相对于下拉菜单)，不超过 (dropdownWidth - arrowWidth - cornerRadius )， 默认为130
@property (nonatomic, assign) CGFloat arrowOriginX;

/// 字体，默认为 [UIFont systemFontOfSize:14]
@property (nonatomic, strong) UIFont *titleFont;

/// 字体颜色，默认为 [UIColor blackColor]
@property (nonatomic, strong) UIColor *titleColor;

/// 特殊需求：是否添加阴影，默认NO
@property (nonatomic, assign) BOOL isAddShadow;

@end

NS_ASSUME_NONNULL_END
