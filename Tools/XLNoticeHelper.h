//
//  XLNoticeHelper.h
//  MiYo
//
//  Created by 项小盆友 on 16/3/20.
//  Copyright © 2016年 项小盆友. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface XLNoticeHelper : NSObject
+ (void)showNoticeAtView:(UIView *)view message:(NSString *)message;
+ (void)showNoticeAtViewController:(UIViewController *)viewController message:(NSString *)message;
+ (void)showNoticeAtView:(UIView *)view positionY:(CGFloat)y message:(NSString *)message;

@end
