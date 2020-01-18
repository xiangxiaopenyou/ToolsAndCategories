//
//  XPYNetworkingBaseAPIManager.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/9.
//

#import <Foundation/Foundation.h>
#import "XPYNetworkingDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface XPYNetworkingBaseAPIManager : NSObject

/// 会用到NSObject的方法，所以不用id
@property (nonatomic, weak) NSObject <XPYNetworkingAPIManagerProtocol> *child;
@property (nonatomic, weak) id <XPYNetworkingAPIResponseDelegate> responseDelegate;

@property (nonatomic, strong) id responseObject;
@property (nonatomic, strong) NSError *responseError;
@property (nonatomic, strong) NSProgress *responseProgress;

/// 唯一开始请求方法
- (void)requestData;

/// 取消所有网络请求
- (void)cancelAllRequests;

/// 取消指定网络请求
/// @param urlString 请求链接
- (void)cancelRequestWithURLString:(NSString *)urlString;

@end

NS_ASSUME_NONNULL_END
