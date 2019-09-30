//
//  XPYCategoryTitleView.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/9/6.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYCategoryTitleView.h"

@interface XPYCategoryTitleView ()
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *indicatorView;

@property (nonatomic, copy) NSArray<NSString *> *titlesArray;
@property (nonatomic, strong) XPYCategoryTitleViewConfigurations *configurations;
@property (nonatomic, strong) NSMutableArray<UIButton *> *titleButtons;
@property (nonatomic, assign) CGFloat contentWidth;
@property (nonatomic, strong) UIButton *selectedButton;
@end

@implementation XPYCategoryTitleViewConfigurations

@end

@implementation XPYCategoryTitleView

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles configuration:(XPYCategoryTitleViewConfigurations *)configuration {
    self = [super initWithFrame:frame];
    if (self) {
        if (titles.count == 0) {
            @throw [NSException exceptionWithName:@"XPYCategoryTitleView" reason:@"标题数组必须设置" userInfo:nil];
        }
        self.titlesArray = [titles copy];
        if (configuration) {
            [self refreshConfigurations:configuration];
        }
        [self setupContentView];
    }
    return self;
}

#pragma mark - UI
- (void)setupContentView {
    CGFloat frameWidth = CGRectGetWidth(self.frame);
    CGFloat frameHeight = CGRectGetHeight(self.frame);
    _contentWidth = 0;
    for (NSString *title in self.titlesArray) {
        CGFloat titleWidth = [title sizeWithAttributes:@{NSFontAttributeName : self.configurations.selectedTitleFont}].width;
        _contentWidth += titleWidth + self.configurations.extraWidth;
    }
    if (self.configurations.itemSpacing > 0) {
        _contentWidth += self.configurations.itemSpacing * (self.titlesArray.count - 1);
    }
    if (_contentWidth < frameWidth) {
        self.scrollView.frame = CGRectMake((frameWidth - _contentWidth) / 2.0, 0, _contentWidth, frameHeight);
    } else {
        self.scrollView.frame = CGRectMake(0, 0, frameWidth, frameHeight);
    }
    self.scrollView.contentSize = CGSizeMake(_contentWidth, 0);
    
    [self addSubview:self.scrollView];
    
    __block CGFloat positionX = 0;
    [self.titlesArray enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat titleWidth = [obj sizeWithAttributes:@{NSFontAttributeName : self.configurations.selectedTitleFont}].width;
        UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        titleButton.tag = 1000 + idx;
        titleButton.frame = CGRectMake(positionX, 0, titleWidth + self.configurations.extraWidth, frameHeight - self.configurations.indicatorHeight);
        [titleButton setTitle:obj forState:UIControlStateNormal];
        [titleButton addTarget:self action:@selector(titleButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        if (idx == 0) {
            [titleButton setTitleColor:self.configurations.selectedColor forState:UIControlStateNormal];
            titleButton.titleLabel.font = self.configurations.selectedTitleFont;
            self.selectedButton = titleButton;
            self.indicatorView.frame = CGRectMake((titleWidth + self.configurations.extraWidth) / 2.0 - self.configurations.indicatorWidth / 2.0, frameHeight - self.configurations.indicatorBottomSpacing - self.configurations.indicatorHeight, self.configurations.indicatorWidth, self.configurations.indicatorHeight);
        } else {
            [titleButton setTitleColor:self.configurations.normalColor forState:UIControlStateNormal];
            titleButton.titleLabel.font = self.configurations.titleFont;
        }
        [self.titleButtons addObject:titleButton];
        [self.scrollView addSubview:titleButton];
        positionX += titleWidth + self.configurations.extraWidth + self.configurations.itemSpacing;
    }];
    [self.scrollView addSubview:self.indicatorView];
    self.indicatorView.backgroundColor = self.configurations.selectedColor;
    
}

#pragma mark - Instance method
- (void)refreshColors:(UIColor *)normalColor selected:(UIColor *)selectedColor {
    self.configurations.normalColor = normalColor;
    self.configurations.selectedColor = selectedColor;
    
    for (UIButton *button in self.titleButtons) {
        [button setTitleColor:self.configurations.normalColor forState:UIControlStateNormal];
    }
    [self.selectedButton setTitleColor:self.configurations.selectedColor forState:UIControlStateNormal];
    self.indicatorView.backgroundColor = self.configurations.selectedColor;
}
- (void)selectCategoryViewItemWithIndex:(NSInteger)index {
    UIButton *targetButton = self.titleButtons[index];
    [self selectButton:targetButton];
    
//    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryTitleViewDidSelectItemAtIndex:)]) {
//        [self.delegate categoryTitleViewDidSelectItemAtIndex:index];
//    }
}

#pragma mark - Private methods
- (void)refreshConfigurations:(XPYCategoryTitleViewConfigurations *)configuration {
    if (configuration.enableScale != self.configurations.enableScale) {
        self.configurations.enableScale = configuration.enableScale;
    }
    if (configuration.titleFont && configuration.titleFont != self.configurations.titleFont) {
        self.configurations.titleFont = configuration.titleFont;
    }
    if (configuration.selectedTitleFont && configuration.selectedTitleFont != self.configurations.selectedTitleFont) {
        self.configurations.selectedTitleFont = configuration.selectedTitleFont;
    }
    if (configuration.normalColor && configuration.normalColor != self.configurations.normalColor) {
        self.configurations.normalColor = configuration.normalColor;
    }
    if (configuration.selectedColor && configuration.selectedColor != self.configurations.selectedColor) {
        self.configurations.selectedColor = configuration.selectedColor;
    }
    if (!self.configurations.enableScale) {
        self.configurations.selectedTitleFont = self.configurations.titleFont;
    }
    if (configuration.itemSpacing != self.configurations.itemSpacing) {
        self.configurations.itemSpacing = configuration.itemSpacing;
    }
    if (configuration.extraWidth != self.configurations.extraWidth) {
        self.configurations.extraWidth = configuration.extraWidth;
    }
    if (configuration.indicatorWidth > 0 && configuration.indicatorWidth != self.configurations.indicatorWidth) {
        self.configurations.indicatorWidth = configuration.indicatorWidth;
    }
    if (configuration.indicatorHeight > 0 && configuration.indicatorHeight != self.configurations.indicatorHeight) {
        self.configurations.indicatorHeight = configuration.indicatorHeight;
    }
    if (configuration.indicatorBottomSpacing != self.configurations.indicatorBottomSpacing) {
        self.configurations.indicatorBottomSpacing = configuration.indicatorBottomSpacing;
    }
}

#pragma mark - Actions & Selectors
- (void)titleButtonAction:(UIButton *)button {
    [self selectButton:button];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(categoryTitleView:didSelectItemAtIndex:)]) {
        [self.delegate categoryTitleView:self didSelectItemAtIndex:button.tag - 1000];
    }
}

