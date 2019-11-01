//
//  XPYFileManager.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/1.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYFileManager : NSObject

+ (NSFileManager *)sharedManager;

/// 根据关键字获得文件路径
/// @param key 关键字
+ (NSString *)cacheFilePathWithKey:(NSString *)key;

///创建缓存路径
/// @param filePath 文件路径
+ (BOOL)createCacheDirectoryWithFilePath:(NSString *)filePath;

/// 保存文件
/// @param filePath 文件路径
+ (BOOL)saveFile:(NSData *)fileData toPath:(NSString *)filePath;

/// 获取文件数据
/// @param filePath 文件路径
+ (NSData *)dataWithFilePath:(NSString *)filePath;

/// 删除文件
/// @param filePath 文件路径
+ (BOOL)removeFileWithPath:(NSString *)filePath;

@end

NS_ASSUME_NONNULL_END
