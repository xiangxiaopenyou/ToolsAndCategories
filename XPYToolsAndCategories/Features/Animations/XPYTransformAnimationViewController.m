//
//  XPYTransformAnimationViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/7/19.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYTransformAnimationViewController.h"

@interface XPYTransformAnimationViewController ()

@end

@implementation XPYTransformAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    animationView.backgroundColor = [UIColor redColor];
    [self.view addSubview:animationView];
    [self addAnimationsWithView:animationView];
}

- (void)addAnimationsWithView:(UIView *)view {
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    moveAnimation.duration = 2.f;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:moveAnimation forKey:@"position"];
    
    //    CABasicAnimation *rotationYAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    //    rotationYAnimation.fromValue = [NSNumber numberWithFloat:0];
    //    rotationYAnimation.toValue = [NSNumber numberWithFloat:M_PI];
    //    rotationYAnimation.duration = 2.f;
    //    rotationYAnimation.removedOnCompletion = NO;
    //    rotationYAnimation.fillMode = kCAFillModeForwards;
    //    rotationYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    //    rotationYAnimation.repeatCount = 10;
    //    [view.layer addAnimation:rotationYAnimation forKey:nil];
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
