//
//  ViewController.m
//  XPYToolsAndCategories
//
//  Created by 项小盆友 on 2019/1/11.
//  Copyright © 2019年 xpy. All rights reserved.
//

#import "ViewController.h"
#import <RSKImageCropper.h>
#import "XPYPerson.h"
#import "XPYAlertController.h"
#import "XPYAlertManager.h"
#import "XPYTableViewController.h"
#import "XPYCategoryViewController.h"
#import "XPYImagePickerViewController.h"
#import "XPYCopyLabelViewController.h"
#import "XPYFitSizeViewController.h"
#import "XPYEnlargeImageViewController.h"

#import "XPYTestAPIManager.h"
#import "XPYLoginAPIManager.h"
#import "XPYDownloadAPIManager.h"

#import "XPYDropdownDefine.h"

#import "XPYUtilitiesDefine.h"

#import <objc/runtime.h>

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource, XPYDropdownViewDelegate, XPYNetworkingAPIResponseDelegate>

@property (nonatomic, copy) NSArray *itemsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSString *strString;
@property (nonatomic, copy) NSString *copString;

@property (nonatomic, strong) XPYTestAPIManager *testApiManager;        // get请求
@property (nonatomic, strong) XPYLoginAPIManager *loginAPIManager;       // post请求
@property (nonatomic, strong) XPYDownloadAPIManager *downloadAPIManager;    //download请求

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    
    //链式编程测试
    XPYPerson *person = [[XPYPerson alloc] init];
    person.up().down();
    person.left(@"xianglinping").right(@"hahahaha");
    
    //获取方法列表
    unsigned int count;
    Method *methods = class_copyMethodList([self class], &count);;
    for (int i = 0; i < count; i ++) {
        NSLog(@"method name:%@", NSStringFromSelector(method_getName(methods[i])));
    }
    free(methods);
    
    //获取属性列表
    unsigned int pCount;
    objc_property_t *properties = class_copyPropertyList([self class], &pCount);
    for (int i = 0; i < pCount; i ++) {
        NSLog(@"property name:%s", property_getName(properties[i]));
    }
    free(properties);
    
    //获取实例对象列表
    unsigned int iCount;
    Ivar *ivars = class_copyIvarList([self class], &iCount);
    for (int i = 0; i < iCount; i ++) {
        NSLog(@"ivar name:%s", ivar_getName(ivars[i]));
    }
    free(ivars);
    
    // XPYNetworking测试
    [self.testApiManager requestData];
    [self.loginAPIManager requestData];
    [self.downloadAPIManager requestData];
    
}

/// XPYAlert
- (void)showAlert {
    XPYAlertModel *alertModel = [[XPYAlertModel alloc] initWithTitle:@"提示" message:@"请注意xxxxxxxxxx" style:UIAlertControllerStyleActionSheet];
    [XPYAlertController makeAlert:^(XPYAlertController * _Nonnull controller) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
            [XPYAlertManager showAlertWithTitle:@"确定" message:@"点击了确定" cancel:@"取消" confirm:@"确定" inController:self confirmHandler:^{
                NSLog(@"alert confirm");
            } cancelHandler:^{
                NSLog(@"alert cancel");
            }];
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"哈哈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"哈哈");
            [XPYAlertManager showActionSheetWithTitle:@"哈哈" message:@"点击了哈哈" cancel:@"取消" inController:self sourceView:[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]] actions:@[@"item0", @"item1", @"item2"] actionHandler:^(NSInteger index) {
                NSLog(@"click item%@", @(index));
            }];
        }];
        controller.actionItems(@[action1, action2, action3]).sourceView([self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:3 inSection:0]]).showAlert(self);
    } alertModel:alertModel];
}

- (IBAction)dropdownAction:(id)sender {
    XPYDropdownConfigurations *config = [[XPYDropdownConfigurations alloc] init];
    config.dropdownBackgroundColor = [UIColor blackColor];
    config.mainBackgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    config.cellSelectedColor = [UIColor colorWithWhite:0 alpha:0.2];
    config.titleColor = [UIColor whiteColor];
    // 隐藏箭头
    //config.arrowHeight = 0;

    XPYDropdownItemModel *model1 = [XPYDropdownItemModel makeModel:1 icon:[UIImage imageNamed:@"like"] title:@"like" titleColor:nil];
    XPYDropdownItemModel *model2 = [XPYDropdownItemModel makeModel:2 icon:[UIImage imageNamed:@"dislike"] title:@"dislike" titleColor:nil];
    XPYDropdownItemModel *model3 = [XPYDropdownItemModel makeModel:3 icon:[UIImage imageNamed:@"delete"] title:@"delete" titleColor:nil];

    CGFloat pointX = CGRectGetWidth(self.view.bounds) - 50.f;
    CGFloat pointY = XPYDeviceIsIphoneX ? 88.f : 64.f;
    XPYDropdownView *dropdownView = [[XPYDropdownView alloc] initWithItemsArray:@[model1, model2, model3] configurations:config arrowPoint:CGPointMake(pointX, pointY)];
    dropdownView.delegate = self;
    [dropdownView show];
}
- (IBAction)assertAction:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}


