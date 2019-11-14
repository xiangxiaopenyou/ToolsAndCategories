//
//  XPYDataBaseManager.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/30.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYDataBaseManager.h"

#import <FMDB.h>

@implementation XPYDataBaseManager
+ (instancetype)sharedInstance {
    static XPYDataBaseManager *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[XPYDataBaseManager alloc] init];
    });
    return instance;
}

- (BOOL)createDatabaseWithName:(NSString *)name {
//    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
//    path = [path stringByAppendingPathComponent:name];
//
//
//    FMDatabase *dataBase = [FMDatabase alloc] initWithPath:<#(NSString * _Nullable)#>
    return NO;
}

@end
