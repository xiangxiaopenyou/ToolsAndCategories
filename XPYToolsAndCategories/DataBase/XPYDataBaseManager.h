//
//  XPYDataBaseManager.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/30.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYDataBaseManager : NSObject

+ (instancetype)sharedInstance;

- (BOOL)createDatabaseWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END
