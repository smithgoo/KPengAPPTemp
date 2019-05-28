//
//  VierticalScrollView.h
//  上下滚动btn
//
//  Created by 王朋 on 16/2/25.
//  Copyright © 2016年 kPeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol VierticalScrollViewDelegate <NSObject>


@optional

-(void)clickTitleButton:(UIButton *)button;




@end


@interface VierticalScrollView : UIView


@property (nonatomic,strong) id<VierticalScrollViewDelegate> delegate;

-(instancetype)initWithArray:(id )titles andFrame:(CGRect)frame titleLocation:(NSString *)location withTitleColor:(UIColor*)currentTitlecolor time:(NSTimeInterval)ti;
+(instancetype)initWithTitleArray:(id )titles andFrame:(CGRect)frame titleLocation:(NSString *)location withTitleColor:(UIColor*)currentTitlecolor time:(NSTimeInterval)ti;

@property (nonatomic,strong) UIColor *frontColor;

@property (nonatomic,strong) UIColor *blackColor;


@end
