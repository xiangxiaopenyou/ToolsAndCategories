//
//  XPYUtilities.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/30.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYUtilities.h"

@implementation XPYUtilities

+ (BOOL)isIphoneX {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    if (@available(iOS 11.0, *)) {
        CGFloat bottomInsets = keyWindow.safeAreaInsets.bottom;
        if (bottomInsets > 0) {
            return YES;
        }
    }
    return NO;
}

+ (UIColor *)colorFromHexString:(NSString *)hexString alpha:(CGFloat)alpha {
    //删除前缀字符
    if ([hexString hasPrefix:@"0X"] || [hexString hasPrefix:@"0x"]) {
        hexString = [hexString substringFromIndex:2];
    }
    if ([hexString hasPrefix:@"#"]) {
        hexString = [hexString substringFromIndex:1];
    }
    
    //判断字符串是否符合长度规范
    if (hexString.length != 6) {
        return [UIColor clearColor];
    }
    
    //截取色值字符
    NSRange range = NSMakeRange(0, 2);
    NSString *redString = [hexString substringWithRange:range];
    range.location = 2;
    NSString *greenString = [hexString substringWithRange:range];
    range.location = 4;
    NSString *blueString = [hexString substringWithRange:range];
    
    //转换成色值
    unsigned int red;
    unsigned int green;
    unsigned int blue;
    [[NSScanner scannerWithString:redString] scanHexInt:&red];
    [[NSScanner scannerWithString:greenString] scanHexInt:&green];
    [[NSScanner scannerWithString:blueString] scanHexInt:&blue];
    UIColor *resultColor = [UIColor colorWithRed:red / 255.0 green:green / 255.0 blue:blue / 255.0 alpha:alpha];
    return resultColor;
}
@end
