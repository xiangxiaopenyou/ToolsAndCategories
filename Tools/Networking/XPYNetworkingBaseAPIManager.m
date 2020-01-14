//
//  XPYNetworkingBaseAPIManager.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/9.
//

#import "XPYNetworkingBaseAPIManager.h"
#import "XPYNetworkingHelper.h"

@implementation XPYNetworkingBaseAPIManager

#pragma mark - Initializer
- (instancetype)init {
    self = [super init];
    if (self) {
        if ([self conformsToProtocol:@protocol(XPYNetworkingAPIManagerProtocol)]) {
            self.child = (id <XPYNetworkingAPIManagerProtocol>)self;
        } else {
            NSException *exception = [NSException exceptionWithName:@"ProtocolException" reason:@"子类未实现XPYNetworkingAPIManagerProtocol协议" userInfo:nil];
            @throw exception;
        }
    }
    return self;
}

#pragma mark - Instance methods
- (void)requestData {
    NSString *requestURLString = [self.services requestURLStringWithMethod:[self.child methodName] requestType:[self.child requestType] parameters:[self.child requestParams]];
//    NSDictionary *params = [self.child requestParams];
//    [XPYNetworkingHelper sharedInstance] postWithURL:<#(NSString *)#> parameters:<#(NSDictionary *)#> success:<#^(id responseObject)success#> failure:<#^(NSError *error)failure#>
}
- (void)cancelAllRequests {
    [[XPYNetworkingHelper sharedInstance] cancelAllHttpRequests];
}
- (void)cancelRequestWithURLString:(NSString *)urlString {
    if (urlString) {
        [[XPYNetworkingHelper sharedInstance] cancelHttpRequestWithURL:urlString];
    }
}

#pragma mark - Dealloc
- (void)dealloc {
    [self cancelAllRequests];
}

@end
