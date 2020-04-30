//
//  NSObject+XPYMethodSwizzling.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/4/28.
//  Copyright © 2020 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (XPYMethodSwizzling)

+ (void)xpy_classMethodSwizzlingWithOriginSel:(SEL)originSEL swizzlingSel:(SEL)swizzlingSEL;
+ (void)xpy_instanceMethodSwizzlingWithOriginSel:(SEL)originSEL swizzlingSel:(SEL)swizzlingSEL;

@end

NS_ASSUME_NONNULL_END
