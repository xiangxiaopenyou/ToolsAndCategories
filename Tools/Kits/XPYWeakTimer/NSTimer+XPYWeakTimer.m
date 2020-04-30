//
//  NSTimer+XPYWeakTimer.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/4/29.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "NSTimer+XPYWeakTimer.h"

@implementation NSTimer (XPYWeakTimer)

+ (NSTimer *)xpy_timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block {
    NSTimer *timer = [NSTimer timerWithTimeInterval:interval target:self selector:@selector(zd_timerCounter:) userInfo:[block copy] repeats:repeats];
    return timer;
}
+ (NSTimer *)xpy_scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(void))block {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(zd_timerCounter:) userInfo:[block copy] repeats:repeats];
    return timer;
}

+ (void)zd_timerCounter:(NSTimer *)timer {
    if (timer.userInfo) {
        void (^block)(void) = timer.userInfo;
        block();
    }
}

@end
