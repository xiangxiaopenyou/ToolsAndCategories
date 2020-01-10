//
//  XPYDropdownConfigurations.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/2.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYDropdownConfigurations.h"

#pragma mark - Initializer
@implementation XPYDropdownConfigurations
- (instancetype)init {
    self = [super init];
    if (self) {
        self.mainBackgroundColor = [UIColor clearColor];
        self.dropdownBackgroundColor = [UIColor whiteColor];
        self.separatorColor = [UIColor grayColor];
        self.isHiddenSeparator = NO;
        self.cellHeight = 50.f;
        self.dropdownWidth = 150.f;
        self.cornerRadius = 5.f;
        self.arrowWidth = 12.f;
        self.arrowHeight = 8.f;
        self.arrowOriginX = 130.f;
        self.titleFont = [UIFont systemFontOfSize:14];
        self.titleColor = [UIColor blackColor];
        self.separatorEdgeInsets = UIEdgeInsetsMake(0, 15, 0, 15);
        self.isAddShadow = NO;
    }
    return self;
}

@end
