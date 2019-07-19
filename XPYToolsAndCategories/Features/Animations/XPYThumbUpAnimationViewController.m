//
//  XPYThumbUpAnimationViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/6/27.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYThumbUpAnimationViewController.h"

@interface XPYThumbUpAnimationViewController ()
@property (weak, nonatomic) IBOutlet UIButton *likeButton;

@end

@implementation XPYThumbUpAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}
- (IBAction)likeAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    if (button.selected) {
        button.selected = NO;
    } else {
        button.selected = YES;
//        CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
//        scaleAnimation.toValue = @(2.0);
//        scaleAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//        scaleAnimation.duration = 0.3;
//        [button.layer addAnimation:scaleAnimation forKey:@"scale"];
        
        CAKeyframeAnimation *scaleKeyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
        scaleKeyframeAnimation.values = @[@(2.0), @(1.0)];
        scaleKeyframeAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        scaleKeyframeAnimation.duration = 0.6;
        scaleKeyframeAnimation.keyTimes = @[@(0.2), @(1)];
        [button.layer addAnimation:scaleKeyframeAnimation forKey:@"scale"];
    }
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
