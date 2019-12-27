//
//  UILabel+XPYFitFont.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/12/26.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "UILabel+XPYFitFont.h"
#import "XPYUtilitiesDefine.h"

#import <objc/runtime.h>

static char kXPYFitFontKey;

@implementation UILabel (XPYFitFont)

- (void)setFitFontSize:(CGFloat)fitFontSize {
    self.font = [UIFont fontWithName:self.font.fontName size:XPYScreenScaleConstant(fitFontSize)];
    objc_setAssociatedObject(self, &kXPYFitFontKey, @(fitFontSize), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)fitFontSize {
    return [objc_getAssociatedObject(self, &kXPYFitFontKey) floatValue];
}

@end
