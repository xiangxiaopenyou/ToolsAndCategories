//
//  XPYTestAPIManager.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/14.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYTestAPIManager.h"

@interface XPYTestAPIManager ()

@end

@implementation XPYTestAPIManager

- (nonnull NSString *)methodName {
    return @"";
}

- (XPYNetworkingRequestType)requestType {
    return XPYNetworkingRequestTypeGet;
}

- (NSDictionary *)requestParams {
    return @{};
}
@end
