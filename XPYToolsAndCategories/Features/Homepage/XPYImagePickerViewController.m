//
//  XPYImagePickerViewController.m
//  XPYToolsAndCategories
//
//  Created by zhangdu_imac on 2019/11/13.
//  Copyright © 2019 xpy. All rights reserved.
//

#import "XPYImagePickerViewController.h"
#import "XPYImagePickerCollectionView.h"

#import <TZImagePickerController.h>
#import <TZImageManager.h>

static NSString * const kXPYImagePickerTableViewCellIdentifier = @"XPYImagePickerTableViewCell";
static NSInteger const kXPYMaxImagesCount = 9;

@interface XPYImagePickerViewController () <UITableViewDataSource, UITableViewDelegate, XPYImagePickerCollectionViewDelegate, TZImagePickerControllerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) XPYImagePickerCollectionView *collectionView;

@property (nonatomic, strong) NSOperationQueue *operationQueue;

@property (nonatomic, strong) NSMutableArray *selectedPhotos;
@property (nonatomic, strong) NSMutableArray *selectedAssets;

@end

@implementation XPYImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ImagePicker";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
}

#pragma mark - Private methods
- (CGFloat)heightOfCollectionView {
    //超过最大图片数量限制不显示添加按钮
    NSInteger number = self.selectedPhotos.count >= kXPYMaxImagesCount ? kXPYMaxImagesCount : self.selectedPhotos.count + 1;
    //图片显示行数
    NSInteger row = (number + 2) / 3;
    CGFloat height = row * kXPYImagePickerCollectionViewItemHeight + kXPYImagePickerCollectionViewTopSpacing + kXPYImagePickerCollectionViewBottomSpacing + (row - 1) * kXPYImagePickerCollectionViewLineSpacing;
    return height;
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kXPYImagePickerTableViewCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kXPYImagePickerTableViewCellIdentifier];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell addSubview:self.collectionView];
    self.collectionView.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), [self heightOfCollectionView]);
    [self.collectionView setupData:self.selectedPhotos];
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self heightOfCollectionView];
}

#pragma mark - XPYImagePickerCollectionViewDelegate
/// 添加图片
- (void)imagePickerCollectionViewDidClickAdd {
    TZImagePickerController *pickerController = [[TZImagePickerController alloc] initWithMaxImagesCount:kXPYMaxImagesCount columnNumber:self.selectedAssets.count delegate:self pushPhotoPickerVc:YES];
    pickerController.selectedAssets = self.selectedAssets;
    pickerController.allowTakeVideo = NO;
    pickerController.allowTakePicture = NO;
    pickerController.allowPickingGif = NO;
    pickerController.allowPickingVideo = NO;
    pickerController.showPhotoCannotSelectLayer = YES;
    pickerController.showSelectedIndex = YES;
    pickerController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:pickerController animated:YES completion:nil];
}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos {
    self.selectedAssets = [assets mutableCopy];
    self.selectedPhotos = [photos mutableCopy];
    
    [self.tableView reloadData];
    
    // 3. 获取原图的示例，用队列限制最大并发为1，避免内存暴增
    self.operationQueue = [[NSOperationQueue alloc] init];
    self.operationQueue.maxConcurrentOperationCount = 1;
    for (NSInteger i = 0; i < assets.count; i++) {
        PHAsset *asset = assets[i];
        
        //获取图片
        [[TZImageManager manager] getPhotoWithAsset:asset completion:^(UIImage *photo, NSDictionary *info, BOOL isDegraded) {
            
        }];
        
    }
    
}

#pragma mark - Getters
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [UIView new];
        _tableView.estimatedRowHeight = 0;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kXPYImagePickerTableViewCellIdentifier];
    }
    return _tableView;
}
- (XPYImagePickerCollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        _collectionView = [[XPYImagePickerCollectionView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), [self heightOfCollectionView]) collectionViewLayout:flowLayout];
        _collectionView.imagePickerDelegate = self;
    }
    return _collectionView;
}
- (NSMutableArray *)selectedAssets {
    if (!_selectedAssets) {
        _selectedAssets = [[NSMutableArray alloc] init];
    }
    return _selectedAssets;
}
- (NSMutableArray *)selectedPhotos {
    if (!_selectedPhotos) {
        _selectedPhotos = [[NSMutableArray alloc] init];
    }
    return _selectedPhotos;
}

@end
