//
//  XPYPhotosPreviewToolViewHandler.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/18.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYPhotosPreviewToolViewHandler.h"
#import "XPYUtilitiesDefine.h"

@interface XPYPhotosPreviewToolViewHandler ()
@property (nonatomic, strong) UIView *viewOfTop;
@property (nonatomic, strong) UILabel *photosNumberLabel;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation XPYPhotosPreviewToolViewHandler

@synthesize yb_containerView = _yb_containerView;
@synthesize yb_currentPage = _yb_currentPage;
@synthesize yb_totalPage = _yb_totalPage;

#pragma mark - Override methods
- (void)yb_containerViewIsReadied {
    [self.yb_containerView addSubview:self.viewOfTop];
    [self.viewOfTop addSubview:self.photosNumberLabel];
    [self.viewOfTop addSubview:self.backButton];
    [self.viewOfTop addSubview:self.deleteButton];
}
- (void)yb_pageChanged {
    self.photosNumberLabel.text = [NSString stringWithFormat:@"%@/%@", @(self.yb_currentPage() + 1), @(self.yb_totalPage())];
}

- (void)yb_hide:(BOOL)hide {
}

#pragma mark - Instance methods
- (void)hideTopView {
    if (self.viewOfTop.hidden) {
        self.viewOfTop.hidden = NO;
        [UIView animateWithDuration:0.1 animations:^{
            self.viewOfTop.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), XPYDeviceIsIphoneX ? 88 : 64);
        } completion:^(BOOL finished) {
        }];
    } else {
        [UIView animateWithDuration:0.1 animations:^{
            self.viewOfTop.frame = CGRectMake(0, XPYDeviceIsIphoneX ? - 88 : - 64, CGRectGetWidth([UIScreen mainScreen].bounds), XPYDeviceIsIphoneX ? 88 : 64);
        } completion:^(BOOL finished) {
            self.viewOfTop.hidden = YES;
        }];
    }
}

#pragma mark - Actions
- (void)backAction {
    if (self.backBlock) {
        self.backBlock();
    }
}
- (void)deleteAction {
    if (self.deleteBlock) {
        self.deleteBlock();
    }
}

#pragma mark - Getters
- (UIView *)viewOfTop {
    if (!_viewOfTop) {
        _viewOfTop = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), XPYDeviceIsIphoneX ? 88 : 64)];
        _viewOfTop.backgroundColor = [UIColor redColor];
    }
    return _viewOfTop;
}
- (UILabel *)photosNumberLabel {
    if (!_photosNumberLabel) {
        _photosNumberLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) / 2.0 - 100, XPYDeviceIsIphoneX ? 44 : 20, 200, 44)];
        _photosNumberLabel.textColor = [UIColor blackColor];
        _photosNumberLabel.font = [UIFont systemFontOfSize:16];
        _photosNumberLabel.textAlignment = NSTextAlignmentCenter;
        _photosNumberLabel.text = [NSString stringWithFormat:@"%@/%@", @(self.yb_currentPage() + 1), @(self.yb_totalPage())];
    }
    return _photosNumberLabel;
}
- (UIButton *)backButton {
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.frame = CGRectMake(0, XPYDeviceIsIphoneX ? 44 : 20, 44, 44);
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _backButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backButton;
}
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(CGRectGetWidth([UIScreen mainScreen].bounds) - 44, XPYDeviceIsIphoneX ? 44 : 20, 44, 44);
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}

@end
