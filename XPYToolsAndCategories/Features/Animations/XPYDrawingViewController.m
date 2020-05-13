//
//  XPYDrawingViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/7/19.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYDrawingViewController.h"
#import "XPYDrawingView.h"

#import "NSTimer+XPYWeakTimer.h"

@interface XPYDrawingViewController ()

@property (nonatomic, strong) NSTimer *timer;

@end

@implementation XPYDrawingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    XPYDrawingView *drawingView = [[XPYDrawingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:drawingView];
    
    self.timer = [NSTimer xpy_timerWithTimeInterval:2 target:self selector:@selector(counter:) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)counter:(NSTimer *)timer {
    NSLog(@"倒计时");
}

- (void)dealloc {
    [self.timer invalidate];
    self.timer = nil;
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
