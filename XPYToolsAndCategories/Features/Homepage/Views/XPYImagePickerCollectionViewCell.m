//
//  XPYImagePickerCollectionViewCell.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/13.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYImagePickerCollectionViewCell.h"

@interface XPYImagePickerCollectionViewCell ()
@property (nonatomic, strong) UIImageView *pickedImageView;
@end

@implementation XPYImagePickerCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.pickedImageView];
    }
    return self;
}

- (void)setupImage:(UIImage *)image {
    self.pickedImageView.image = image;
}

- (UIImageView *)pickedImageView {
    if (!_pickedImageView) {
        _pickedImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
    }
    return _pickedImageView;
}


@end
