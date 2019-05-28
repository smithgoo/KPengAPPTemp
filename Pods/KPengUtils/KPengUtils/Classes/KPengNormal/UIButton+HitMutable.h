//
//  UIButton+HitMutable.h
//  MainProject
//
//  Created by 王朋 on 2017/8/4.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIButton (HitMutable)
/**
 *  为按钮添加点击间隔 eventTimeInterval秒
 */
@property (nonatomic, assign) NSTimeInterval eventTimeInterval;
@end
