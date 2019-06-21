//
//  XPYPerson.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/5/30.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYPerson.h"

@implementation XPYPerson
- (void)eat {
    
}
- (void)sleep {
    
}

- (XPYPerson *)run {
    NSLog(@"%s", __FUNCTION__);
    return self;
}
- (XPYPerson *)rest {
    NSLog(@"%s", __FUNCTION__);
    return self;
}

- (void (^)(void))start {
    void (^startBlock)(void) = ^ {
        NSLog(@"%s", __FUNCTION__);
    };
    return startBlock;
}
- (void (^)(void))stop {
    void (^stopBlock)(void) = ^ {
        NSLog(@"%s", __FUNCTION__);
    };
    return stopBlock;
}

- (XPYPerson * _Nonnull (^)(void))up {
    XPYPerson * (^upBlock)(void) = ^{
        NSLog(@"%s", __FUNCTION__);
        return self;
    };
    return upBlock;
}
- (XPYPerson * _Nonnull (^)(void))down {
    XPYPerson * (^downBlock)(void) = ^{
        NSLog(@"%s", __FUNCTION__);
        return self;
    };
    return downBlock;
}

- (XPYPerson * _Nonnull (^)(NSString * _Nonnull))left {
    XPYPerson * (^leftBlock)(NSString *string) = ^(NSString *name) {
        NSLog(@"leftname:%@", name);
        return self;
    };
    return leftBlock;
}
- (XPYPerson * _Nonnull (^)(NSString * _Nonnull))right {
    XPYPerson * (^rightBlock)(NSString *string) = ^(NSString *name) {
        NSLog(@"rightname:%@", name);
        return self;
    };
    return rightBlock;
}

@end
