//
//  XPYDownloadAPIManager.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/18.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYDownloadAPIManager.h"

@implementation XPYDownloadAPIManager

- (NSString *)methodName {
    return nil;
}

- (XPYNetworkingRequestType)requestType {
    return XPYNetworkingRequestTypeDownloadFile;
}

- (NSString *)serviceIdentifier {
    return @"XPYNetworkingService";
}

- (NSString *)dowloadFileDirectory {
    return @"voice.zip";
}

@end
