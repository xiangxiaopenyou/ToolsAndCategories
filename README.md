# ToolsAndCategories
UIControl+Blocks：继承自UIControl的控件添加点击Block

NSData+gyh：日期处理相关

UIImage+ImageEffects：图片处理高斯模糊等效果

UIImage+ResizeMagick:图片压缩处理

XLHyperLinkButton：button加下划线

XLBlockAlertView：UIAlertView实现Block

XLBlockActionSheet：UIActionSheet实现Block

XLNoticeHelper：简单提示控件

XLColorTool：单一颜色图片

增加一些简单动画效果

自定义转场效果

增加一些runtime相关功能 MethodSwizzling（UIViewController+XPYScrollViewInsets）

增加XPYFileManager，用于沙盒存储数据，例：

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
