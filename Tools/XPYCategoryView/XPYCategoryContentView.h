//
//  XPYCategoryContentView.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/6.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XPYCategoryContentView;

@protocol XPYCategoryContentViewDelegate <NSObject>
/**
 页面选择动画完成

 @param index index
 */
- (void)categoryContentView:(XPYCategoryContentView *)contentView didEndDecelerating:(NSInteger)index;

@end

@interface XPYCategoryContentView : UIView

@property (nonatomic, weak) id <XPYCategoryContentViewDelegate> delegate;

/**
 Initialization
 
 @param frame frame
 @param parentController 父控制器
 @param viewControllers 子控制器数组
 @return self
 */
- (instancetype)initWithFrame:(CGRect)frame parentController:(UIViewController *)parentController controllers:(NSArray *)viewControllers;


/**
 选中页面
 
 @param index index
 */
- (void)selectPageAtIndex:(NSInteger)index;

@end
