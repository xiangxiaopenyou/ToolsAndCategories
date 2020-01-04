//
//  XPYDropdownItemModel.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/3.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYDropdownItemModel.h"

@implementation XPYDropdownItemModel

+ (instancetype)makeModel:(NSInteger)index
                     icon:(UIImage *)icon
                    title:(NSString *)title
               titleColor:(UIColor *)titleColor {
    XPYDropdownItemModel *model = [[XPYDropdownItemModel alloc] init];
    model.itemIndex = index;
    model.itemIcon = icon;
    model.itemTitle = title;
    model.itemTitleColor = titleColor;
    if (!title) {
        model.cellStyle = XPYDropdownCellStyleIcon;
    } else if (!icon) {
        model.cellStyle = XPYDropdownCellStyleTitle;
    } else {
        model.cellStyle = XPYDropdownCellStyleIconAndTitle;
    }
    return model;
}

@end
