//
//  XPYEnlargeViewManager.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/6/19.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYEnlargeViewManager.h"

#define kXPYKeyWindow [UIApplication sharedApplication].delegate.window

@interface XPYEnlargeViewManager ()

@property (nonatomic, strong) UIImageView *largeImageView;

/// 图片初始位置
@property (nonatomic, assign) CGRect originFrame;

/// 放大图片后的位置
@property (nonatomic, assign) CGRect targetFrame;

@property (nonatomic, assign) BOOL isShowingTranslucentBackground;

@property (nonatomic, assign) BOOL isShowingLargeImage;

@property (nonatomic, assign) BOOL isShowingMenu;

@end

@implementation XPYEnlargeViewManager

+ (instancetype)sharedManager {
    static XPYEnlargeViewManager *view = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        view = [[XPYEnlargeViewManager alloc] init];
    });
    return view;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = kXPYKeyWindow.bounds;
        // 暂时固定放大后图片位置
        self.targetFrame = CGRectMake(30, CGRectGetHeight(kXPYKeyWindow.bounds) / 2.0 - 150, CGRectGetWidth(kXPYKeyWindow.bounds) - 60, 300);
        _isShowingTranslucentBackground = NO;
        _isShowingLargeImage = NO;
        _isShowingMenu = NO;
    }
    return self;
}

#pragma mark - Instance methods
- (void)showTranslucentBackgroundWithOriginImage:(UIImage *)image imageFrame:(CGRect)frame {
    self.originFrame = frame;
    self.largeImageView.image = image;
    // 暂定背景颜色（带透明度）
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0];
    [self addSubview:self.largeImageView];
    [kXPYKeyWindow addSubview:self];
    _isShowingTranslucentBackground = YES;
}
- (void)updateTranslucentBackgroundWithAlpha:(CGFloat)alpha {
    self.backgroundColor = [UIColor colorWithWhite:0.5 alpha:alpha];
}
- (void)enlargeImage {
    _isShowingLargeImage = YES;
    // 放大图片动画
    [UIView animateWithDuration:0.5 animations:^{
        self.largeImageView.frame = self.targetFrame;
    } completion:^(BOOL finished) {
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.largeImageView.frame = self.originFrame;
    } completion:^(BOOL finished) {
        // 动画完成移除控件
        [self.largeImageView removeFromSuperview];
        self.largeImageView = nil;
        [self removeFromSuperview];
        self.isShowingTranslucentBackground = NO;
        self.isShowingLargeImage = NO;
        self.isShowingMenu = NO;
    }];
}
- (void)updateLargeImageOriginY:(CGFloat)changedY {
    CGRect changedFrame = CGRectMake(CGRectGetMinX(self.targetFrame), CGRectGetMinY(self.targetFrame) + changedY, CGRectGetWidth(self.targetFrame), CGRectGetHeight(self.targetFrame));
    self.largeImageView.frame = changedFrame;
}

#pragma mark - Getters
- (UIImageView *)largeImageView {
    if (!_largeImageView) {
        _largeImageView = [[UIImageView alloc] initWithFrame:self.originFrame];
        _largeImageView.contentMode = UIViewContentModeScaleAspectFill;
        _largeImageView.clipsToBounds = YES;
    }
    return _largeImageView;
}

@end
