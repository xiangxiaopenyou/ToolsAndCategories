//
//  XLBlockActionSheet.h
//  MiYo
//
//  Created by 项小盆友 on 16/4/12.
//  Copyright © 2016年 项小盆友. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ClickedBlock) (NSInteger buttonIndex);

@interface XLBlockActionSheet : UIActionSheet
- (instancetype)initWithTitle:(NSString *)title clickedBlock:(ClickedBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
