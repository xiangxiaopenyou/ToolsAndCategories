//
//  NSArray+XPYAvoidOutOfRange.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/11/10.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "NSArray+XPYAvoidOutOfRange.h"
#import "NSObject+XPYMethodSwizzling.h"
#import <objc/runtime.h>

@implementation NSArray (XPYAvoidOutOfRange)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 获取四种隐藏的实现类
        Class arrayClass = objc_getClass("__NSArrayI");
        Class emptyArrayClass = objc_getClass("__NSArray0");
        Class singleArrayClass = objc_getClass("__NSSingleObjectArrayI");
        Class mutableArrayClass = objc_getClass("__NSArrayM");  // 可变数组
        
        // 每种实现类都需要hook相关方法
        [arrayClass xpy_instanceMethodSwizzlingWithOriginSel:@selector(objectAtIndex:) swizzlingSel:@selector(xpy_objectAtIndex:)];
        [arrayClass xpy_instanceMethodSwizzlingWithOriginSel:@selector(objectAtIndexedSubscript:) swizzlingSel:@selector(xpy_objectAtIndexedSubscript:)];
        
        [emptyArrayClass xpy_instanceMethodSwizzlingWithOriginSel:@selector(objectAtIndex:) swizzlingSel:@selector(xpy_empty_objectAtIndex:)];
        [emptyArrayClass xpy_instanceMethodSwizzlingWithOriginSel:@selector(objectAtIndexedSubscript:) swizzlingSel:@selector(xpy_empty_objectAtIndexedSubscript:)];
        
        [singleArrayClass xpy_instanceMethodSwizzlingWithOriginSel:@selector(objectAtIndex:) swizzlingSel:@selector(xpy_single_objectAtIndex:)];
        [singleArrayClass xpy_instanceMethodSwizzlingWithOriginSel:@selector(objectAtIndexedSubscript:) swizzlingSel:@selector(xpy_single_objectAtIndexedSubscript:)];
        
        [mutableArrayClass xpy_instanceMethodSwizzlingWithOriginSel:@selector(objectAtIndex:) swizzlingSel:@selector(xpy_mutable_objectAtIndex:)];
        [mutableArrayClass xpy_instanceMethodSwizzlingWithOriginSel:@selector(objectAtIndexedSubscript:) swizzlingSel:@selector(xpy_mutable_objectAtIndexedSubscript:)];
        
        
    });
}

#pragma mark - Array
- (id)xpy_objectAtIndex:(NSUInteger)index {
    NSAssert((index < self.count), ([NSString stringWithFormat:@"objectAtIndex:数组越界，index=%@，count=%@", @(index), @(self.count)]));
    if (index < self.count) {
        return [self xpy_objectAtIndex:index];
    }
    return nil;
}
- (id)xpy_objectAtIndexedSubscript:(NSUInteger)index {
    NSAssert((index < self.count), ([NSString stringWithFormat:@"objectAtIndexedSubscript:数组越界，index=%@，count=%@", @(index), @(self.count)]));
    if (index < self.count) {
        return [self xpy_objectAtIndexedSubscript:index];
    }
    return nil;
}

#pragma mark - Empty array
- (id)xpy_empty_objectAtIndex:(NSUInteger)index {
    // 空数组永远返回nil
    return nil;
}
- (id)xpy_empty_objectAtIndexedSubscript:(NSUInteger)index {
    return nil;
}

#pragma mark - Single array
- (id)xpy_single_objectAtIndex:(NSUInteger)index {
    NSAssert((index < self.count), ([NSString stringWithFormat:@"objectAtIndex:数组越界，index=%@，count=%@", @(index), @(self.count)]));
    if (index < self.count) {
        return [self xpy_single_objectAtIndex:index];
    }
    return nil;
}
- (id)xpy_single_objectAtIndexedSubscript:(NSUInteger)index {
    NSAssert((index < self.count), ([NSString stringWithFormat:@"objectAtIndexedSubscript:数组越界，index=%@，count=%@", @(index), @(self.count)]));
    if (index < self.count) {
        return [self xpy_single_objectAtIndexedSubscript:index];
    }
    return nil;
}

#pragma mark - Mutable array
- (id)xpy_mutable_objectAtIndex:(NSUInteger)index {
    NSAssert((index < self.count), ([NSString stringWithFormat:@"objectAtIndex:数组越界，index=%@，count=%@", @(index), @(self.count)]));
    if (index < self.count) {
        return [self xpy_mutable_objectAtIndex:index];
    }
    return nil;
}
- (id)xpy_mutable_objectAtIndexedSubscript:(NSUInteger)index {
    NSAssert((index < self.count), ([NSString stringWithFormat:@"objectAtIndexedSubscript:数组越界，index=%@，count=%@", @(index), @(self.count)]));
    if (index < self.count) {
        return [self xpy_mutable_objectAtIndexedSubscript:index];
    }
    return nil;
}

@end
