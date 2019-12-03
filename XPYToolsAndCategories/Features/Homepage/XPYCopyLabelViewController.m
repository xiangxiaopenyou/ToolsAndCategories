//
//  XPYCopyLabelViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/21.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYCopyLabelViewController.h"

#import "XPYCopyLabel.h"

@interface XPYCopyLabelViewController ()

@end

@implementation XPYCopyLabelViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"XPYCopyLabel";
    self.view.backgroundColor = [UIColor whiteColor];
    
    XPYCopyLabel *label = [[XPYCopyLabel alloc] initWithFrame:CGRectMake(200, 200, 100, 50)];
    label.text = @"点我复制";
    label.isCanCopy = NO;
    label.isCanCopy = YES;
    [self.view addSubview:label];
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
