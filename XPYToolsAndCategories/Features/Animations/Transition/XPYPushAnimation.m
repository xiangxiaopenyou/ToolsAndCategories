//
//  XPYPushAnimation.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/10/12.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYPushAnimation.h"

@implementation XPYPushAnimation
//动画时间
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 1;
}
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *fromView = nil;
    UIView *toView = nil;
    if ([transitionContext respondsToSelector:@selector(viewForKey:)]) {    //iOS8
        fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    } else {
        fromView = fromController.view;
        toView = toController.view;
    }
    
    //toView加入到containerView中（fromView本来就在containerView中）
    [transitionContext.containerView addSubview:toView];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    //CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    
    //toView.frame = CGRectMake(width, 0, width, height);
    toView.transform = CGAffineTransformMakeTranslation(width, 0);
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        //toView.frame = CGRectMake(0, 0, width, height);
        fromView.transform = CGAffineTransformMakeScale(0.8, 0.8);
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:![transitionContext transitionWasCancelled]];
    }];
}

@end
