//
//  XPYDropdownCell.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2020/1/3.
//  Copyright © 2020 xpy. All rights reserved.
//

#import "XPYDropdownCell.h"

#import "XPYDropdownConfigurations.h"
#import "XPYDropdownItemModel.h"

@interface XPYDropdownCell ()

@property (nonatomic, strong) UIImageView *dropdownImageView;
@property (nonatomic, strong) UILabel *dropdownLabel;

@property (nonatomic, strong) UIView *selectedBackground;

@end

@implementation XPYDropdownCell

#pragma mark - Initializer
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.dropdownImageView];
        [self.contentView addSubview:self.dropdownLabel];
    }
    return self;
}

#pragma mark - Instance methods
- (void)setupItem:(XPYDropdownItemModel *)model config:(XPYDropdownConfigurations *)config {
    if (config.cellSelectedColor) {
        self.selectedBackground.backgroundColor = config.cellSelectedColor;
        self.selectedBackgroundView = self.selectedBackground;
    }
    self.dropdownLabel.font = config.titleFont;
    
    //设置单独的字体颜色
    if (model.itemTitleColor) {
        self.dropdownLabel.textColor = model.itemTitleColor;
    } else {
        self.dropdownLabel.textColor = config.titleColor;
    }
    
    switch (model.cellStyle) {
        case XPYDropdownCellStyleIconAndTitle: {
            self.dropdownImageView.hidden = NO;
            self.dropdownLabel.hidden = NO;
            self.dropdownImageView.image = model.itemIcon;
            self.dropdownLabel.text = model.itemTitle;
            
            self.dropdownImageView.frame = CGRectMake(config.separatorEdgeInsets.left, 0, config.cellHeight - 5, config.cellHeight);
            self.dropdownLabel.frame = CGRectMake(config.separatorEdgeInsets.left + config.cellHeight - 5, 0, config.dropdownWidth - config.separatorEdgeInsets.left - config.cellHeight - 5 - config.separatorEdgeInsets.right, config.cellHeight);
        }
            break;
        case XPYDropdownCellStyleIcon: {
            self.dropdownImageView.hidden = NO;
            self.dropdownLabel.hidden = YES;
            self.dropdownImageView.image = model.itemIcon;
            
            self.dropdownImageView.frame = CGRectMake(config.separatorEdgeInsets.left, 0, config.cellHeight - 5, config.cellHeight);
        }
            break;
        case XPYDropdownCellStyleTitle: {
            self.dropdownImageView.hidden = YES;
            self.dropdownLabel.hidden = NO;
            self.dropdownLabel.text = model.itemTitle;

            self.dropdownLabel.frame = CGRectMake(config.separatorEdgeInsets.left, 0, config.dropdownWidth - config.separatorEdgeInsets.left - config.separatorEdgeInsets.right, config.cellHeight);
        }
            break;
    }
}

#pragma mark - Getters
- (UIImageView *)dropdownImageView {
    if (!_dropdownImageView) {
        _dropdownImageView = [[UIImageView alloc] init];
        //图片不拉伸
        _dropdownImageView.contentMode = UIViewContentModeCenter;
    }
    return _dropdownImageView;
}
- (UILabel *)dropdownLabel {
    if (!_dropdownLabel) {
        _dropdownLabel = [[UILabel alloc] init];
    }
    return _dropdownLabel;
}

- (UIView *)selectedBackground {
    if (!_selectedBackground) {
        _selectedBackground = [[UIView alloc] init];
    }
    return _selectedBackground;
}

@end
