//
//  XPYCategoryViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/6.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYCategoryViewController.h"
#import "XPYCategoryTitleView.h"
#import "XPYCategoryContentView.h"

@interface XPYCategoryViewController () <XPYCategoryTitleViewDelegate, XPYCategoryContentViewDelegate>

@property (nonatomic, strong) XPYCategoryTitleView *categoryTitleView;
@property (nonatomic, strong) XPYCategoryContentView *categoryContentView;

@end

@implementation XPYCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"分类切换视图";
    XPYCategoryTitleViewConfigurations *configurations = [[XPYCategoryTitleViewConfigurations alloc] init];
    configurations.enableScale = YES;
    configurations.normalColor = [UIColor grayColor];
    configurations.selectedColor = [UIColor blueColor];
    configurations.titleFont = [UIFont systemFontOfSize:17];
    configurations.selectedTitleFont = [UIFont boldSystemFontOfSize:19];
    configurations.indicatorBottomSpacing = 10;
    self.categoryTitleView = [[XPYCategoryTitleView alloc] initWithFrame:CGRectMake(0, 64, CGRectGetWidth(self.view.bounds), 50) titles:@[@"视图一", @"视图二", @"视图三", @"视图四"] configuration:configurations];
    self.categoryTitleView.delegate = self;
    [self.view addSubview:self.categoryTitleView];
    
    UIViewController *controller1 = [[UIViewController alloc] init];
    controller1.view.backgroundColor = [UIColor redColor];
    UIViewController *controller2 = [[UIViewController alloc] init];
    controller2.view.backgroundColor = [UIColor whiteColor];
    UIViewController *controller3 = [[UIViewController alloc] init];
    controller3.view.backgroundColor = [UIColor greenColor];
    UIViewController *controller4 = [[UIViewController alloc] init];
    controller4.view.backgroundColor = [UIColor yellowColor];
    self.categoryContentView = [[XPYCategoryContentView alloc] initWithFrame:CGRectMake(0, 50 + 64, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - 50 - 64) parentController:self controllers:@[controller1, controller2, controller3, controller4]];
    self.categoryContentView.delegate = self;
    [self.view addSubview:self.categoryContentView];
}
- (void)categoryTitleView:(XPYCategoryTitleView *)titleView didSelectItemAtIndex:(NSInteger)index {
    [self.categoryContentView selectPageAtIndex:index];
}
- (void)categoryContentView:(XPYCategoryContentView *)contentView didEndDecelerating:(NSInteger)index {
    [self.categoryTitleView selectCategoryViewItemWithIndex:index];
}

@end
