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
//将方法交换过程放在load方法中实现，是因为load方法原则上只会被调用一次
//但也有可能被其他类手动调用，所以可以使用dispatch_once_t来保证方法交换只进行了一次
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        Method originMethod = class_getInstanceMethod(class, @selector(viewDidLoad));
        Method swizzledMethod = class_getInstanceMethod(class, @selector(xpy_viewDidLoad));
    //先将要交换的方法实现加入到原来的方法中去，如果添加失败，说明子类中已经实现了这个方法，就可以直接交换方法实现来达到效果，如果添加成功，说明子类中没有实现这个方法，则可以在添加成功以后替换掉原来的方法，这样就可以保证不影响父类
        BOOL didAddMethod = class_addMethod(class, @selector(viewDidLoad), method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class, @selector(xpy_viewDidLoad), method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
        } else {
            method_exchangeImplementations(originMethod, swizzledMethod);
        }
    });
}

- (void)xpy_viewDidLoad {
    [self xpy_viewDidLoad];
    //iOS 11.0以后使用UIScrollView的contentInsetAdjustmentBehavior代替了UIView的automaticallyAdjustsScrollViewInsets，所以需要做判断
    if (@available(iOS 11.0, *)) {
        for (UIView *view in self.view.subviews) {  //遍历子控件得到scrollView，设置scrollView的contentInsetAdjustmentBehavior为UIScrollViewContentInsetAdjustmentNever
            if ([view isKindOfClass:[UIScrollView class]]) {
                UIScrollView *scrollView = (UIScrollView *)view;
                scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            }
        }
    } else {                                        //直接设置view的automaticallyAdjustsScrollViewInsets为NO
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

@end
