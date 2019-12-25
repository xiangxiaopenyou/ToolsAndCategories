//
//  XPYUtilities.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/30.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYUtilities : NSObject

/// 是否iPhoneX系列机型
+ (BOOL)isIphoneX;

/// 根据Hex字符串获取颜色
/// @param hexString 16进制字符串
/// @param alpha 透明度
+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha;

@end

NS_ASSUME_NONNULL_END
