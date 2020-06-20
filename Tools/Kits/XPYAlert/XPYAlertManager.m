//
//  XPYAlertManager.m
//  zhangDu
//
//  Created by zhangdu_imac on 2019/9/25.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYAlertManager.h"
#import "XPYAlertController.h"

@implementation XPYAlertManager

+ (void)showAlertWithTitle:(NSString *)titleString
                   message:(NSString *)messageString
                    cancel:(NSString *)cancelString
                   confirm:(NSString *)confirmString
              inController:(UIViewController *)viewController
            confirmHandler:(void (^)(void))confirm
             cancelHandler:(void (^)(void))cancel {
    if (!cancelString && !confirmString) {
        return;
    }
    XPYAlertModel *alertModel = [[XPYAlertModel alloc] initWithTitle:titleString message:messageString style:UIAlertControllerStyleAlert];
    [XPYAlertController makeAlert:^(XPYAlertController * _Nonnull controller) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        if (cancelString) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (cancel) {
                    cancel();
                }
            }];
            //设置Action文字颜色
            //[cancelAction setValue:[UIColor colorWithRed:51 / 255.0 green:51 / 255.0 blue:51 / 255.0 alpha:1] forKey:@"_titleTextColor"];
            [items addObject:cancelAction];
        }
        
        if (confirmString) {
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:confirmString style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                if (confirm) {
                    confirm();
                }
            }];
            [items addObject:confirmAction];
        }
        controller.actionItems(items).showAlert(viewController);
    } alertModel:alertModel];
}
+ (void)showActionSheetWithTitle:(NSString *)titleString
                         message:(NSString *)messageString
                          cancel:(NSString *)cancelString
                    inController:(UIViewController *)viewController
                      sourceView:(UIView *)sourceView
                         actions:(NSArray<NSString *> *)actions
                   actionHandler:(void (^)(NSInteger))actionHandler {
    if (actions.count == 0) {
        return;
    }
    XPYAlertModel *alertModel = [[XPYAlertModel alloc] initWithTitle:titleString message:messageString style:UIAlertControllerStyleActionSheet];
    [XPYAlertController makeAlert:^(XPYAlertController * _Nonnull controller) {
        NSMutableArray *items = [[NSMutableArray alloc] init];
        if (cancelString) {
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelString style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            }];
            [items addObject:cancelAction];
        }
        [actions enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIAlertAction *alertAction = [UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (actionHandler) {
                    actionHandler(idx);
                }
            }];
            [items addObject:alertAction];
        }];
        controller.actionItems(items).sourceView(sourceView).showAlert(viewController);
    } alertModel:alertModel];
}
@end
