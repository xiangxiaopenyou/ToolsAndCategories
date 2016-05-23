//
//  XLNoticeHelper.m
//  MiYo
//
//  Created by 项小盆友 on 16/3/20.
//  Copyright © 2016年 项小盆友. All rights reserved.
//

#import "XLNoticeHelper.h"
@interface XLNoticeHelper()
@property (strong, nonatomic) UILabel *noticeLabel;
@end

@implementation XLNoticeHelper
+ (instancetype)singleInstance {
    static XLNoticeHelper *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _noticeLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 20)];
        _noticeLabel.font = [UIFont systemFontOfSize:13];
        _noticeLabel.textColor = [UIColor whiteColor];
        _noticeLabel.textAlignment = NSTextAlignmentCenter;
        _noticeLabel.backgroundColor = [UIColor colorWithWhite:0.191 alpha:0.700];
    }
    return self;
}
+ (void)showNoticeAtView:(UIView *)view message:(NSString *)message {
    [self showNoticeAtView:view positionY:0 message:message];
}
+ (void)showNoticeAtViewController:(UIViewController *)viewController message:(NSString *)message {
    UIView *showingView;
    BOOL isTableViewController = [viewController isKindOfClass:[UITableViewController class]];
    if (isTableViewController) {
        showingView = viewController.view.superview;
    } else {
        showingView = viewController.view;
    }
    
    if (viewController.navigationController && !viewController.navigationController.navigationBarHidden /*&& [viewControlelr respondsToSelector:@selector(edgesForExtendedLayout)] && viewControlelr.edgesForExtendedLayout == UIRectEdgeNone*/) {
        [self showNoticeAtView:showingView positionY:64 - CGRectGetMinY(showingView.frame) message:message];
    } else {
        [self showNoticeAtView:showingView positionY:0 message:message];
    }
}
+ (void)showNoticeAtView:(UIView *)view positionY:(CGFloat)y message:(NSString *)message {
    XLNoticeHelper *helper = [XLNoticeHelper singleInstance];
    if (helper.noticeLabel.superview) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [XLNoticeHelper showNoticeAtView:view positionY:y message:message];
        });
    } else {
        helper.noticeLabel.frame = CGRectMake(0, y, CGRectGetWidth([UIScreen mainScreen].bounds), 20);
        helper.noticeLabel.text = message;
        [view addSubview:helper.noticeLabel];
        
        [UIView animateWithDuration:0.3 delay:1.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
            helper.noticeLabel.alpha = 0.0;
        } completion:^(BOOL finished) {
            [helper.noticeLabel removeFromSuperview];
            helper.noticeLabel.alpha = 1.0;
        }];
    }
}
@end
