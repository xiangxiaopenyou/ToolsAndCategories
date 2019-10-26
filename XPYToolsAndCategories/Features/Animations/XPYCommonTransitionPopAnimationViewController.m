//
//  XPYCommonTransitionPopAnimationViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/10/26.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYCommonTransitionPopAnimationViewController.h"
#import "XPYPopAnimation.h"

@interface XPYCommonTransitionPopAnimationViewController () <UINavigationControllerDelegate>

@end

@implementation XPYCommonTransitionPopAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"普通Pop动画";
    self.view.backgroundColor = [UIColor greenColor];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

#pragma mark - Navigation controller delegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return [[XPYPopAnimation alloc] init];
    }
    return nil;
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
