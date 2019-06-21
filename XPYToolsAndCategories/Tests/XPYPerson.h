//
//  XPYPerson.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/5/30.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYPerson : NSObject

/**
 传统方式
 方法需要分别调用
 */
- (void)eat;
- (void)sleep;


/**
 可用[]实现连续调用

 @return self
 */
- (XPYPerson *)run;
- (XPYPerson *)rest;


/**
 使用block实现链式
 */
- (void (^)(void))start;
- (void (^)(void))stop;


/**
 无参数链式调用
 */
- (XPYPerson * (^)(void))up;
- (XPYPerson * (^)(void))down;


/**
 有参数链式调用
 */
- (XPYPerson * (^)(NSString *name))left;
- (XPYPerson * (^)(NSString *name))right;



@end

NS_ASSUME_NONNULL_END
