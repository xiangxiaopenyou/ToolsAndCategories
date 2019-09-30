//
//  UIImage+ResizeMagick.h
//
//
//  Created by Vlad Andersen on 1/5/13.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (ResizeMagick)

- (NSString *)rmk_resizedAndReturnPath;
- (NSData *)rmk_resizedAndReturnData;

- (UIImage *)rmk_resizedImageByMagick:(NSString *)spec;
- (UIImage *)rmk_resizedImageByWidth:(NSUInteger)width;
- (UIImage *)rmk_resizedImageByHeight:(NSUInteger)height;
- (UIImage *)rmk_resizedImageWithMaximumSize:(CGSize)size;
- (UIImage *)rmk_resizedImageWithMinimumSize:(CGSize)size;

@end
