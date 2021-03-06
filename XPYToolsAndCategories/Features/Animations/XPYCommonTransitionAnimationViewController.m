//
//  XPYCommonTransitionAnimationViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/10/12.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYCommonTransitionAnimationViewController.h"
#import "XPYCommonTransitionPopAnimationViewController.h"

#import "UIView+XPYSnapshotImage.h"
#import "XPYFileManager.h"

@interface XPYCommonTransitionAnimationViewController () <UINavigationControllerDelegate>

@end

@implementation XPYCommonTransitionAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"自定义转场动画";
    
    UIButton *pushButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pushButton setTitle:@"push" forState:UIControlStateNormal];
    [pushButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [pushButton addTarget:self action:@selector(pushAction:) forControlEvents:UIControlEventTouchUpInside];
    pushButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:pushButton];
    NSLayoutConstraint *centerXConstraint = [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
    NSLayoutConstraint *centerYConstraint = [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1 constant:0];
    NSLayoutConstraint *widthConstraint = [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:100];
    NSLayoutConstraint *heightConstraint = [NSLayoutConstraint constraintWithItem:pushButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1 constant:50];
    [pushButton addConstraints:@[widthConstraint, heightConstraint]];
    [self.view addConstraints:@[centerXConstraint, centerYConstraint]];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    UIImage *snapshotImage = [self.view snapshotImage];
//    NSString *cachePath = [XPYFileManager cacheFilePathWithKey:@"SnapshotCache"];
//    if ([XPYFileManager createCacheDirectoryWithFilePath:cachePath]) {
//        NSData *imageData = UIImagePNGRepresentation(snapshotImage);
//        NSString *dataPath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_snapshop_image.png", @(self.hash)]];
//        if ([XPYFileManager saveFile:ima geData toPath:dataPath]) {
//            NSData *data = [XPYFileManager dataWithFilePath:dataPath];
//            UIImage *image = [UIImage imageWithData:data];
//            NSLog(@"success");
//        }
//    }

}

#pragma mark - Action
- (void)pushAction:(UIButton *)button {
    XPYCommonTransitionPopAnimationViewController *popController = [[XPYCommonTransitionPopAnimationViewController alloc] init];
    [self.navigationController pushViewController:popController animated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
