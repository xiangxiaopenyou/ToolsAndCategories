//
//  XPYDropdownCell.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/3.
//  Copyright © 2020 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XPYDropdownConfigurations;
@class XPYDropdownItemModel;

NS_ASSUME_NONNULL_BEGIN

@interface XPYDropdownCell : UITableViewCell

- (void)setupItem:(XPYDropdownItemModel *)model config:(XPYDropdownConfigurations *)config;

@end

NS_ASSUME_NONNULL_END
