//
//  XPYPhotosPreviewToolViewHandler.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/18.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <YBIBToolViewHandler.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYPhotosPreviewToolViewHandler : NSObject <YBIBToolViewHandler>

/// 返回闭包
@property (nonatomic, copy) void (^backBlock)(void);

/// 删除图片闭包
@property (nonatomic, copy) void (^deleteBlock)(void);

- (void)hideTopView;

@end

NS_ASSUME_NONNULL_END
