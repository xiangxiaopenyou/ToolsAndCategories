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

/// 网络服务Identifier
- (NSString *)serviceIdentifier;

@optional
/// API请求参数
- (NSDictionary *)requestParams;

/// 文件上传对应服务器上的字段，当XPYNetworkingRequestTypeUploadFile时不能为空
- (NSString *)bucketName;

/// 文件路径，当XPYNetworkingRequestTypeUploadFile时不能为空
- (NSString *)filePath;

/// 下载文件保存文件夹，默认为Download
- (NSString *)dowloadFileDirectory;

/// API请求超时时间
- (NSTimeInterval)timeoutInterval;

/// 响应数据接收类型集合
- (NSSet *)acceptableContentTypes;

/// 是否开启状态栏ActivityIndicator
- (BOOL)networkActivityIndicatorEnable;

/// 是否打印log
- (BOOL)logEnable;

@end

#pragma mark - 请求服务（获取完整链接、解析结果）
@protocol XPYNetworkingServiceProtocol <NSObject>

/// 获取完整请求链接（为了拼接baseURL和接口方法名）
/// @param methodName 接口方法名
- (NSString *)requestURLStringWithMethod:(NSString *)methodName requestType:(XPYNetworkingRequestType)type;

/// 获取完整的请求参数（为了拼接统一参数，如UserID、Token）
/// @param params 参数
- (NSDictionary *)completedParametersWithParams:(NSDictionary *)params;

/// 解析responseObject
/// @param responseObject 请求成功结果统一解析
- (id)resultWithResponseObject:(id)responseObject;

@end

#pragma mark - 请求结果回调
@protocol XPYNetworkingAPIResponseDelegate <NSObject>

/// 请求成功结果返回
/// @param manager XPYNetworkingBaseAPIManager
- (void)networkingAPIResponseDidSuccess:(XPYNetworkingBaseAPIManager *)manager;

/// 请求失败结果返回
/// @param manager XPYNetworkingBaseAPIManager
- (void)networkingAPIResponseDidFail:(XPYNetworkingBaseAPIManager *)manager;

@optional

/// 请求进度
/// @param manager XPYNetworkingBaseAPIManager
- (void)networkingAPIResponseProgress:(XPYNetworkingBaseAPIManager *)manager;

@end

#endif /* XPYNetworkingDefine_h */
