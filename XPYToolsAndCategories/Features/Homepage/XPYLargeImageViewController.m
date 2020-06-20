//
//  XPYLargeImageViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/6/20.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYLargeImageViewController.h"

@interface XPYLargeImageViewController ()

@property (nonatomic, strong) UIImageView *largeImageView;

@end

@implementation XPYLargeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.largeImageView];
    
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self.largeImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:self.largeImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self.largeImageView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.image.size.width];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self.largeImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:self.image.size.height];
    [self.largeImageView addConstraints:@[widthConstraint, heightConstraint]];
    [self.view addConstraints:@[centerXConstraint, centerYConstraint]];
}

/// 设置当面页面预览大小
- (CGSize)preferredContentSize {
    return CGSizeMake(self.image.size.width, self.image.size.height);
}

/// 设置上滑快捷菜单
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    UIPreviewAction *saveAction = [UIPreviewAction actionWithTitle:@"保存图片" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了保存图片");
    }];
    UIPreviewAction *deleteAction = [UIPreviewAction actionWithTitle:@"删除图片" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"点击了删除图片");
    }];
    return @[saveAction, deleteAction];
}

#pragma mark - Getters
- (UIImageView *)largeImageView {
    if (!_largeImageView) {
        _largeImageView = [[UIImageView alloc] init];
        _largeImageView.image = self.image;
        _largeImageView.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _largeImageView;
}

@end
