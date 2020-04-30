//
//  NSTimer+XPYWeakTimer.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/4/29.
//  Copyright © 2020 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (XPYWeakTimer)

// 需要手动添加到RunLoop
+ (NSTimer *)xpy_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block;

// 自动添加到RunLoop
+ (NSTimer *)xpy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block;

@end

NS_ASSUME_NONNULL_END
