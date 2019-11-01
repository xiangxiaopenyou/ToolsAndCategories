//
//  UIView+XPYSnapshotImage.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/1.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "UIView+XPYSnapshotImage.h"

@implementation UIView (XPYSnapshotImage)
- (UIImage *)snapshotImage {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, 0);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    } else {
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
