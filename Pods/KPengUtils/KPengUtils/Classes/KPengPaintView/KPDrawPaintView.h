//
//  KPDrawPaintView.h
//  gifAnimation
//
//  Created by 王朋 on 2019/5/20.
//  Copyright © 2019 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KPDrawPaintPath : UIBezierPath

@property (nonatomic, strong) UIColor *lineColor;

+ (instancetype)path;
@end

@interface KPDrawPaintView : UIView

//线的颜色
@property (nonatomic,strong) UIColor *lineColor;

//线的宽度 粗细
@property (nonatomic,assign) float lineWidth;


@property (nonatomic,copy) void(^savePicSuccessCallBack)(UIImage* img);

//清空当前画布
- (void)cleanCurrentPaint;

//撤销当前画的一笔
- (void)undoLastLine;

//保存当前的画布
-(void)saveCurrentPaint;


@end

NS_ASSUME_NONNULL_END
