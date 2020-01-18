//
//  XPYNetworkingBaseAPIManager.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/9.
//

#import "XPYNetworkingBaseAPIManager.h"
#import "XPYNetworkingHelper.h"
#import "XPYNetworkingServiceFactory.h"

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
        if ([self.child respondsToSelector:@selector(logEnable)]) {
            [XPYNetworkingHelper sharedInstance].logEnable = [self.child logEnable];
        }
        if ([self.child respondsToSelector:@selector(networkActivityIndicatorEnable)]) {
            [XPYNetworkingHelper sharedInstance].networkActivityIndicatorEnable = [self.child networkActivityIndicatorEnable];
        }
        if ([self.child respondsToSelector:@selector(acceptableContentTypes)]) {
            [XPYNetworkingHelper sharedInstance].responseAcceptableContentTypes = [self.child acceptableContentTypes];
        }
        if ([self.child respondsToSelector:@selector(timeoutInterval)]) {
            [XPYNetworkingHelper sharedInstance].timeoutInterval = [self.child timeoutInterval];
        }
    }
    return self;
}

#pragma mark - Instance methods
- (void)requestData {
    id <XPYNetworkingServiceProtocol> service = [[XPYNetworkingServiceFactory sharedInstance] networkingServiceWithIdentifier:[self.child serviceIdentifier]];
    NSString *requestURLString = [service requestURLStringWithMethod:[self.child methodName] requestType:[self.child requestType]];
    NSDictionary *params = [self.child respondsToSelector:@selector(requestParams)] ? [self.child requestParams] : nil;
    params = [service completedParametersWithParams:params];
    switch ([self.child requestType]) {
        case XPYNetworkingRequestTypeGet: {
            [[XPYNetworkingHelper sharedInstance] getWithURL:requestURLString parameters:params success:^(id responseObject) {
                [self parseResponseResult:responseObject withService:service];
            } failure:^(NSError *error) {
                self.responseError = error;
                if (self.responseDelegate && [self.responseDelegate respondsToSelector:@selector(networkingAPIResponseDidFail:)]) {
                    [self.responseDelegate networkingAPIResponseDidFail:self];
                }
            }];
        }
            break;
        case XPYNetworkingRequestTypePost: {
            [[XPYNetworkingHelper sharedInstance] postWithURL:requestURLString parameters:params success:^(id responseObject) {
                [self parseResponseResult:responseObject withService:service];
            } failure:^(NSError *error) {
                self.responseError = error;
                if (self.responseDelegate && [self.responseDelegate respondsToSelector:@selector(networkingAPIResponseDidFail:)]) {
                    [self.responseDelegate networkingAPIResponseDidFail:self];
                }
            }];
        }
            break;
        case XPYNetworkingRequestTypeUploadFile: {
            [[XPYNetworkingHelper sharedInstance] uploadFileWithURL:requestURLString parameters:params bucketName:[self.child bucketName] filePath:[self.child filePath] progress:^(NSProgress *progress) {
                self.responseProgress = progress;
                if (self.responseDelegate && [self.responseDelegate respondsToSelector:@selector(networkingAPIResponseProgress:)]) {
                    [self.responseDelegate networkingAPIResponseProgress:self];
                }
            } success:^(id responseObject) {
                [self parseResponseResult:responseObject withService:service];
            } failure:^(NSError *error) {
                self.responseError = error;
                if (self.responseDelegate && [self.responseDelegate respondsToSelector:@selector(networkingAPIResponseDidFail:)]) {
                    [self.responseDelegate networkingAPIResponseDidFail:self];
                }
            }];
        }
            break;
        case XPYNetworkingRequestTypeDownloadFile: {
            NSString *fileDirectory = nil;
            if ([self.child dowloadFileDirectory]) {
                fileDirectory = [self.child dowloadFileDirectory];
            }
            [[XPYNetworkingHelper sharedInstance] downloadFileWithURL:requestURLString fileDirectory:fileDirectory progress:^(NSProgress *progress) {
                self.responseProgress = progress;
                if (self.responseDelegate && [self.responseDelegate respondsToSelector:@selector(networkingAPIResponseProgress:)]) {
                    [self.responseDelegate networkingAPIResponseProgress:self];
                }
            } success:^(id responseObject) {
                [self parseResponseResult:responseObject withService:service];
            } failure:^(NSError *error) {
                self.responseError = error;
                if (self.responseDelegate && [self.responseDelegate respondsToSelector:@selector(networkingAPIResponseDidFail:)]) {
                    [self.responseDelegate networkingAPIResponseDidFail:self];
                }
            }];
        }
            break;
    }
}
- (void)cancelAllRequests {
    [[XPYNetworkingHelper sharedInstance] cancelAllHttpRequests];
}
- (void)cancelRequestWithURLString:(NSString *)urlString {
    if (urlString) {
        [[XPYNetworkingHelper sharedInstance] cancelHttpRequestWithURL:urlString];
    }
}

#pragma mark - Private methods
- (void)parseResponseResult:(id)response withService:(id <XPYNetworkingServiceProtocol>)service {
    id result = [service resultWithResponseObject:response];
    if ([result isKindOfClass:[NSError class]]) {   // 请求返回错误信息
        self.responseError = (NSError *)result; 
        if (self.responseDelegate && [self.responseDelegate respondsToSelector:@selector(networkingAPIResponseDidFail:)]) {
            [self.responseDelegate networkingAPIResponseDidFail:self];
        }
    } else {                                        // 请求返回成功信息
        self.responseObject = result;
        if (self.responseDelegate && [self.responseDelegate respondsToSelector:@selector(networkingAPIResponseDidSuccess:)]) {
            [self.responseDelegate networkingAPIResponseDidSuccess:self];
        }
    }
}

#pragma mark - Dealloc
- (void)dealloc {
    [self cancelAllRequests];
}

@end
