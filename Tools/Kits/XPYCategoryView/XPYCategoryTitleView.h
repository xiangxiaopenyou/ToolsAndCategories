//
//  XPYCategoryTitleView.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/6.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XPYCategoryTitleView;

@interface XPYCategoryTitleViewConfigurations : NSObject
@property (nonatomic, assign) BOOL enableScale;                 //选中是否放大
@property (nonatomic, strong) UIFont *titleFont;                //普通字号
@property (nonatomic, strong) UIFont *selectedTitleFont;        //选中字号（放大倍数=selectedTitleFont/titleFont）
@property (nonatomic, strong) UIColor *normalColor;             //普通颜色
@property (nonatomic, strong) UIColor *selectedColor;           //选中颜色
@property (nonatomic, assign) CGFloat itemSpacing;              //额外间隔
@property (nonatomic, assign) CGFloat extraWidth;               //额外宽度
@property (nonatomic, assign) CGFloat indicatorWidth;           //指示器宽度
@property (nonatomic, assign) CGFloat indicatorHeight;          //指示器高度
@property (nonatomic, assign) CGFloat indicatorBottomSpacing;   //指示器到底部距离
@end

@protocol XPYCategoryTitleViewDelegate<NSObject>

- (void)categoryTitleView:(XPYCategoryTitleView *)titleView didSelectItemAtIndex:(NSInteger)index;

@end

@interface XPYCategoryTitleView : UIView

@property (nonatomic, weak) id<XPYCategoryTitleViewDelegate> delegate;

/**
 初始化

 @param frame frame
 @param titles title数组
 @param configuration 配置信息
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles configuration:(XPYCategoryTitleViewConfigurations *)configuration;

/**
 更新选中和未选中文字颜色

 @param normalColor 未选中颜色
 @param selectedColor 选中颜色
 */
- (void)refreshColors:(UIColor *)normalColor selected:(UIColor *)selectedColor;

/**
 选择指定项

 @param index index
 */
- (void)selectCategoryViewItemWithIndex:(NSInteger)index;

@end
