//
//  XPYLoginAPIManager.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/18.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYLoginAPIManager.h"

@implementation XPYLoginAPIManager

- (NSString *)methodName {
    return @"user?action=login";
}

- (XPYNetworkingRequestType)requestType {
    return XPYNetworkingRequestTypePost;
}

- (NSDictionary *)requestParams {
    return @{
        @"tel" : @"13732254511",
        @"password" : @"e10adc3949ba59abbe56e057f20f883e",  //md5加密
        @"type" : @"login_by_pwd"
    };
}

- (NSString *)serviceIdentifier {
    return @"XPYNetworkingService";
}

@end
