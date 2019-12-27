//
//  NSLayoutConstraint+XPYFitConstant.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/12/26.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "NSLayoutConstraint+XPYFitConstant.h"
#import "XPYUtilitiesDefine.h"

#import <objc/runtime.h>

static char kXPYFitConstantKey;

@implementation NSLayoutConstraint (XPYFitConstant)

- (void)setFitConstant:(CGFloat)fitConstant {
    self.constant = XPYScreenScaleConstant(fitConstant);
    objc_setAssociatedObject(self, &kXPYFitConstantKey, @(fitConstant), OBJC_ASSOCIATION_ASSIGN);
}
- (CGFloat)fitConstant {
    return [objc_getAssociatedObject(self, &kXPYFitConstantKey) floatValue];
}

@end
