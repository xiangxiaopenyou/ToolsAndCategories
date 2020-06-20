//
//  XPYTouchToEnlargeView.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/6/18.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYTouchToEnlargeView.h"
#import "XPYEnlargeViewManager.h"

/// 显示大图页面半透明背景点击力度
static CGFloat const kXPYShowAlphaViewForce = 3.f;
/// 显示大图所需点击力度，kXPYShowAlphaViewForce到kXPYShowLargeViewForce之间的力度值逐渐改变大图页面背景透明度
static CGFloat const kXPYShowLargeViewForce = 4.f;

@interface XPYTouchToEnlargeView () <UIGestureRecognizerDelegate>

/// 当前小图
@property (nonatomic, strong) UIImageView *smallImageView;

/// 点击开始点
@property (nonatomic, assign) CGPoint begenPoint;

@end

@implementation XPYTouchToEnlargeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.smallImageView];
    }
    return self;
}

#pragma mark - Private methods
- (void)endTouch {
    if (![XPYEnlargeViewManager sharedManager].isShowingMenu) {
        // 如果没有显示大图页菜单，则直接dismiss
        [[XPYEnlargeViewManager sharedManager] dismiss];
        return;
    }
    // 如果已经显示大图页菜单，则调整大图位置
    [[XPYEnlargeViewManager sharedManager] updateLargeImageOriginY:0];
}

#pragma mark - UIResponder methods
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    // 记录开始触摸点位置
    self.begenPoint = [touch locationInView:self];
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    // 当前点击力度
    CGFloat currentForce = touch.force;
    NSLog(@"%@, %@", @(touch.force), @(touch.maximumPossibleForce));
    if (currentForce >= kXPYShowAlphaViewForce && currentForce < kXPYShowLargeViewForce && ![XPYEnlargeViewManager sharedManager].isShowingLargeImage) {
        if (![XPYEnlargeViewManager sharedManager].isShowingTranslucentBackground) {
            // 没有显示半透明背景，则先显示半透明背景
            // 获取需要放大图片在KeyWindow中的位置
            CGRect rect = [self convertRect:self.bounds toView:[UIApplication sharedApplication].delegate.window];
            [[XPYEnlargeViewManager sharedManager] showTranslucentBackgroundWithOriginImage:self.smallImageView.image imageFrame:rect];
        } else {
            // 已经显示半透明背景，则更新背景透明度
            CGFloat changedForce = currentForce - kXPYShowAlphaViewForce;
            [[XPYEnlargeViewManager sharedManager] updateTranslucentBackgroundWithAlpha:changedForce * 0.5];
        }
    }
    if (touch.force > kXPYShowLargeViewForce && ![XPYEnlargeViewManager sharedManager].isShowingLargeImage) { // 需要显示大图
        // 展示大图，传入位置和图片(图片与当前imageView的图片一致)
        [[XPYEnlargeViewManager sharedManager] enlargeImage];
    } else if ([XPYEnlargeViewManager sharedManager].isShowingLargeImage) {
        CGPoint currentPoint = [touch locationInView:self];
        CGFloat changedY = currentPoint.y - self.begenPoint.y;
        [[XPYEnlargeViewManager sharedManager] updateLargeImageOriginY:changedY];
        if (changedY < - 50) {  // 需要显示大图页菜单
            
        }
    }
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endTouch];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self endTouch];
}

#pragma mark - Getters
- (UIImageView *)smallImageView {
    if (!_smallImageView) {
        _smallImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"enlarge_test"]];
        _smallImageView.frame = self.bounds;
        _smallImageView.contentMode = UIViewContentModeScaleAspectFill;
        _smallImageView.clipsToBounds = YES;
    }
    return _smallImageView;
}
@end
