//
//  XPYDrawingViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/7/19.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYDrawingViewController.h"
#import "XPYDrawingView.h"

@interface XPYDrawingViewController ()

@end

@implementation XPYDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    XPYDrawingView *drawingView = [[XPYDrawingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:drawingView];
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
