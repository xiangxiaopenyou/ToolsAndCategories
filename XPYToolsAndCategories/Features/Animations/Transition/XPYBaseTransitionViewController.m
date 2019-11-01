//
//  XPYBaseTransitionViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/10/29.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYBaseTransitionViewController.h"
#import "XPYPushAnimation.h"
#import "XPYPopAnimation.h"

@interface XPYBaseTransitionViewController () <UINavigationControllerDelegate, UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactiveTransition;

@end

@implementation XPYBaseTransitionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pan];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.delegate = nil;
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    //开始位置
    CGFloat postionX = [pan locationInView:self.view].x;
    if (postionX > 100) {    //触摸开始位置设置在100以内
        return;
    }
    //滑动百分比
    CGFloat progress = [pan translationInView:self.view].x / CGRectGetWidth(self.view.bounds);
    progress = MIN(1.0,(MAX(0.0, progress)));
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.interactiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        [self.interactiveTransition updateInteractiveTransition:progress];
    } else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) {
        if (progress > 0.4) {
            [self.interactiveTransition finishInteractiveTransition];
        } else {
            [self.interactiveTransition cancelInteractiveTransition];
        }
        self.interactiveTransition = nil;
    }
}

#pragma mark - Navigation controller delegate
- (id<UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (operation == UINavigationControllerOperationPop) {
        return [[XPYPopAnimation alloc] init];
    } else if (operation == UINavigationControllerOperationPush) {
        return [[XPYPushAnimation alloc] init];
    }
    return nil;
}
- (id<UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id<UIViewControllerAnimatedTransitioning>)animationController {
    if ([animationController isKindOfClass:[XPYPopAnimation class]]) {
        return self.interactiveTransition;
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
