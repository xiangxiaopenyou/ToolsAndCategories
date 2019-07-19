//
//  XPYBaseNavigationController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/6/27.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYBaseNavigationController.h"

@interface XPYBaseNavigationController ()

@end

@implementation XPYBaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


/**
 如果push到第一个页面则设置hidesBottomBarWhenPushed = YES隐藏TabBar

 @param viewController push目标控制器
 @param animated YES
 */
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSInteger count = self.childViewControllers.count;
    if (count == 1) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
