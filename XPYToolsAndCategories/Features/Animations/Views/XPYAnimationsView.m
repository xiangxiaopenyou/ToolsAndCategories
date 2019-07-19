//
//  XPYAnimationsView.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/6/29.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYAnimationsView.h"

@implementation XPYAnimationsView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //[self gradient];
    }
    return self;
}

/**
 渐变
 */
//- (void)gradient {
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = self.bounds;
//    gradientLayer.colors = @[(id)[UIColor blackColor].CGColor, (id)[UIColor redColor].CGColor];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1, 1);
//    [self.layer addSublayer:gradientLayer];
//
//}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end
