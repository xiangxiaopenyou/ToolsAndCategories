//
//  XPYTestAPIManager.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/14.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYTestAPIManager.h"

@implementation XPYTestAPIManager

- (NSString *)methodName {
    return @"book-city?action=db-home";
}

- (XPYNetworkingRequestType)requestType {
    return XPYNetworkingRequestTypeGet;
}

- (NSDictionary *)requestParams {
    return @{@"page" : @1};
}

- (NSString *)serviceIdentifier {
    // 根据CTMediator的命名规则
    return @"XPYNetworkingService";
}
- (BOOL)logEnable {
    return YES;
}

@end
