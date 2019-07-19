//
//  XPYAnimationGroupsViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/7/19.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYAnimationGroupsViewController.h"

@interface XPYAnimationGroupsViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation XPYAnimationGroupsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addAnimation];
}

- (void)addAnimation {
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(100, 100)];
    [bezierPath addCurveToPoint:CGPointMake(150, 400) controlPoint1:CGPointMake(120, 200) controlPoint2:CGPointMake(180, 300)];
    
    //CAShapeLayer *pathLayer = [CAShapeLayer layer];
    //pathLayer.path = bezierPath.CGPath;// 绘制路径
    //pathLayer.strokeColor = [UIColor redColor].CGColor;// 轨迹颜色
    //pathLayer.fillColor = [UIColor whiteColor].CGColor;// 填充颜色
    //pathLayer.lineWidth = 5.0f; // 线宽
    
    CAKeyframeAnimation *pathAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    pathAnimation.fillMode = kCAFillModeForwards;
    pathAnimation.removedOnCompletion = NO;// 是否在动画完成后从 Layer 层上移除
//    pathAnimation.duration = 1.0f;// 动画时间
//    pathAnimation.repeatCount = 10;// 动画重复次数
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    pathAnimation.path = bezierPath.CGPath;
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue = @1;
    opacityAnimation.toValue = @0;
//    opacityAnimation.duration = 3.0f;
//    opacityAnimation.repeatCount = 10;
    opacityAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = @[pathAnimation, opacityAnimation];
    animationGroup.duration = 3.f;
    animationGroup.repeatCount = 10;
    
    [self.view addSubview:self.imageView]; // 添加控件
    [self.imageView.layer addAnimation:animationGroup forKey:nil ];// 添加动画
    
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 85, 30, 30)];
        _imageView.image = [UIImage imageNamed:@"like"];
    }
    return _imageView;
}

@end
