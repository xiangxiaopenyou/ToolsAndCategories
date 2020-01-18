//
//  XPYNetworkingHelper.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/2/19.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "XPYNetworkingDefine.h"

/// 网络状态block
typedef void (^XPYNetworkStatusHandler)(XPYNetworkStatus status);

/// 请求成功block
typedef void (^XPYRequestSuccess)(id responseObject);

/// 请求失败block
typedef void (^XPYRequestFailure)(NSError *error);

/// 请求进度block
typedef void (^XPYRequestProgress)(NSProgress *progress);

@interface XPYNetworkingHelper : NSObject

+ (instancetype)sharedInstance;

/// 获取网络状态
- (void)networkStatusWithBlock:(XPYNetworkStatusHandler)networkStatus;

/// 取消所有http请求
- (void)cancelAllHttpRequests;

/// 取消指定URL的http请求
- (void)cancelHttpRequestWithURL:(NSString *)URLString;

/**
 GET请求

 @param URLString 请求URL
 @param parameters 请求参数
 @param success 请求成功回调
 @param failure 请求失败回调
 @return 返回Task对象可取消请求
 */
- (NSURLSessionTask *)getWithURL:(NSString *)URLString
               parameters:(NSDictionary *)parameters
                  success:(XPYRequestSuccess)success
                  failure:(XPYRequestFailure)failure;

/**
 POST请求

 @param URLString 请求URL
 @param parameters 请求参数
 @param success 请求成功回调
 @param failure 请求失败回调
 @return 返回Task对象可调用cancel方法取消请求
 */
- (NSURLSessionTask *)postWithURL:(NSString *)URLString
                parameters:(NSDictionary *)parameters
                   success:(XPYRequestSuccess)success
                   failure:(XPYRequestFailure)failure;


/**
 上传文件

 @param URLString 请求URL
 @param parameters 请求参数
 @param bucketName 文件对应服务器上的字段
 @param filePath 文件本地沙盒路径
 @param progress 上传进度
 @param success 上传成功回调
 @param failure 上传失败回调
 @return 返回Task对象可调用cancel方法取消
 */
- (NSURLSessionTask *)uploadFileWithURL:(NSString *)URLString
                             parameters:(NSDictionary *)parameters
                             bucketName:(NSString *)bucketName
                               filePath:(NSString *)filePath
                               progress:(XPYRequestProgress)progress
                                success:(XPYRequestSuccess)success
                                failure:(XPYRequestFailure)failure;


/**
 下载文件

 @param URLString 请求URL
 @param fileDirectory 文件存储目录（默认为Download目录）
 @param progress 下载进度
 @param success 下载成功回调
 @param failure 下载失败回调
 @return 返回NSURLSessionDownloadTask实例，可暂停suspend 继续resume
 */
- (NSURLSessionTask *)downloadFileWithURL:(NSString *)URLString
                            fileDirectory:(NSString *)fileDirectory
                                 progress:(XPYRequestProgress)progress
                                  success:(XPYRequestSuccess)success
                                  failure:(XPYRequestFailure)failure;

#pragma mark - Properties
/// 请求超时时间
@property (nonatomic, assign) NSTimeInterval timeoutInterval;

/// 响应数据接收类型集合
@property (nonatomic, strong) NSSet *responseAcceptableContentTypes;

/// 是否开启状态栏ActivityIndicator YES开启 NO关闭
@property (nonatomic, assign) BOOL networkActivityIndicatorEnable;

/// 是否打印失败、成功、进度log，默认NO
@property (nonatomic, assign) BOOL logEnable;

@end
