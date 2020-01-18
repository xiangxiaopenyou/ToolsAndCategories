//
//  XPYNetworkingHelper.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/2/19.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYNetworkingHelper.h"
#import <AFNetworking/AFNetworking.h>
#import <AFNetworking/AFNetworkActivityIndicatorManager.h>

@interface XPYNetworkingHelper ()
@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *tasksArray;
@end

@implementation XPYNetworkingHelper

#pragma mark - 监测网络
+ (void)load {
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

- (void)networkStatusWithBlock:(XPYNetworkStatusHandler)networkStatus {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: {
                networkStatus ? networkStatus(XPYNetworkStatusUnknown) : nil;
                if (self.logEnable) {
                    NSLog(@"未知网络");
                }
            }
                break;
            case AFNetworkReachabilityStatusNotReachable: {
                networkStatus ? networkStatus(XPYNetworkStatusUnreachable) : nil;
                if (self.logEnable) {
                    NSLog(@"没有网络");
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                networkStatus ? networkStatus(XPYNetworkStatusReachableWWAN) : nil;
                if (self.logEnable) {
                    NSLog(@"手机网络");
                }
            }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                networkStatus ? networkStatus(XPYNetworkStatusReachableWiFi) : nil;
                if (self.logEnable) {
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
        // 请求超时时间默认30
        _manager.requestSerializer.timeoutInterval = 30.f;
        // 默认acceptableContentTypes
        _manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript", @"text/xml", @"image/*", nil];
        // 状态栏的ActivityIndicator默认开启
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        // 默认不打印log
        _logEnable = NO;
    }
    return self;
}

#pragma mark - 取消所有HTTP请求
- (void)cancelAllHttpRequests {
    // 同步锁保证取消请求删除任务操作安全
    @synchronized (self) {
        [self.tasksArray enumerateObjectsUsingBlock:^(NSURLSessionTask *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [obj cancel];
        }];
        [self.tasksArray removeAllObjects];
    }
}

#pragma mark - 取消指定URL的HTTP请求
- (void)cancelHttpRequestWithURL:(NSString *)URLString {
    if (!URLString) {
        return;
    }
    // 同步锁保证取消请求删除任务操作安全
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
- (NSURLSessionTask *)getWithURL:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                  success:(XPYRequestSuccess)success
                  failure:(XPYRequestFailure)failure {
    if (self.logEnable) {
        NSLog(@"\nURL:%@\nparams:%@", URLString, parameters);
    }
    NSURLSessionTask *sessionTask = [self.manager GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.logEnable) {
            NSLog(@"responseObject = %@", responseObject);
        }
        [self.tasksArray removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.logEnable) {
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
- (NSURLSessionTask *)postWithURL:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(XPYRequestSuccess)success
                   failure:(XPYRequestFailure)failure {
    if (self.logEnable) {
        NSLog(@"\nURL:%@\nparams:%@", URLString, parameters);
    }
    NSURLSessionTask *sessionTask = [self.manager POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.logEnable) {
            NSLog(@"responseObject = %@", responseObject);
        }
        [self.tasksArray removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.logEnable) {
            NSLog(@"error = %@", error);
        }
        [self.tasksArray removeObject:task];
        failure ? failure(error) : nil;
    }];
    //添加task到数组
    sessionTask ? [self.tasksArray addObject:sessionTask] : nil;
    return sessionTask;
}

#pragma mark - 上传文件
- (NSURLSessionTask *)uploadFileWithURL:(NSString *)URLString
                             parameters:(NSDictionary *)parameters
                             bucketName:(NSString *)bucketName
                               filePath:(NSString *)filePath
                               progress:(XPYRequestProgress)progress
                                success:(XPYRequestSuccess)success
                                failure:(XPYRequestFailure)failure {
    if (self.logEnable) {
        NSLog(@"\nURL:%@\nparams:%@\nbucketName:%@\nfilePath:%@", URLString, parameters, bucketName, filePath);
    }
    NSURLSessionTask *sessionTask = [self.manager POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSError *error = nil;
        [formData appendPartWithFileURL:[NSURL URLWithString:filePath] name:bucketName error:&error];
        if (failure && error) {
            if (self.logEnable) {
                NSLog(@"error = %@", error);
            }
            failure(error);
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (self.logEnable) {
            NSLog(@"progress = %@", uploadProgress);
        }
        progress ? progress(uploadProgress) : nil;
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (self.logEnable) {
            NSLog(@"responseObject = %@", responseObject);
        }
        [self.tasksArray removeObject:task];
        success ? success(responseObject) : nil;
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (self.logEnable) {
            NSLog(@"error = %@", error);
        }
        [self.tasksArray removeObject:task];
        failure ? failure(error) : nil;
    }];
    return sessionTask;
}

#pragma mark - 文件下载
- (NSURLSessionTask *)downloadFileWithURL:(NSString *)URLString
                            fileDirectory:(NSString *)fileDirectory
                                 progress:(XPYRequestProgress)progress
                                  success:(XPYRequestSuccess)success
                                  failure:(XPYRequestFailure)failure {
    if (self.logEnable) {
        NSLog(@"\nURL:%@\n fileDirectory:%@", URLString, fileDirectory);
    }
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URLString]];
    __block NSURLSessionDownloadTask *downloadTask = [self.manager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (self.logEnable) {
            NSLog(@"progress = %@", downloadProgress);
        }
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(downloadProgress) : nil;
        });
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        NSString *directoryPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).lastObject stringByAppendingPathComponent:fileDirectory ? fileDirectory : @"Download"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *filePath = [directoryPath stringByAppendingPathComponent:response.suggestedFilename];
        if (self.logEnable) {
            NSLog(@"destinationPath = %@", filePath);
        }
        return [NSURL fileURLWithPath:filePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [self.tasksArray removeObject:downloadTask];
        if (failure && error) {
            if (self.logEnable) {
                NSLog(@"error = %@", error);
            }
            failure(error);
            return;
        }
        if (self.logEnable) {
            NSLog(@"responseObject = %@", response);
        }
        success ? success(filePath.absoluteString) : nil;
    }];
    [downloadTask resume];
    downloadTask ? [self.tasksArray addObject:downloadTask] : nil;
    return downloadTask;
}

#pragma mark - Setters
- (void)setTimeoutInterval:(NSTimeInterval)timeoutInterval {
    self.manager.requestSerializer.timeoutInterval = timeoutInterval;
}
- (void)setResponseAcceptableContentTypes:(NSSet *)responseAcceptableContentTypes {
    if (responseAcceptableContentTypes && responseAcceptableContentTypes.count > 0) {
        self.manager.responseSerializer.acceptableContentTypes = responseAcceptableContentTypes;
    }
}
- (void)setNetworkActivityIndicatorStatus:(BOOL)networkActivityIndicatorStatus {
    [AFNetworkActivityIndicatorManager sharedManager].enabled = networkActivityIndicatorStatus;
}

#pragma mark - Getters
- (NSMutableArray *)tasksArray {
    if (!_tasksArray) {
        _tasksArray = [[NSMutableArray alloc] init];
    }
    return _tasksArray;
}

@end
