//
//  XPYNetworkingServiceFactory.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/15.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYNetworkingServiceFactory.h"
#import <CTMediator/CTMediator.h>

@implementation XPYNetworkingServiceFactory

+ (instancetype)sharedInstance {
    static XPYNetworkingServiceFactory *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XPYNetworkingServiceFactory alloc] init];
    });
    return instance;
}
- (id<XPYNetworkingServiceProtocol>)networkingServiceWithIdentifier:(NSString *)identifier {
    // 使用CTMediator获取服务
    return [[CTMediator sharedInstance] performTarget:identifier action:identifier params:nil shouldCacheTarget:NO];
}

@end
