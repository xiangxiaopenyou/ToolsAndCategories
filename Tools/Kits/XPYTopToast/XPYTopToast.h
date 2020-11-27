//
//  XPYTopToast.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/11/27.
//  Copyright © 2020 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYTopToastStyle : NSObject

/// 背景颜色
/// 默认 系统灰色
@property (nonatomic, strong) UIColor *backgroundColor;

/// 文字颜色
/// 默认 白色
@property (nonatomic, strong) UIColor *textColor;

/// 字体
/// 默认 系统15号字体
@property (nonatomic, strong) UIFont *textFont;

/// 文字对齐方式
/// 默认居中
@property (nonatomic, assign) NSTextAlignment textAlignment;

/// 圆角
/// 默认 0 没有圆角
@property (nonatomic, assign) CGFloat cornerRadius;

/// 提示停留时间
/// 默认为2s
@property (nonatomic, assign) NSTimeInterval duration;

/// 唯一初始化方法
- (instancetype)initWithDefaultStyle;

@end

@interface XPYTopToastView : UIView

/// 初始化方法
/// @param style XPYTopToastStyle
/// @param tips 提示文字
- (instancetype)initWithStyle:(XPYTopToastStyle *)style tips:(NSString *)tips;

@end

@interface XPYTopToast : NSObject

/// 默认显示提示
/// @param tips 提示文字
+ (void)showWithTips:(NSString *)tips;

/// 根据配置类显示提示
/// @param tips 提示文字
/// @param style 配置
+ (void)showWithTips:(NSString *)tips style:(XPYTopToastStyle *)style;

@end

NS_ASSUME_NONNULL_END
