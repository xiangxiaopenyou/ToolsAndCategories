//
//  XLBlockActionSheet.m
//  MiYo
//
//  Created by 项小盆友 on 16/4/12.
//  Copyright © 2016年 项小盆友. All rights reserved.
//

#import "XLBlockActionSheet.h"
@interface XLBlockActionSheet()<UIActionSheetDelegate>
@property (copy, nonatomic) ClickedBlock clickBlock;
@end

@implementation XLBlockActionSheet
- (instancetype)initWithTitle:(NSString *)title clickedBlock:(ClickedBlock)block cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
    self = [super initWithTitle:title delegate:self cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    if (self) {
        if (self) {
            self.clickBlock = [block copy];
            va_list _arguments;
            va_start(_arguments, otherButtonTitles);
            for (NSString *key = otherButtonTitles; key != nil; key = (__bridge NSString *)va_arg(_arguments, void *)) {
                [self addButtonWithTitle:key];
            }
            va_end(_arguments);
        }
    }
    return self;
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (_clickBlock) {
        _clickBlock(buttonIndex);
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
