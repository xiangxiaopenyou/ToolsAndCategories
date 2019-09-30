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

@end
