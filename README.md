# ToolsAndCategories

※ XLBlockAlertView：UIAlertView使用Block着陆

※ XLBlockActionSheet：UIActionSheet实现着陆

※ XLNoticeHelper：简单提示控件

※ XLColorTool：获取纯色图片

    UIImage *resultImage = [XLColorTool imageWithColor:[UIColor redColor]];

※ XPYCategoryTitleView和XPYCategoryContentView：分页切换控件，实现tab切换页面

※ XPYCopyLabel：可长按复制标签

    XPYCopyLabel *label = [[XPYCopyLabel alloc] initWithFrame:CGRectMake(200, 200, 100, 50)];
    
    label.text = @"点我复制";
    
    [label sizeToFit];
    
    label.isCanCopy = YES;
    
    label.selelctedBackgroundColor = [UIColor grayColor];
    
    [self.view addSubview:label];

※ 一些简单动画效果

  · XPYDrawingView：绘制各类图形
  · 平移、旋转、缩放动画（点赞缩放、轨迹运动）
  · 自定义转场动画

※ runtime相关功能 MethodSwizzling

    UIViewController+XPYScrollViewInsets：全局实现UIScrollViewContentInsetAdjustmentNever
    
    NSArray+XPYAvoidOutOfRange：防止数组越界Crash

※ XPYPerson链式编程测试

※ XPYUtilities常用工具类实现一些小功能

※ XPYFileManager，用于沙盒存储数据

    //截屏并保存到沙盒
    
    UIImage *snapshotImage = [self.view snapshotImage];

    NSString *cachePath = [XPYFileManager cacheFilePathWithKey:@"SnapshotCache"];

    if ([XPYFileManager createCacheDirectoryWithFilePath:cachePath]) {

        NSData *imageData = UIImagePNGRepresentation(snapshotImage);
        
        NSString *dataPath = [cachePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@_snapshop_image.png", @(self.hash)]];
        
        if ([XPYFileManager saveFile:ima geData toPath:dataPath]) {
        
             //获得已经保存的图片
            
            NSData *data = [XPYFileManager dataWithFilePath:dataPath];
            
            UIImage *image = [UIImage imageWithData:data];
            
            NSLog(@"success");
            
        }
        
    }
 
※ XPYAlertController（链式编程Alert）和XPYAlertManager（管理XPYAlertController）
 
    XPYAlertModel *alertModel = [[XPYAlertModel alloc] initWithTitle:@"提示" message:@"请注意xxxxxxxxxx" style:UIAlertControllerStyleActionSheet];
    
    [XPYAlertController makeAlert:^(XPYAlertController * _Nonnull controller) {
    
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
            NSLog(@"取消");
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
            NSLog(@"确定");
            
            [XPYAlertManager showAlertWithTitle:@"确定" message:@"点击了确定" cancel:@"取消" confirm:@"确定" inController:self confirmHandler:^{
            
                NSLog(@"alert confirm");
                
            } cancelHandler:^{
            
                NSLog(@"alert cancel");
                
            }];
            
        }];
        
        UIAlertAction *action3 = [UIAlertAction actionWithTitle:@"哈哈" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
            NSLog(@"哈哈");
            
            [XPYAlertManager showActionSheetWithTitle:@"哈哈" message:@"点击了哈哈" cancel:@"取消" inController:self actions:@[@"item0", @"item1", @"item2"] actionHandler:^(NSInteger index) {
            
                NSLog(@"click item%@", @(index));
                
            }];
            
        }];
        
        controller.actionItems(@[action1, action2, action3]).showAlert(self);
        
    } alertModel:alertModel];
 
 ※ 3D Touch相关内容
 
 ※ 网络框架相关（使用CTMediator实现网络组件）
