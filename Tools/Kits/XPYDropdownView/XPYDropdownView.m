//
//  XPYDropdownView.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/2.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYDropdownView.h"
#import "XPYDropdownCell.h"

#import "XPYDropdownConfigurations.h"
#import "XPYDropdownItemModel.h"

#define kXPYKeyWindow [UIApplication sharedApplication].delegate.window
#define kXPYScreenBounds [UIScreen mainScreen].bounds
#define kXPYScreenWidth CGRectGetWidth(kXPYScreenBounds)
#define kXPYScreenHeight CGRectGetHeight(kXPYScreenBounds)

static NSString * const kXPYDropdownCellIdentifierKey = @"XPYDropdownCellIdentifier";

@interface XPYDropdownView () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UITableView *tableView;

/// Model数组
@property (nonatomic, copy) NSArray <XPYDropdownItemModel *> *items;

/// 配置
@property (nonatomic, strong) XPYDropdownConfigurations *configurations;

/// 箭头顶点坐标
@property (nonatomic, assign) CGPoint arrowPoint;

/// 箭头顶点x坐标相对于屏幕的比例，如箭头x坐标在屏幕中心，则为 0.5，为了适配屏幕旋转，y坐标暂不考虑
@property (nonatomic, assign) CGFloat pointXScale;
@end

@implementation XPYDropdownView

#pragma mark - Initializer
- (instancetype)initWithItemsArray:(NSArray<XPYDropdownItemModel *> *)itemsArray
                    configurations:(XPYDropdownConfigurations *)configurations
                        arrowPoint:(CGPoint)point {
    self = [super init];
    if (self) {
        self.backgroundColor = configurations.mainBackgroundColor;
        
        self.items = [itemsArray copy];
        self.configurations = configurations;
        /// 限制界面参数
        // 限制箭头宽度
        if (self.configurations.arrowWidth < 2) {
            self.configurations.arrowWidth = 2;
        }
        if (self.configurations.arrowWidth > self.configurations.dropdownWidth / 2.0) {
            self.configurations.arrowWidth = self.configurations.dropdownWidth / 2.0;
        }
        
        // 限制箭头左下角x位置
        if (self.configurations.arrowOriginX > self.configurations.dropdownWidth - self.configurations.arrowWidth - self.configurations.cornerRadius) {
            self.configurations.arrowOriginX = self.configurations.dropdownWidth - self.configurations.arrowWidth - self.configurations.cornerRadius;
        }
        
        self.arrowPoint = point;
        self.pointXScale = point.x / kXPYScreenWidth * 1.0f;
        
        [self setupContentView];
        
        //监听屏幕旋转
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    }
    return self;
}

#pragma mark - UI
- (void)setupContentView {
    if (self.items.count == 0) {
        NSLog(@"数据源为空");
        return;
    }
    
    // 设置全屏幕frame
    self.frame = kXPYScreenBounds;
    
    // 设置下拉菜单的anchorPoint，为缩放动画准备
    CGFloat x = (self.configurations.arrowWidth / 2.0 + self.configurations.arrowOriginX) / self.configurations.dropdownWidth * 1.0;
    self.contentView.layer.anchorPoint = CGPointMake(x, 0);
    
    // 设置菜单frame
    [self refreshContentFrame];
    
    
    if (self.configurations.isAddShadow) {
        // 设置阴影
        self.contentView.layer.shadowOffset = CGSizeZero;
        self.contentView.layer.shadowColor = [UIColor blackColor].CGColor;
        self.contentView.layer.shadowRadius = 12.f;
        self.contentView.layer.shadowOpacity = 0.2;
    }
    
    if (self.configurations.arrowHeight > 0) {
        // 画三角形箭头
        [self drawArrow];
    }
    
    // 设置tableView的frame
    [self.contentView addSubview:self.tableView];
    self.tableView.frame = CGRectMake(0, self.configurations.arrowHeight, self.configurations.dropdownWidth, self.items.count * self.configurations.cellHeight);
    
}

/// 设置菜单的frame
- (void)refreshContentFrame {
    CGFloat contentOriginX = self.pointXScale * kXPYScreenWidth - (self.configurations.arrowWidth / 2.0) - self.configurations.arrowOriginX;
    CGFloat contentOriginY = self.arrowPoint.y;
    CGFloat contentHeight = self.items.count * self.configurations.cellHeight + self.configurations.arrowHeight;
    self.contentView.frame = CGRectMake(contentOriginX, contentOriginY, self.configurations.dropdownWidth, contentHeight);
}

/// 画箭头
- (void)drawArrow {
    CAShapeLayer *arrowLayer = [CAShapeLayer layer];
    UIBezierPath *arrowPath = [UIBezierPath bezierPath];
    
    // 三角形左侧点
    [arrowPath moveToPoint:CGPointMake(self.configurations.arrowOriginX, self.configurations.arrowHeight)];
    // 三角形顶点
    [arrowPath addLineToPoint:CGPointMake(self.configurations.arrowOriginX + self.configurations.arrowWidth / 2.0, 0)];
    // 三角形右侧点
    [arrowPath addLineToPoint:CGPointMake(self.configurations.arrowOriginX + self.configurations.arrowWidth, self.configurations.arrowHeight)];
    arrowPath.lineJoinStyle = kCGLineJoinRound;
    arrowPath.lineCapStyle = kCGLineJoinRound;
    arrowLayer.fillColor = self.configurations.dropdownBackgroundColor.CGColor;
    
    arrowLayer.path = arrowPath.CGPath;
    [self.contentView.layer addSublayer:arrowLayer];
}

#pragma mark - Instance methods
- (void)show {
    // KeyWindow的子视图
    [kXPYKeyWindow addSubview:self];
    // 先设置透明
    self.alpha = 0;
    // 先缩小下拉菜单视图
    self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    [self addSubview:self.contentView];
    // 放大并设置透明度动画
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 1;
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
    }];
}
- (void)dismiss {
    [UIView animateWithDuration:0.2 animations:^{
        self.alpha = 0;
        self.contentView.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - Notification
// 设备方向改变的处理
- (void)handleDeviceOrientationChange:(NSNotification *)notification {
    self.frame = kXPYScreenBounds;
    [self refreshContentFrame];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self dismiss];
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    XPYDropdownCell *cell = [tableView dequeueReusableCellWithIdentifier:kXPYDropdownCellIdentifierKey];
    if (!cell) {
        cell = [[XPYDropdownCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kXPYDropdownCellIdentifierKey];
    }
    [cell setupItem:self.items[indexPath.row] config:self.configurations];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.configurations.cellHeight;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    XPYDropdownItemModel *itemModel = self.items[indexPath.row];
    if (self.delegate && [self.delegate respondsToSelector:@selector(dropdownView:didClickItem:)]) {
        [self.delegate dropdownView:self didClickItem:itemModel];
    }
    [self dismiss];
}

#pragma mark - Getters
- (UIView *)contentView {
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
    }
    return _contentView;
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = self.configurations.dropdownBackgroundColor;
        _tableView.layer.masksToBounds = YES;
        _tableView.layer.cornerRadius = self.configurations.cornerRadius;
        if (self.configurations.isHiddenSeparator) {
            _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        }
        _tableView.separatorInset = self.configurations.separatorEdgeInsets;
        _tableView.separatorColor = self.configurations.separatorColor;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[XPYDropdownCell class] forCellReuseIdentifier:kXPYDropdownCellIdentifierKey];
    }
    return _tableView;
}

#pragma mark - Dealloc
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

@end
