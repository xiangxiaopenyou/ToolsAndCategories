//
//  XPYDrawingView.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/4/27.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYDrawingView.h"

@implementation XPYDrawingView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    //获取上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //画直线方法1
    CGMutablePathRef path = CGPathCreateMutable();                          //创建路径
    CGPathMoveToPoint(path, NULL, 10, 50);                                  //起点
    CGPathAddLineToPoint(path, NULL, 100, 50);                              //终点
    //CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);//直线颜色
    [[UIColor redColor] setStroke];                                         //直线颜色
    CGContextSetLineWidth(context, 10);                                     //直线宽度
    CGContextSetLineJoin(context, kCGLineJoinRound);                        //直线连接样式
    CGContextSetLineCap(context, kCGLineCapRound);                           //直线顶角样式
    CGContextAddPath(context, path);                                        //上下文添加路径
    CGContextStrokePath(context);                                           //渲染上下文
    CGPathRelease(path);                                                    //释放路径
    
    //画直线方法2
    CGContextMoveToPoint(context, 10, 100);
    CGContextAddLineToPoint(context, 100, 100);
    CGContextSetStrokeColorWithColor(context, [UIColor greenColor].CGColor);//直线颜色
    CGContextSetLineWidth(context, 5);
    CGContextStrokePath(context);
    
    //画直线方法3
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:CGPointMake(10, 150)];
    [bezierPath addLineToPoint:CGPointMake(100, 150)];
    bezierPath.lineWidth = 8;
    [[UIColor grayColor] setStroke];
    [bezierPath stroke];
    
    //画虚线
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.lineWidth = 5;
    layer.lineCap = kCALineCapRound;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.lineDashPattern = @[@(30), @(20)];                                //每段虚线长30 间隔20
    CGMutablePathRef path2 = CGPathCreateMutable();
    CGPathMoveToPoint(path2, NULL, 10, 200);
    CGPathAddLineToPoint(path2, NULL, 200, 200);
    layer.path = path2;
    CGPathRelease(path2);
    [self.layer addSublayer:layer];
    
    //画三点曲线
    CGContextSetStrokeColorWithColor(context, [UIColor yellowColor].CGColor);
    CGContextMoveToPoint(context, 10, 250);
    CGContextAddCurveToPoint(context, 50, 230, 100, 300, 150, 300);
    CGContextStrokePath(context);
    
    //画二元曲线
    CGContextMoveToPoint(context, 10, 300);
    CGContextAddQuadCurveToPoint(context, 50, 350, 150, 350);
    CGContextStrokePath(context);
}

@end