/// Jump between apps
/// @param sender sender
- (IBAction)jumpAction:(id)sender {
    NSURL *jumpURL = [NSURL URLWithString:@"TestApp://"];
    
    if ([[UIApplication sharedApplication] canOpenURL:jumpURL]) {
        if (@available(iOS 10.0, *)) {
            [[UIApplication sharedApplication] openURL:jumpURL options:@{} completionHandler:nil];
        } else {
            [[UIApplication sharedApplication] openURL:jumpURL];
        }
    } else {
        NSLog(@"没有安装TestApp");
    }
}

#pragma mark - XPYNetworkingAPIResponseDelegate
- (void)networkingAPIResponseDidSuccess:(XPYNetworkingBaseAPIManager *)manager {
}
- (void)networkingAPIResponseDidFail:(XPYNetworkingBaseAPIManager *)manager {
}

#pragma mark - XPYDropdownViewDelegate
- (void)dropdownView:(XPYDropdownView *)sender didClickItem:(XPYDropdownItemModel *)model {
    NSLog(@"点击了下拉菜单-%@", model.itemTitle);
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XPYHomepageItemCell" forIndexPath:indexPath];
    cell.textLabel.text = self.itemsArray[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self assertAction:nil];
            break;
        case 1: {
            XPYImagePickerViewController *pickerController = [[XPYImagePickerViewController alloc] init];
            [self.navigationController pushViewController:pickerController animated:YES];
        }
            break;
        case 2:
            [self jumpAction:nil];
            break;
        case 3:
            [self showAlert];
            break;
        case 4: {
            XPYTableViewController *tableViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"XPYTableView"];
            [self.navigationController pushViewController:tableViewController animated:YES];
        }
            break;
        case 5: {
            XPYCategoryViewController *categoryController = [[XPYCategoryViewController alloc] init];
            [self.navigationController pushViewController:categoryController animated:YES];
        }
            break;
        case 6: {
            XPYCopyLabelViewController *copyLabelController = [[XPYCopyLabelViewController alloc] init];
            [self.navigationController pushViewController:copyLabelController animated:YES];
        }
            break;
        case 7: {
            XPYFitSizeViewController *fitController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"XPYFitSizeViewController"];
            [self.navigationController pushViewController:fitController animated:YES];
        }
            break;
        case 8: {
            XPYEnlargeImageViewController *enlargeImageController = [[XPYEnlargeImageViewController alloc] init];
            [self.navigationController pushViewController:enlargeImageController animated:YES];
        }
            break;
    }
}

#pragma mark - Image picker controller delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *resultImage = (UIImage *)info[@"UIImagePickerControllerOriginalImage"];
    RSKImageCropViewController *imageCropController = [[RSKImageCropViewController alloc] initWithImage:resultImage cropMode:RSKImageCropModeCircle];
    imageCropController.moveAndScaleLabel.hidden = YES;
    [self presentViewController:imageCropController animated:YES completion:nil];
}

#pragma mark - Getters
- (NSArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = @[@"相册图片裁剪", @"ImagePicker(照片选择器)", @"跳转到TestApp", @"XPYAlert", @"TableView", @"XPYCategoryView(分类切换视图)", @"XPYCopyLabel(可复制Label)", @"storyboard根据屏幕自适应控件约束、字体大小", @"3D Touch按压图片放大"];
    }
    return _itemsArray;
}
- (XPYTestAPIManager *)testApiManager {
    if (!_testApiManager) {
        _testApiManager = [[XPYTestAPIManager alloc] init];
        _testApiManager.responseDelegate = self;
    }
    return _testApiManager;
}
- (XPYLoginAPIManager *)loginAPIManager {
    if (!_loginAPIManager) {
        _loginAPIManager = [[XPYLoginAPIManager alloc] init];
        _loginAPIManager.responseDelegate = self;
    }
    return _loginAPIManager;
}
- (XPYDownloadAPIManager *)downloadAPIManager {
    if (!_downloadAPIManager) {
        _downloadAPIManager = [[XPYDownloadAPIManager alloc] init];
        _downloadAPIManager.responseDelegate = self;
    }
    return _downloadAPIManager;
}
@end
