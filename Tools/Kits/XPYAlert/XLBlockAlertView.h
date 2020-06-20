//
//  XLBlockAlertView.h
//  MiYo
//
//  Created by 项小盆友 on 16/4/6.
//  Copyright © 2016年 项小盆友. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickedBlock) (NSInteger buttonIndex);

@interface XLBlockAlertView : UIAlertView
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message block:(ClickedBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message block:(ClickedBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtontTitle:(NSString *)otherButtontTitle;

@end
