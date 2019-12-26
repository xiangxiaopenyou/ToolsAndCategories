# ToolsAndCategories

1、UIControl+Blocks：继承自UIControl的控件添加点击Block

2、NSData+gyh：日期处理相关

3、UIImage+ImageEffects：图片处理高斯模糊等效果

4、UIImage+ResizeMagick：图片压缩处理

5、XPYHyperLinkButton：button加下划线

6、XLBlockAlertView：UIAlertView实现Block

7、XLBlockActionSheet：UIActionSheet实现Block

8、XLNoticeHelper：简单提示控件

9、XLColorTool：单一颜色图片

10、XPYCategoryTitleView和XPYCategoryContentView：分页切换控件

11、XPYCopyLabel：可长按复制标签

    XPYCopyLabel *label = [[XPYCopyLabel alloc] initWithFrame:CGRectMake(200, 200, 100, 50)];
    label.text = @"点我复制";
    [label sizeToFit];
    label.isCanCopy = YES;
    label.selelctedBackgroundColor = [UIColor grayColor];
    [self.view addSubview:label];

10、增加一些简单动画效果

（1）XPYDrawingView：绘制各类图形
（2）平移、旋转、缩放动画（点赞缩放、轨迹运动）
（3）自定义转场动画

11、增加一些runtime相关功能 MethodSwizzling（UIViewController+XPYScrollViewInsets）

12、XPYPerson链式编程测试

13、XPYUtilities常用工具类

14、增加XPYFileManager，用于沙盒存储数据，例：

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
 
 15、增加XPYAlertController（链式编程Alert）和XPYAlertManager（管理XPYAlertController）例：
 
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
 
