//
//  XPYEnlargeImageViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/6/18.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYEnlargeImageViewController.h"
#import "XPYLargeImageViewController.h"
// #import "XPYTouchToEnlargeView.h"

@interface XPYEnlargeImageViewController () <UIViewControllerPreviewingDelegate>

//@property (nonatomic, strong) XPYTouchToEnlargeView *touchView;
@property (nonatomic, strong) UIImageView *touchView;

@end

@implementation XPYEnlargeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"按压图片放大";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.touchView];
    
    // 判断设备是否支持3D Touch，如果支持则设置代理
    if ([self respondsToSelector:@selector(traitCollection)]) {
        if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
            if (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable) {
                [self registerForPreviewingWithDelegate:(id)self sourceView:self.touchView];
            }
        }
    }
}

#pragma mark - UIViewControllerPreviewingDelegate

/// 监听3D Touch手势的触发
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    XPYLargeImageViewController *largeController = [[XPYLargeImageViewController alloc] init];
    largeController.image = self.touchView.image;
    previewingContext.sourceRect = self.touchView.bounds;
    return largeController;
}
/// 实现跳转
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self showViewController:viewControllerToCommit sender:self];
}

- (UIImageView *)touchView {
    if (!_touchView) {
        _touchView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
        _touchView.image = [UIImage imageNamed:@"enlarge_test"];
        _touchView.userInteractionEnabled = YES;
        _touchView.contentMode = UIViewContentModeScaleAspectFill;
        _touchView.clipsToBounds = YES;
    }
    return _touchView;
}

@end
