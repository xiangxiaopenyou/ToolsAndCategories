//
//  XPYDataBaseManager.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/30.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYDataBaseManager.h"

@implementation XPYDataBaseManager
+ (instancetype)sharedInstance {
    static XPYDataBaseManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XPYDataBaseManager alloc] init];
    });
    return instance;
}

@end
