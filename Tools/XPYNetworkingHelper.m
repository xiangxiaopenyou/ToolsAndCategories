//
//  XPYNetworkingHelper.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/2/19.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYNetworkingHelper.h"
#import <AFNetworking.h>
#import <AFNetworkActivityIndicatorManager.h>

#ifdef DEBUG
static BOOL const isLog = YES;
#else
static BOOL const isLog = NO;
#endif

@implementation XPYNetworkingHelper
/**
 开始监测网络状态
 */
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}
+ (void)networkStatusWithBlock:(XPYNetworkStatusHandler)networkStatus {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                networkStatus ? networkStatus(XPYNetworkStatusUnknown) : nil;
                if (isLog) {
                    NSLog(@"未知网络");
                }
            }
                break;
            case AFNetworkReachabilityStatusNotReachable: {
                networkStatus ? networkStatus(XPYNetworkStatusUnreachable) : nil;
                if (isLog) {
                    NSLog(@"没有网络");
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                networkStatus ? networkStatus(XPYNetworkStatusReachableWWAN) : nil;
                if (isLog) {
                    NSLog(@"手机网络");
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                networkStatus ? networkStatus(XPYNetworkStatusReachableWiFi) : nil;
                if (isLog) {
                    NSLog(@"WiFi");
                }
            }
                break;
                
            default:
                break;
        }
    }];
}
+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static XPYNetworkingHelper *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[XPYNetworkingHelper alloc] init];
    });
    return instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _manager = [AFHTTPSessionManager manager];
        _manager.requestSerializer.timeoutInterval = 30.f;
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    }
    return self;
}

#pragma mark - 取消所有HTTP请求
- (void)cancelAllHttpRequest {
    @synchronized (self) {
        [self.tasksArray enumerateObjectsUsingBlock:^(NSURLSessionTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj cancel];
        }];
        [self.tasksArray removeAllObjects];
    }
}

#pragma nark - 取消指定URL的HTTP请求
- (void)cancelHttpRequestWithURL:(NSString *)URLString {
    if (!URLString) {
        return;
    }
    @synchronized (self) {
        [self.tasksArray enumerateObjectsUsingBlock:^(NSURLSessionTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj.currentRequest.URL.absoluteString hasPrefix:URLString]) {
                [obj cancel];
                [self.tasksArray removeObject:obj];
                *stop = YES;
            }
        }];
    }
}

#pragma mark - GET请求
- (NSURLSessionTask *)GET:(NSString *)URLString
               parameters:(id)parameters
                  success:(XPYHttpRequestSuccess)success
                  failure:(XPYHttpRequestFailure)failure {
    NSURLSessionTask *sessionTask = [self.manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isLog) {
            NSLog(@"responseObject = %@", responseObject);
        }
        [self.tasksArray removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isLog) {
            NSLog(@"error = %@", error);
        }
        [self.tasksArray removeObject:task];
        failure ? failure(error) : nil;
    }];
    //添加task到数组
    sessionTask ? [self.tasksArray addObject:sessionTask] : nil;
    return sessionTask;
}

#pragma mark - POST请求
- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(id)parameters
                   success:(XPYHttpRequestSuccess)success
                   failure:(XPYHttpRequestFailure)failure {
    NSURLSessionTask *sessionTask = [self.manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (isLog) {
            NSLog(@"responseObject = %@", responseObject);
        }
        [self.tasksArray removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (isLog) {
            NSLog(@"error = %@", error);
        }
        [self.tasksArray removeObject:task];
        failure ? failure(error) : nil;
    }];
    //添加task到数组
    sessionTask ? [self.tasksArray addObject:sessionTask] : nil;
    return sessionTask;
}

#pragma mark - Getters
- (NSMutableArray *)tasksArray {
    if (!_tasksArray) {
        _tasksArray = [[NSMutableArray alloc] init];
    }
    return _tasksArray;
}

@end
