//
//  XLColorTool.h
//  ToolsAndCategories
//
//  Created by 项小盆友 on 16/5/23.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#define kRGBColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface XLColorTool : NSObject
+ (UIImage *)imageWithColor:(UIColor *)color;

@end
