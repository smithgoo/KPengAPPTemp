//
//  KpengSingShowView.h
//  SingDemo
//
//  Created by 王朋 on 2017/9/30.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KpengSingShowView : UIView

@property (nonatomic,strong) NSString *text;
@property (nonatomic,assign) NSTextAlignment alignment;
@property (nonatomic,strong) UIColor *backColor;
@property (nonatomic,strong) UIColor *foreColor;
@property (nonatomic,strong) UIFont *font;

/**
 歌词显示时间和调用方法

 @param duration 显示时间
 @param text 显示文字
 @param alignment 居中模式
 @param backColor 文字底部颜色
 @param foreColor 文字前景色
 @param font 文字的字体大小
 */
- (void)showAnimationWithDuration:(NSTimeInterval)duration showText:(NSString*)text alignment:(NSTextAlignment)alignment backColor:(UIColor*)backColor foreColor:(UIColor*)foreColor progressViewColor:(UIColor*)progressViewColor font:(UIFont*)font ;


- (void)showAnimationWithDuration:(NSTimeInterval)duration showText:(NSString*)text;
@end
