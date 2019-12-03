//
//  XPYImagePickerCollectionViewCell.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/13.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYImagePickerCollectionViewCell.h"

@interface XPYImagePickerCollectionViewCell ()
@property (nonatomic, strong) UIButton *deleteButton;
@end

@implementation XPYImagePickerCollectionViewCell

#pragma mark - Initialization
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.pickedImageView];
        [self.contentView addSubview:self.deleteButton];
    }
    return self;
}

#pragma mark - Instance methods
- (void)setupImage:(UIImage *)image isAddItem:(BOOL)isAdd {
    self.pickedImageView.image = image;
    self.deleteButton.hidden = isAdd;
}

#pragma mark - Actions
- (void)deleteAction {
    if (self.deleteHandler) {
        self.deleteHandler();
    }
}

#pragma mark - Getters
- (UIImageView *)pickedImageView {
    if (!_pickedImageView) {
        _pickedImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _pickedImageView.contentMode = UIViewContentModeScaleAspectFill;
        _pickedImageView.clipsToBounds = YES;
    }
    return _pickedImageView;
}
- (UIButton *)deleteButton {
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(CGRectGetWidth(self.contentView.bounds) - 30, 0, 30, 30);
        [_deleteButton setImage:[UIImage imageNamed:@"photo_delete"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(deleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteButton;
}


@end
