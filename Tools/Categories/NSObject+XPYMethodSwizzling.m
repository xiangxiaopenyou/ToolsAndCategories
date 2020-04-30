//
//  NSObject+XPYMethodSwizzling.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/4/28.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "NSObject+XPYMethodSwizzling.h"
#import <objc/runtime.h>

@implementation NSObject (XPYMethodSwizzling)

+ (void)xpy_classMethodSwizzlingWithOriginSel:(SEL)originSEL swizzlingSel:(SEL)swizzlingSEL {
    Class class = [self class];
    Method originMethod = class_getClassMethod(class, originSEL);
    Method swizzlingMethod = class_getClassMethod(class, swizzlingSEL);
    // 类方法需要获取元类
    Class metaClass = objc_getMetaClass(NSStringFromClass(class).UTF8String);
    NSLog(@"metaClass:%@", metaClass);
    // 尝试向元类中添加方法实现，如果添加成功，说明不存在原方法，如果失败则已经存在原方法
    BOOL isAddSuccess = class_addMethod(metaClass, originSEL, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
    if (isAddSuccess) {
        // 替换原方法
        class_replaceMethod(metaClass, swizzlingSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        // 直接交换方法实现
        method_exchangeImplementations(originMethod, swizzlingMethod);
    }
}
+ (void)xpy_instanceMethodSwizzlingWithOriginSel:(SEL)originSEL swizzlingSel:(SEL)swizzlingSEL {
    Class class = [self class];
    Method originMethod = class_getInstanceMethod(class, originSEL);
    Method swizzlingMethod = class_getInstanceMethod(class, swizzlingSEL);
    // 尝试添加方法实现，如果添加成功，说明不存在原方法，如果失败则已经存在原方法
    BOOL isAddSuccess = class_addMethod(class, originSEL, method_getImplementation(swizzlingMethod), method_getTypeEncoding(swizzlingMethod));
    if (isAddSuccess) {
        // 替换原方法
        class_replaceMethod(class, swizzlingSEL, method_getImplementation(originMethod), method_getTypeEncoding(originMethod));
    } else {
        // 直接交换方法实现
        method_exchangeImplementations(originMethod, swizzlingMethod);
    }
}

@end
