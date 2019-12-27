//
//  XPYCircleProgressViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/12/26.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYCircleProgressViewController.h"

@interface XPYCircleProgressViewController ()

@end

@implementation XPYCircleProgressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    UIView *circleView = [[UIView alloc] init];
//    circleView.translatesAutoresizingMaskIntoConstraints = NO;
//    [self.view addSubview:circleView];
//    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:circleView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
//    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:circleView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
//    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:circleView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200];
//    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:circleView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:200];
//    [circleView addConstraints:@[widthConstraint, heightConstraint]];
//    [self.view addConstraints:@[centerXConstraint, centerYConstraint]];
    
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(150, 300) radius:100 startAngle:M_PI_2 endAngle:M_PI_2 + 2 * M_PI clockwise:YES];
    
    CAShapeLayer *circleLayer = [CAShapeLayer layer];
    circleLayer.lineWidth = 10;
    //端点类型
    circleLayer.lineCap = kCALineCapRound;
    //衔接类型
    circleLayer.lineJoin = kCALineJoinRound;
    circleLayer.strokeColor = [UIColor yellowColor].CGColor;
    circleLayer.fillColor = [UIColor clearColor].CGColor;
    circleLayer.path = circlePath.CGPath;
    
    CABasicAnimation *circleAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    circleAnimation.fromValue = @0;
    circleAnimation.toValue = @1;
    circleAnimation.duration = 5;
    
    [self.view.layer addSublayer:circleLayer];
    [circleLayer addAnimation:circleAnimation forKey:nil];
    
}

@end
