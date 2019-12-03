//
//  XPYPhotosPreviewViewController.h
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/18.
//  Copyright © 2019 xpy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface XPYPhotosPreviewViewController : UIViewController

@property (nonatomic, strong) NSMutableArray <PHAsset *> *imageAssets;
@property (nonatomic, assign) NSInteger selectedIndex;


/// 删除图片闭包
@property (nonatomic, copy) void (^deletePhotoHandler)(NSInteger index);

@end

NS_ASSUME_NONNULL_END
