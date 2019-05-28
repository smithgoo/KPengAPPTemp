//
//  KpengScoreForJudge.h
//  MainProject
//
//  Created by smithgoo on 2017/11/1.
//  Copyright © 2017年 tony. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KpengScoreView : UIView

/**
 边框线颜色
 */
@property (nonatomic,strong) UIColor *strokeColor;

/**
 填充颜色
 */
@property (nonatomic,strong) UIColor *fillColor;

/**
 背景色
 */
@property(nonatomic,strong) UIColor *backColor;


/**
 半颗星 和全星的比率
 */
@property (nonatomic,assign) CGFloat progress;// 0~1间
 
@end



@interface KpengScoreForJudge : UIView
//分数的比例 0~maxCount
@property (nonatomic,assign) IBInspectable CGFloat rate;
@property (nonatomic,assign) IBInspectable CGFloat leftMargin;
@property (nonatomic,assign) IBInspectable CGFloat rightMargin;
@property (nonatomic,assign) IBInspectable CGFloat midMargin;
/// 默认 = 5  可以设更多 和更少
@property (nonatomic,assign) IBInspectable NSInteger maxCount;
@property (nonatomic,assign) IBInspectable BOOL needMoveTouch;//可以滑动，点击是userInteractionEnabled属性
@property (nonatomic,copy)  void(^scoreRefersh)(CGFloat rate);

/**
 填充颜色
 */
@property (nonatomic,strong) UIColor *fillColor;
@end
