//
//  XPYNetworkingServiceFactory.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/15.
//  Copyright © 2020 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "XPYNetworkingDefine.h"

NS_ASSUME_NONNULL_BEGIN

@interface XPYNetworkingServiceFactory : NSObject

+ (instancetype)sharedInstance;

/// 根据identifier获取网络服务
/// @param identifier XPYNetworkingServiceIdentifier
- (id <XPYNetworkingServiceProtocol>)networkingServiceWithIdentifier:(NSString *)identifier;

@end

NS_ASSUME_NONNULL_END
