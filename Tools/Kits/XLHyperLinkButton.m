//
//  XLHyperLinkButton.m
//  InHeart
//
//  Created by 项小盆友 on 16/9/22.
//  Copyright © 2016年 项小盆友. All rights reserved.
//

#import "XLHyperLinkButton.h"

@implementation XLHyperLinkButton


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGRect textRect = self.titleLabel.frame;
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGFloat descender = self.titleLabel.font.descender;
    if ([self.lineColor isKindOfClass:[UIColor class]]) {
        CGContextSetStrokeColorWithColor(contextRef, self.lineColor.CGColor);
    }
    CGContextMoveToPoint(contextRef, textRect.origin.x, textRect.origin.y + textRect.size.height + descender + 2);
    CGContextAddLineToPoint(contextRef, textRect.origin.x + textRect.size.width, textRect.origin.y + textRect.size.height + descender + 2);
    CGContextClosePath(contextRef);
    CGContextDrawPath(contextRef, kCGPathStroke);
}
- (void)setColor:(UIColor *)color {
    self.lineColor = [color copy];
    [self setNeedsDisplay];
}


@end
