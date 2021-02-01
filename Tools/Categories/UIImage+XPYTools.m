//
//  UIImage+XPYTools.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/20.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "UIImage+XPYTools.h"

@implementation UIImage (XPYTools)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    // opaque - 图层是否完全透明，scale - 缩放比例，设置为0自动最佳缩放
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    // 设置当前图形上下文绘图区区域为path区域
    [path addClip];
    // 填充颜色
    [color setFill];
    [path fill];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size radius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor {
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, size.width, size.height) cornerRadius:radius];
    [path addClip];
    [color setFill];
    [path fill];
    // 边框颜色
    [borderColor setStroke];
    // 边框宽度
    [path setLineWidth:borderWidth];
    [path stroke];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
    
}

+ (UIImage *)gradientColorImageWithColors:(NSArray<UIColor *> *)colors gradiantColorType:(XPYGradientColorType)gradiantColorType size:(CGSize)imageSize {
    if (colors.count != 2) {
        return [UIImage new];
    }
    NSArray *cgColors = @[(id)colors[0].CGColor, (id)colors[1].CGColor];
    UIGraphicsBeginImageContextWithOptions(imageSize, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([colors.lastObject CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)cgColors, NULL);
    CGPoint startPoint, endPoint;
    switch (gradiantColorType) {
        case XPYGradientColorTypeTopLeftToBottomRight: {
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(imageSize.width, imageSize.height);
        }
            break;
        case XPYGradientColorTypeTopRightToBottomLeft: {
            startPoint = CGPointMake(imageSize.width, 0);
            endPoint = CGPointMake(0, imageSize.height);
        }
            break;
        case XPYGradientColorTypeTopToBottom: {
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(0, imageSize.height);
        }
            break;
        case XPYGradientColorTypeLeftToRight: {
            startPoint = CGPointMake(0, 0);
            endPoint = CGPointMake(imageSize.width, 0);
        }
            break;
    }
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    UIGraphicsEndImageContext();
    return resultImage;
}

@end
