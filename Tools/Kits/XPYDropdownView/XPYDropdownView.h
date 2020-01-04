//
//  XPYDropdownView.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/2.
//  Copyright © 2020 xpy. All rights reserved.
//

/// 说明：
/// arrowPoint为手动传入的点，可取点击的位置，也可以随意设置位置，箭头总指向这个点
/// 菜单的位置根据arrowPoint和configurations.arrowOriginX决定

#import <UIKit/UIKit.h>

@class XPYDropdownView, XPYDropdownConfigurations, XPYDropdownItemModel;

NS_ASSUME_NONNULL_BEGIN

@protocol XPYDropdownViewDelegate <NSObject>

- (void)dropdownView:(XPYDropdownView *)sender didClickItem:(XPYDropdownItemModel *)model;

@end

@interface XPYDropdownView : UIView

/// Initializer
/// @param itemsArray XPYDropdownItemModel数组
/// @param configurations 配置
/// @param point 箭头指向点
- (instancetype)initWithItemsArray:(NSArray <XPYDropdownItemModel *> *)itemsArray
                    configurations:(XPYDropdownConfigurations *)configurations
                        arrowPoint:(CGPoint)point;

/// 显示菜单
- (void)show;

@property (nonatomic, weak) id<XPYDropdownViewDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
