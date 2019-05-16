//
//  ViewController.m
//  XPYToolsAndCategories
//
//  Created by 项小盆友 on 2019/1/11.
//  Copyright © 2019年 xpy. All rights reserved.
//

#import "ViewController.h"
#import "XPYDrawingView.h"
#import <RSKImageCropper.h>

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    XPYDrawingView *drawingView = [[XPYDrawingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:drawingView];
    
//    UIView *animationView = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
//    animationView.backgroundColor = [UIColor redColor];
//    [self.view addSubview:animationView];
//    [self addAnimationsWithView:animationView];
}
- (IBAction)assertAction:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *resultImage = (UIImage *)info[@"UIImagePickerControllerOriginalImage"];
    RSKImageCropViewController *imageCropController = [[RSKImageCropViewController alloc] initWithImage:resultImage cropMode:RSKImageCropModeCircle];
    imageCropController.moveAndScaleLabel.hidden = YES;
    [self presentViewController:imageCropController animated:YES completion:nil];
}

- (void)addAnimationsWithView:(UIView *)view {
    CABasicAnimation *moveAnimation = [CABasicAnimation animationWithKeyPath:@"position"];
    moveAnimation.fromValue = [NSValue valueWithCGPoint:CGPointMake(200, 200)];
    moveAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    moveAnimation.duration = 2.f;
    moveAnimation.removedOnCompletion = NO;
    moveAnimation.fillMode = kCAFillModeForwards;
    moveAnimation.autoreverses = YES;
    moveAnimation.repeatCount = MAXFLOAT;
    moveAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [view.layer addAnimation:moveAnimation forKey:@"position"];
    
//    CABasicAnimation *rotationYAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
//    rotationYAnimation.fromValue = [NSNumber numberWithFloat:0];
//    rotationYAnimation.toValue = [NSNumber numberWithFloat:M_PI];
//    rotationYAnimation.duration = 2.f;
//    rotationYAnimation.removedOnCompletion = NO;
//    rotationYAnimation.fillMode = kCAFillModeForwards;
//    rotationYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    rotationYAnimation.repeatCount = 10;
//    [view.layer addAnimation:rotationYAnimation forKey:nil];
}
@end
