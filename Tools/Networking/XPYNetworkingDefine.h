//
//  XPYNetworkingDefine.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/13.
//

#ifndef XPYNetworkingDefine_h
#define XPYNetworkingDefine_h

@class XPYNetworkingBaseAPIManager;

/// 网络请求
typedef NS_ENUM(NSUInteger, XPYNetworkStatus) {
    XPYNetworkStatusUnknown,        //未知网络
    XPYNetworkStatusUnreachable,    //没有网络
    XPYNetworkStatusReachableWWAN,  //手机网络
    XPYNetworkStatusReachableWiFi   //wifi网络
};

/// 网络请求方式 (GET、POST、PUT)
typedef NS_ENUM(NSInteger, XPYNetworkingRequestType) {
    XPYNetworkingRequestTypeGet,
    XPYNetworkingRequestTypePost,
    XPYNetworkingRequestTypeUploadFile,
    XPYNetworkingRequestTypeDownloadFile
};

#pragma mark - 请求参数设置
@protocol XPYNetworkingAPIManagerProtocol <NSObject>

@required
/// API名字
- (NSString *)methodName;

/// API请求类型
- (XPYNetworkingRequestType)requestType;

@optional
/// API请求参数
- (NSDictionary *)requestParams;

/// API请求超时时间
- (NSTimeInterval)timeoutInterval;

/// 响应数据接收类型集合
- (NSSet *)acceptableContentTypes;

/// 是否开启状态栏ActivityIndicator
- (BOOL)networkActivityIndicatorEnable;

/// 是否打印log
- (BOOL)logEnable;

@end

#pragma mark -  服务协议 (请求URL拼接、结果解析)
@protocol XPYNetworkingServiceProtocol <NSObject>

/// 获取完整请求URL
/// @param methodName 方法名
/// @param requestType 请求类型
/// @param params 参数
- (NSString *)requestURLStringWithMethod:(NSString *)methodName
                             requestType:(XPYNetworkingRequestType)requestType
                              parameters:(NSDictionary *)params;


/// 请求结果解析
/// @param responseObjcect 请求结果
/// @param error 错误信息
- (NSDictionary *)resultWithResponse:(id)responseObjcect error:(NSError *)error;

@end

#pragma mark - 请求结果回调
@protocol XPYNetworkingAPIResponseDelegate <NSObject>

/// 请求成功结果返回
/// @param manager XPYNetworkingBaseAPIManager
- (void)networkingAPIResponseDidSuccess:(XPYNetworkingBaseAPIManager *)manager;

/// 请求失败结果返回
/// @param manager XPYNetworkingBaseAPIManager
- (void)networkingAPIResponseDidFail:(XPYNetworkingBaseAPIManager *)manager;

@end

#endif /* XPYNetworkingDefine_h */