#pragma mark - Private methods
- (void)selectButton:(UIButton *)button {
    if (button == self.selectedButton) {
        return;
    }
    [self refreshButtonStatus:NO button:self.selectedButton];
    [self refreshButtonStatus:YES button:button];
    self.selectedButton = button;
}
- (void)refreshButtonStatus:(BOOL)isSelected button:(UIButton *)button {
    if (self.configurations.enableScale) {
        if (isSelected) {
            [UIView animateWithDuration:0.4 animations:^{
                button.transform = CGAffineTransformMakeScale(1.125, 1.125);
                CGRect indicatorViewFrame = self.indicatorView.frame;
                self.indicatorView.frame = CGRectMake(button.center.x - self.configurations.indicatorWidth / 2.0, indicatorViewFrame.origin.y, indicatorViewFrame.size.width, indicatorViewFrame.size.height);
            } completion:^(BOOL finished) {
                [button setTitleColor:self.configurations.selectedColor forState:UIControlStateNormal];
                button.titleLabel.font = self.configurations.selectedTitleFont;
                button.transform = CGAffineTransformIdentity;
                [self setupSelectedButtonCenter:button];
            }];
        } else {
            button.transform = CGAffineTransformMakeScale(1.125, 1.125);
            CGFloat selectedFontSize = self.configurations.selectedTitleFont.pointSize;
            NSString *selectedFontName = self.configurations.selectedTitleFont.fontName;
            button.titleLabel.font = [UIFont fontWithName:selectedFontName size:selectedFontSize / 1.125];
            [UIView animateWithDuration:0.4 animations:^{
                button.transform = CGAffineTransformIdentity;
            } completion:^(BOOL finished) {
                [button setTitleColor:self.configurations.normalColor forState:UIControlStateNormal];
                button.titleLabel.font = self.configurations.titleFont;
            }];
        }
    } else {
        if (isSelected) {
            [button setTitleColor:self.configurations.selectedColor forState:UIControlStateNormal];
            button.titleLabel.font = self.configurations.selectedTitleFont;
            [UIView animateWithDuration:0.4 animations:^{
                CGRect indicatorViewFrame = self.indicatorView.frame;
                self.indicatorView.frame = CGRectMake(button.center.x - self.configurations.indicatorWidth / 2.0, indicatorViewFrame.origin.y, indicatorViewFrame.size.width, indicatorViewFrame.size.height);
            } completion:^(BOOL finished) {
                [self setupSelectedButtonCenter:button];
            }];
        } else {
            [button setTitleColor:self.configurations.normalColor forState:UIControlStateNormal];
            button.titleLabel.font = self.configurations.titleFont;
        }
    }
    
}
//选中按钮居中显示
- (void)setupSelectedButtonCenter:(UIButton *)button {
    if (_contentWidth > CGRectGetWidth(self.frame)) {
        //偏移量
        CGFloat offsetX = button.center.x - CGRectGetWidth(self.frame) * 0.5;
        if (offsetX < 0) {
            offsetX = 0;
        };
        //最大滚动范围
        CGFloat maxOffsetX = self.scrollView.contentSize.width - CGRectGetWidth(self.frame);
        if (offsetX > maxOffsetX) {
            offsetX = maxOffsetX;
        }
        [self.scrollView setContentOffset:CGPointMake(offsetX, 0) animated:YES];
    }
}

#pragma mark - Getters
- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
    }
    return _scrollView;
}
- (UIView *)indicatorView {
    if (!_indicatorView) {
        _indicatorView = [[UIView alloc] init];
        _indicatorView.layer.masksToBounds = YES;
        _indicatorView.layer.cornerRadius = self.configurations.indicatorHeight / 2.0;
    }
    return _indicatorView;
}
- (NSMutableArray<UIButton *> *)titleButtons {
    if (!_titleButtons) {
        _titleButtons = [[NSMutableArray alloc] init];
    }
    return _titleButtons;
}
- (XPYCategoryTitleViewConfigurations *)configurations {
    if (!_configurations) {
        _configurations = [[XPYCategoryTitleViewConfigurations alloc] init];
        _configurations.enableScale = NO;
        _configurations.titleFont = [UIFont systemFontOfSize:16];
        _configurations.selectedTitleFont = [UIFont systemFontOfSize:16];
        _configurations.normalColor = [UIColor blackColor];
        _configurations.selectedColor = [UIColor redColor];
        _configurations.itemSpacing = 0;
        _configurations.extraWidth = 0;
        _configurations.indicatorWidth = 20;
        _configurations.indicatorHeight = 2;
        _configurations.indicatorBottomSpacing = 0;
    }
    return _configurations;
}


@end
