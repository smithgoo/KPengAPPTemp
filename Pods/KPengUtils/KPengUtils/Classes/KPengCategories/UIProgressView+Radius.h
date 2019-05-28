//
//  UIProgressView+Radius.h
//  SpokenEvaluation
//
//  Created by 王朋 on 2017/8/7.
//  Copyright © 2017年 cnsunrun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIProgressView (Radius)

 -(void)setRadiusTrackColor:(UIColor*)trackColor cornerRadius:(float )cornerRadius;
-(void)setRadiusProgressColor:(UIColor*)progressColor cornerRadius:(float )cornerRadius;
-(void)setRadiusTrackColor:(UIColor*)trackColor progressColor:(UIColor*)progressColor cornerRadius:(float )cornerRadius;
@end
