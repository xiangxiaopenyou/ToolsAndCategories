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

@interface ViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray *itemsArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"首页";
    //连式编程测试
    XPYPerson *person = [[XPYPerson alloc] init];
    person.up().down();
    person.left(@"xianglinping").right(@"hahahaha");
}
- (void)showAlert {
    XPYAlertModel *alertModel = [[XPYAlertModel alloc] initWithTitle:@"提示" message:@"请注意xxxxxxxxxx" style:UIAlertControllerStyleActionSheet];
    [XPYAlertController makeAlert:^(XPYAlertController * _Nonnull alert) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"取消");
        }];
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"确定");
        }];
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"哈哈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"哈哈");
        }];
        alert.actionItems(@[action1, action2, action3]).showAlert(self);
    } alertModel:alertModel];
}
- (IBAction)assertAction:(id)sender {
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}
- (IBAction)jumpAction:(id)sender {
    NSURL *jumpURL = [NSURL URLWithString:@"TestApp://"];
    
    if ([[UIApplication sharedApplication] canOpenURL:jumpURL]) {
        [[UIApplication sharedApplication] openURL:jumpURL options:@{} completionHandler:nil];
    } else {
        NSLog(@"没有安装TestApp");
    }
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
        case 1:
            [self jumpAction:nil];
            break;
        case 2:
            [self showAlert];
            break;
        default:
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
        _itemsArray = @[@"相册图片裁剪", @"跳转到TestApp", @"XPYAlertController"];
    }
    return _itemsArray;
}
@end