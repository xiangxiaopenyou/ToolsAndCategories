//
//  XPYAnimationsViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/6/29.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYAnimationsViewController.h"
#import "XPYDrawingViewController.h"
#import "XPYThumbUpAnimationViewController.h"
#import "XPYTransformAnimationViewController.h"
#import "XPYAnimationGroupsViewController.h"
#import "XPYCommonTransitionAnimationViewController.h"
#import "XPYCircleProgressViewController.h"

#import "XPYAnimationsView.h"

@interface XPYAnimationsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, copy) NSArray *itemsArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation XPYAnimationsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"动画";
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.itemsArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XPYAnimationItemCell" forIndexPath:indexPath];
    cell.textLabel.text = self.itemsArray[indexPath.row];
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0: {
            XPYDrawingViewController *drawingController = [[XPYDrawingViewController alloc] init];
            drawingController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:drawingController animated:YES];
        }
            break;
        case 1: {
            XPYTransformAnimationViewController *transformController = [[XPYTransformAnimationViewController alloc] init];
            transformController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:transformController animated:YES];
        }
            break;
        case 2: {
            XPYThumbUpAnimationViewController *ThumbUpController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"XPYThumbUpAnimation"];
            ThumbUpController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:ThumbUpController animated:YES];
        }
            break;
        case 3: {
            XPYAnimationGroupsViewController *animationGroupsController = [[XPYAnimationGroupsViewController alloc] init];
            animationGroupsController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:animationGroupsController animated:YES];
        }
            break;
        case 4: {
            XPYCommonTransitionAnimationViewController *commonTransitionController = [[XPYCommonTransitionAnimationViewController alloc] init];
            commonTransitionController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:commonTransitionController animated:YES];
        }
            break;
        case 5: {
            XPYCircleProgressViewController *progressController = [[XPYCircleProgressViewController alloc] init];
            progressController.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:progressController animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - Getters
- (NSArray *)itemsArray {
    if (!_itemsArray) {
        _itemsArray = @[@"XPYDrawingView", @"TransformAnimation", @"ThumbUpAnimation", @"XPYAnimationsView", @"自定义转场动画", @"圆形进度条"];
    }
    return _itemsArray;
}

@end
