//
//  XPYPhotosPreviewViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/18.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYPhotosPreviewViewController.h"
#import "XPYPhotosPreviewToolViewHandler.h"
#import <YBImageBrowser.h>

@interface XPYPhotosPreviewViewController () <YBImageBrowserDataSource>

@property (nonatomic, strong) XPYPhotosPreviewToolViewHandler *toolViewHandler;

@end

@implementation XPYPhotosPreviewViewController

#pragma mark - Life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    YBImageBrowser *browser = [[YBImageBrowser alloc] init];
    //只支持竖屏
    browser.supportedOrientations = UIInterfaceOrientationMaskPortrait;
    //设置数据源，也可以用dataSourceArray
    browser.dataSource = self;
    //当前页
    browser.currentPage = self.selectedIndex;
    //设置转场动画为空
    browser.defaultAnimatedTransition.showType = YBIBTransitionTypeNone;
    browser.defaultAnimatedTransition.hideType = YBIBTransitionTypeNone;
    //自定义工具视图
    self.toolViewHandler = [[XPYPhotosPreviewToolViewHandler alloc] init];
    browser.toolViewHandlers = @[self.toolViewHandler];
    __weak typeof(self) weakSelf = self;
    //自定义工具视图返回闭包回调
    self.toolViewHandler.backBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        [strongSelf.navigationController popViewControllerAnimated:YES];
    };
    //自定义工具视图删除闭包回调
    self.toolViewHandler.deleteBlock = ^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        if (strongSelf.deletePhotoHandler) {
            strongSelf.deletePhotoHandler(browser.currentPage);
        }
        [strongSelf.imageAssets removeObjectAtIndex:browser.currentPage];
        [browser reloadData];
        if (strongSelf.imageAssets.count <= 0) {
            [strongSelf.navigationController popViewControllerAnimated:YES];
        }
    };
    //展示图片主视图
    [browser showToView:self.view containerSize:self.view.bounds.size];
    //解决右滑返回和图片浏览器滑动冲突
    [browser.collectionView.panGestureRecognizer requireGestureRecognizerToFail:self.navigationController.interactivePopGestureRecognizer];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

#pragma mark - YBImageBrowserDataSource
- (NSInteger)yb_numberOfCellsInImageBrowser:(YBImageBrowser *)imageBrowser {
    return self.imageAssets.count;
}
- (id<YBIBDataProtocol>)yb_imageBrowser:(YBImageBrowser *)imageBrowser dataForCellAtIndex:(NSInteger)index {
    PHAsset *asset = self.imageAssets[index];
    YBIBImageData *data = [[YBIBImageData alloc] init];
    data.imagePHAsset = asset;
    data.interactionProfile.disable = YES;
    //单击手势闭包回调
    data.singleTouchBlock = ^(YBIBImageData * _Nonnull imageData) {
        [self.toolViewHandler hideTopView];
    };
    return data;
}

@end
