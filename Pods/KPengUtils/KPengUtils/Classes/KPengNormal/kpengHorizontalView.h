//
//  kpengHorizontalView.h
//  SegmentDemo
//
//  Created by 王朋 on 2018/3/4.
//  Copyright © 2018年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface kpengHorizontalView : UIScrollView <UIScrollViewDelegate>


-(instancetype)initWithFrame:(CGRect)frame andTitle:(NSArray*)titleArr;

//这个是点击item的block的回调
@property (nonatomic,copy) void(^itemClickCallBack)(NSInteger itemIndex,NSString*title);

//比如下面有collectionview 滑动之后这里会显示第几个item index
@property (nonatomic,assign) NSInteger localIndex;

#pragma --mark  下面4个属性为可选功能 都有默认设置 
//被选中的 文字颜色的修改
@property (nonatomic,strong) UIColor *selectedColor;

//下面划线颜色修改 默认是红色的
@property (nonatomic,strong) UIColor * lineColor;

//未被选中的 文字字体的修改 默认为 14 nomal
@property (nonatomic,strong) UIFont *  nomalFont;

//选中文字字体的修改 默认为 粗体16
@property (nonatomic,strong) UIFont *  selectedFont;
@end
