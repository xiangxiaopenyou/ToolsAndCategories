//
//  XPYFileManager.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/1.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYFileManager.h"

@implementation XPYFileManager

+ (NSFileManager *)sharedManager {
    return [NSFileManager defaultManager];
}

+ (NSString *)cacheFilePathWithKey:(NSString *)key {
    NSString *cachePathString = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:[NSString stringWithUTF8String:[key UTF8String]]];
    return cachePathString;
}

+ (BOOL)createCacheDirectoryWithFilePath:(NSString *)filePath {
    if ([[self sharedManager] fileExistsAtPath:filePath]) {
        return YES;
    }
    NSError *error = nil;
    BOOL success = [[self sharedManager] createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:&error];
    return success;
}

+ (BOOL)saveFile:(NSData *)fileData toPath:(NSString *)filePath {
    if (!fileData || fileData.length <= 0 || !filePath) {
        return NO;
    }
    if ([[self sharedManager] fileExistsAtPath:filePath]) { //文件已经存在
        return YES;
    }
    return [fileData writeToFile:filePath atomically:YES];
}

+ (NSData *)dataWithFilePath:(NSString *)filePath {
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    return fileData;
}

+ (BOOL)removeFileWithPath:(NSString *)filePath {
    if ([[self sharedManager] fileExistsAtPath:filePath]) {
        NSError *error = nil;
        return [[self sharedManager] removeItemAtPath:filePath error:&error];
    }
    return NO;
}
@end
