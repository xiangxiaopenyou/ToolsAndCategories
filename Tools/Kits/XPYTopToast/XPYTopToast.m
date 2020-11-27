//
//  XPYTopToast.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/11/27.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYTopToast.h"

static inline CGFloat xpy_toast_width() {
    return CGRectGetWidth([UIApplication sharedApplication].delegate.window.bounds) - 50.f;
}
static inline UIWindow * xpy_key_window() {
    return [UIApplication sharedApplication].delegate.window;
}

/**XPYTopToastStyle**/

@implementation XPYTopToastStyle

- (instancetype)initWithDefaultStyle {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.textColor = [UIColor whiteColor];
        self.textFont = [UIFont systemFontOfSize:15];
        self.textAlignment = NSTextAlignmentCenter;
        self.cornerRadius = 0;
        self.duration = 2;
    }
    return self;
}
- (instancetype)init {
    return [self initWithDefaultStyle];
}

@end


/**XPYTopToastView**/

@interface XPYTopToastView ()

@property (nonatomic, strong) UILabel *toastLabel;
@property (nonatomic, strong) XPYTopToastStyle *toastStyle;
@property (nonatomic, copy) NSString *tips;

@end

@implementation XPYTopToastView

#pragma mark - Initializer
- (instancetype)initWithStyle:(XPYTopToastStyle *)style tips:(NSString *)tips {
    self = [super init];
    if (self) {
        self.toastStyle = style;
        self.tips = tips;
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        [self configureUI];
    }
    return self;
}

#pragma mark - Private methods
- (void)configureUI {
    self.backgroundColor = self.toastStyle.backgroundColor;
    // 计算多行文字大小
    CGSize textSize = [self.tips boundingRectWithSize:CGSizeMake(xpy_toast_width(), MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : self.toastStyle.textFont} context:nil].size;
    
    [xpy_key_window() addSubview:self];
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:xpy_key_window() attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    
    CGFloat topConstant = CGRectGetHeight([UIApplication sharedApplication].statusBarFrame);
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:xpy_key_window() attribute:NSLayoutAttributeTop multiplier:1 constant:topConstant /*-(textSize.height + 20)*/];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:xpy_toast_width()];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:self attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:textSize.height + 20];
    [self addConstraints:@[widthConstraint, heightConstraint]];
    [xpy_key_window() addConstraints:@[centerXConstraint, topConstraint]];
    
    [self addSubview:self.toastLabel];
    NSLayoutConstraint *toastTopConstraint = [NSLayoutConstraint constraintWithItem:self.toastLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1 constant:0];
    NSLayoutConstraint *toastBottomConstraint = [NSLayoutConstraint constraintWithItem:self.toastLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1 constant:0];
    NSLayoutConstraint *toastLeadingConstraint = [NSLayoutConstraint constraintWithItem:self.toastLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeading multiplier:1 constant:0];
    NSLayoutConstraint *toastTrailingConstraint = [NSLayoutConstraint constraintWithItem:self.toastLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTrailing multiplier:1 constant:0];
    [self addConstraints:@[toastTopConstraint, toastBottomConstraint, toastLeadingConstraint, toastTrailingConstraint]];
}

#pragma mark - Getters
- (UILabel *)toastLabel {
    if (!_toastLabel) {
        _toastLabel = [[UILabel alloc] init];
        _toastLabel.font = self.toastStyle.textFont;
        _toastLabel.textAlignment = self.toastStyle.textAlignment;
        _toastLabel.textColor = self.toastStyle.textColor;
        _toastLabel.text = self.tips;
        _toastLabel.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return _toastLabel;
}

@end


/**XPYTopToast**/

@implementation XPYTopToast

+ (void)showWithTips:(NSString *)tips {
    XPYTopToastStyle *defaultStyle = [[XPYTopToastStyle alloc] initWithDefaultStyle];
    [self showWithTips:tips style:defaultStyle];
}

+ (void)showWithTips:(NSString *)tips style:(XPYTopToastStyle *)style {
    XPYTopToastView *toast = [[XPYTopToastView alloc] initWithStyle:style tips:tips];
}

@end
