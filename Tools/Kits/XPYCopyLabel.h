//
//  XPYCopyLabel.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/21.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYCopyLabel : UILabel


/// 是否可以长按复制，默认可以复制
@property (nonatomic, assign) BOOL isCanCopy;

/// 选中时背景颜色
@property (nonatomic, strong) UIColor *selelctedBackgroundColor;

@end

NS_ASSUME_NONNULL_END
