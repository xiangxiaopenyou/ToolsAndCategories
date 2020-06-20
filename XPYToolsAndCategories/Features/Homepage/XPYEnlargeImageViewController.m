//
//  XPYEnlargeImageViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/6/18.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYEnlargeImageViewController.h"
#import "XPYTouchToEnlargeView.h"

@interface XPYEnlargeImageViewController ()

@property (nonatomic, strong) XPYTouchToEnlargeView *touchView;

@end

@implementation XPYEnlargeImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.touchView];
    
}

- (XPYTouchToEnlargeView *)touchView {
    if (!_touchView) {
        _touchView = [[XPYTouchToEnlargeView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    }
    return _touchView;
}

@end
