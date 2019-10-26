//
//  UIViewController+XPYScrollViewInsets.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/10/26.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "UIViewController+XPYScrollViewInsets.h"
#import <objc/runtime.h>


@implementation UIViewController (XPYScrollViewInsets)
+ (void)load {
    Class class = [self class];
    Method originMethod = class_getInstanceMethod(class, @selector(viewDidLoad));
    Method swizzledMethod = class_getInstanceMethod(class, @selector(xpy_viewDidLoad));
    BOOL didAddMethod = class_addMethod(class, @selector(viewDidLoad), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
    if (didAddMethod) {
        class_replaceMethod(class, @selector(xpy_viewDidLoad), method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        method_exchangeImplementations(originMethod, swizzledMethod);
    }
}

- (void)xpy_viewDidLoad {
    [self xpy_viewDidLoad];
    if (@available(iOS 11.0, *)) {
        for (UIView *view in self.view.subviews) {
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrollView = (UIScrollView *)view;
                scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

@end
