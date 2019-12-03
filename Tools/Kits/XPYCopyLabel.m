//
//  XPYCopyLabel.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/21.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYCopyLabel.h"

@implementation XPYCopyLabel

#pragma mark - Initializer
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addTapGesture];
        _isCanCopy = YES;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _isCanCopy = YES;
        [self addTapGesture];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    _isCanCopy = YES;
    [self addTapGesture];
}

#pragma mark - Private methods
- (void)addTapGesture {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pressAction:)];
    longPress.minimumPressDuration = 0.5;
    [self addGestureRecognizer:longPress];
}

#pragma mark - Action
- (void)pressAction:(UILongPressGestureRecognizer *)gesture {
    if (gesture.state == UIGestureRecognizerStateBegan) {
        [self becomeFirstResponder];
        [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
        [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
    }
}
- (void)copy:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.text;
}

#pragma mark - Override methods

/// 覆盖方法，能接受事件
- (BOOL)canBecomeFirstResponder {
    return _isCanCopy;
}

/// 弹出面板可以响应的按钮，这里只显示复制按钮
/// @param action action
/// @param sender sender
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return action == @selector(copy:);
}

@end
