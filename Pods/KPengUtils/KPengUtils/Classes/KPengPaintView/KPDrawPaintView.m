//
//  KPDrawPaintView.m
//  gifAnimation
//
//  Created by 王朋 on 2019/5/20.
//  Copyright © 2019 王朋. All rights reserved.
//

#import "KPDrawPaintView.h"
#import <Photos/Photos.h>
#import "WHCFileManager.h"
@implementation  KPDrawPaintPath

+(instancetype)path {
    KPDrawPaintPath *path =[self new];
    
    return path;
}

@end
@interface KPDrawPaintView ()

//记录当前记录
@property (nonatomic,strong) NSMutableArray *pathArr;

//贝塞尔的曲线单元
@property (nonatomic,strong) UIBezierPath *path;

@end

@implementation KPDrawPaintView


- (instancetype)initWithFrame:(CGRect)frame {
    self =[super initWithFrame:frame];
    _lineColor =[UIColor blackColor];
    _lineWidth = 1.0;
    return self;
}


- (NSMutableArray*)pathArr {
    if (!_pathArr) {
        _pathArr =[NSMutableArray array];
    }
    return _pathArr;
}

//手指在当前视图上开始滑动的点用贝塞尔画曲线
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch =[touches anyObject];
    
    CGPoint CurrentPoint =[touch locationInView:self];
    
    KPDrawPaintPath *path =[KPDrawPaintPath path];
    
    path.lineColor =_lineColor;
    [path moveToPoint:CurrentPoint];
    path.lineWidth =_lineWidth;
    
    _path =path;
    
    [self.pathArr addObject:_path];
    
}

//移动的时候根据 手的接触来添加线条
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch =[touches anyObject];
    
    CGPoint CurrentPoint =[touch locationInView:self];
    
    [_path addLineToPoint:CurrentPoint];
    
    [self setNeedsDisplay];
    
}

//画图和填充
- (void)drawRect:(CGRect)rect {
    
    for (KPDrawPaintPath *path  in _pathArr) {
        [path.lineColor set];
        [path stroke];
    }
}

//清空当前画布
- (void)cleanCurrentPaint {
    [self.pathArr removeAllObjects];
    [self setNeedsDisplay];
}

//撤销当前画的一笔
- (void)undoLastLine {
    [self.pathArr removeLastObject];
    [self setNeedsDisplay];
}

//保存当前的画布
-(void)saveCurrentPaint {
   
    [self savePic:[self imageToTransparent:[self convertViewToImage:self]]];
}

#pragma mark view 生成image
- (UIImage *)convertViewToImage:(UIView *)view {
    
    UIImage *imageRet = [[UIImage alloc]init];
    //UIGraphicsBeginImageContextWithOptions(区域大小, 是否是非透明的, 屏幕密度);
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    imageRet = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageRet;
    
}

//橡皮功能是白色的 然后通过改变 将白色转换成透明
- (UIImage*) imageToTransparent:(UIImage*) image {
    // 分配内存
    const int imageWidth = image.size.width;
    const int imageHeight = image.size.height;
    size_t bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 创建context
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf, imageWidth, imageHeight, 8, bytesPerRow, colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), image.CGImage);
    
    // 遍历像素
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        //取白色
        //将像素点转成子节数组来表示---第一个表示透明度即ARGB这种表示方式。ptr[0]:透明度,ptr[1]:R,ptr[2]:G,ptr[3]:B
        //分别取出RGB值后。进行判断需不需要设成透明。
        uint8_t* ptr = (uint8_t*)pCurPtr;
        // NSLog(@"1是%d,2是%d,3是%d",ptr[1],ptr[2],ptr[3]);
        if(ptr[1] == 255 && ptr[2] == 255 && ptr[3] == 255){
            ptr[0] = 0;
        }
    }
    
    // 将内存转成image
    CGDataProviderRef dataProvider =CGDataProviderCreateWithData(NULL, rgbImageBuf, bytesPerRow * imageHeight, nil);
    CGImageRef imageRef = CGImageCreate(imageWidth, imageHeight,8, 32, bytesPerRow, colorSpace,
                                        kCGImageAlphaLast |kCGBitmapByteOrder32Little, dataProvider,
                                        NULL, true,kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    // 释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
}
- (BOOL)CanPhotoLibary{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    if (authStatus == PHAuthorizationStatusRestricted|| authStatus == PHAuthorizationStatusDenied) {
        return NO;
    }else{
        return YES;
    }
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSString *version = [UIDevice currentDevice].systemVersion;
        if (version.doubleValue >= 10.0) {
            // 针对 11.0 以上的iOS系统进行处理
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
        } else {
            // 针对 11.0 以下的iOS系统进行处理
            NSURL*url = [NSURL URLWithString:@"prefs:root=About"];
            if ([[UIApplication sharedApplication] canOpenURL:url]){
                [[UIApplication sharedApplication] openURL:url];
            }
        }
        
    }
    
}


- (IBAction)savePic:(UIImage *)img {
    
    if (![self CanPhotoLibary]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"相册保存功能受限,前往设置"  delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"设置",nil];
        [alert show];
    } else {
        
//        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        NSString *path =[[WHCFileManager documentsDir] stringByAppendingPathComponent:@"imgPath"];
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *directryPath = [path stringByAppendingPathComponent:@"imageViews"];
        [fileManager createDirectoryAtPath:directryPath withIntermediateDirectories:YES attributes:nil error:nil];
        NSString *filePath = [directryPath stringByAppendingPathComponent:[NSString stringWithFormat:@"1.png"]]; // 保存文件的名称
        BOOL result = [UIImagePNGRepresentation(img)writeToFile: filePath   atomically:YES]; // 保存成功
        if (result) {
            //            [self makeToast:@"保存成功"];
            NSLog(@"保存成功");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                if (_savePicSuccessCallBack) {
                    _savePicSuccessCallBack(img);
                }
            });
           
        } else {
            //            [self makeToast:@"保存失败"];
            NSLog(@"保存失败");
        }
        
    }
    
}


@end
