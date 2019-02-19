//
//  XPYNetworkingHelper.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/2/19.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSUInteger, XPYNetworkStatus) {
    XPYNetworkStatusUnknown,        //未知网络
    XPYNetworkStatusUnreachable,    //没有网络
    XPYNetworkStatusReachableWWAN,  //手机网络
    XPYNetworkStatusReachableWiFi   //wifi网络
};

//请求成功block
typedef void (^XPYHttpRequestSuccess)(id responseObject);

//请求失败block
typedef void (^XPYHttpRequestFailure)(NSError *error);

//网络状态block
typedef void (^XPYNetworkStatusHandler)(XPYNetworkStatus status);

@class AFHTTPSessionManager;
@interface XPYNetworkingHelper : NSObject

@property (nonatomic, strong) AFHTTPSessionManager *manager;
@property (nonatomic, strong) NSMutableArray *tasksArray;

+ (instancetype)sharedInstance;

//获取网络状态
+ (void)networkStatusWithBlock:(XPYNetworkStatusHandler)networkStatus;

//取消所有http请求
- (void)cancelAllHttpRequest;

//取消指定URL的http请求
- (void)cancelHttpRequestWithURL:(NSString *)URLString;

/**
 GET请求

 @param URLString 请求URL
 @param parameters 请求参数
 @param success 请求成功回调
 @param failure 请求失败回调
 @return 返回Task对象可取消请求
 */
- (NSURLSessionTask *)GET:(NSString *)URLString
               parameters:(id)parameters
                  success:(XPYHttpRequestSuccess)success
                  failure:(XPYHttpRequestFailure)failure;

/**
 POST请求

 @param URLString 请求URL
 @param parameters 请求参数
 @param success 请求成功回调
 @param failure 请求失败回调
 @return 返回Task对象可取消请求
 */
- (NSURLSessionTask *)POST:(NSString *)URLString
                parameters:(id)parameters
                   success:(XPYHttpRequestSuccess)success
                   failure:(XPYHttpRequestFailure)failure;






@end
