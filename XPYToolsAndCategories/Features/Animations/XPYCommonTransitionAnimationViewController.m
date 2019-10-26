//
//  XPYCommonTransitionAnimationViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/10/12.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYCommonTransitionAnimationViewController.h"
#import "XPYCommonTransitionPopAnimationViewController.h"
#import "XPYPushAnimation.h"

@interface XPYCommonTransitionAnimationViewController () <UINavigationControllerDelegate>

@end

@implementation XPYCommonTransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"普通转场动画";
    
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushButton setTitle:@"push" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    pushButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pushButton];
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    [pushButton addConstraints:@[widthConstraint, heightConstraint]];
    [self.view addConstraints:@[centerXConstraint, centerYConstraint]];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

#pragma mark - Action
- (void)pushAction:(UIButton *)button {
    XPYCommonTransitionPopAnimationViewController *popController = [[XPYCommonTransitionPopAnimationViewController alloc] init];
    [self.navigationController pushViewController:popController animated:YES];
}

#pragma mark - Navigation controller delegate
//指定自定义动画类
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPush) {
        return [[XPYPushAnimation alloc] init];
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
