//
//  XLBlockAlertView.m
//  MiYo
//
//  Created by 项小盆友 on 16/4/6.
//  Copyright © 2016年 项小盆友. All rights reserved.
//

#import "XLBlockAlertView.h"

@interface XLBlockAlertView()<UIAlertViewDelegate>
@property (copy, nonatomic) ClickedBlock clickBlock;

@end

@implementation XLBlockAlertView
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message block:(ClickedBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtontTitle:(NSString *)otherButtontTitle {
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtontTitle, nil];
    if (self) {
        self.clickBlock = [block copy];
    }
    return self;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message block:(ClickedBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithTitle:title message:message delegate:self cancelButtonTitle:cancelButtonTitle otherButtonTitles: nil];
    if (self) {
        self.clickBlock = [block copy];
        va_list _arguments;
        va_start(_arguments, otherButtonTitles);
        for (NSString *key = otherButtonTitles; key != nil; key = (__bridge NSString *)va_arg(_arguments, void *)) {
            [self addButtonWithTitle:key];
        }
        va_end(_arguments);
    }
    return self;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_clickBlock) {
        _clickBlock(buttonIndex);
    }
}

- (void)show {
    [super show];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
