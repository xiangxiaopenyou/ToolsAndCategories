//
//  UIViewController+XPYScrollViewInsets.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/10/26.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "UIViewController+XPYScrollViewInsets.h"
#import "NSObject+XPYMethodSwizzling.h"


@implementation UIViewController (XPYScrollViewInsets)
//将方法交换过程放在load方法中实现，是因为load方法原则上只会被调用一次
//但也有可能被其他类手动调用，所以可以使用dispatch_once_t来保证方法交换只进行了一次
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self xpy_instanceMethodSwizzlingWithOriginSel:@selector(viewDidLoad) swizzlingSel:@selector(xpy_viewDidLoad)];
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
