//
//  XPYNetworkingService.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/13.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYNetworkingService.h"

@interface XPYNetworkingService ()

@property (nonatomic, copy) NSString *baseURLString;

@end

@implementation XPYNetworkingService

//- (NSString *)requestURLStringWithMethod:(NSString *)methodName
//                             requestType:(XPYNetworkingRequestType)requestType
//                              parameters:(NSDictionary *)params {
//    <#code#>
//}
//
//- (NSDictionary *)resultWithResponse:(id)responseObjcect error:(NSError *)error {
//    <#code#>
//}

#pragma mark - Getters
- (NSString *)baseURLString {
#if DEBUG
    return @"";
#else
    return @"";
#endif
}

@end
