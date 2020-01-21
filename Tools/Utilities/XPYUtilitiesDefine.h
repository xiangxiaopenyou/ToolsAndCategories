//
//  XPYUtilitiesDefine.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/30.
//  Copyright © 2019 xpy. All rights reserved.
//
#import "XPYUtilities.h"

/// 弱引用对象
#define weakify(object) autoreleasepool{} __weak __typeof__(object) weak##_##object = object;

/// 强引用对象
#define strongify(object) autoreleasepool{} __typeof__(object) object = weak##_##object;

/// 设备是否iPhoneX系列
#define XPYDeviceIsIphoneX [XPYUtilities isIphoneX]

/// 以375宽度屏幕为基准自适应
#define XPYScreenScaleConstant(aConstant) CGRectGetWidth([UIScreen mainScreen].bounds) / 375 * aConstant

/// 根据Hex值和透明度获取颜色
#define XPYColorFromHexWithAlpha(aHex, aAlpha) [UIColor colorWithRed:((float)((aHex & 0xFF0000) >> 16)) / 255.0 green:((float)((aHex & 0xFF00) >> 8)) / 255.0 blue:((float)(aHex & 0xFF)) / 255.0 alpha:aAlpha]

/// 根据Hex值获取颜色（透明度为1）
#define XPYColorFromHex(aHex) XPYColorFromHexWithAlpha(aHex, 1)

/// 根据Hex字符串和透明度获取颜色
#define XPYColorFromHexStringWithAlpha(aHexString, aAlpha) [XPYUtilities colorFromHexString:aHexString alpha:aAlpha]

/// 根据Hex字符串获取颜色（透明度为1）
#define XPYColorFromHexString(aHexString) XPYColorFromHexStringWithAlpha(aHexString, 1)

