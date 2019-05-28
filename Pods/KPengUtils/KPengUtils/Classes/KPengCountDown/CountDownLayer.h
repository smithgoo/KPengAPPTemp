//
//  CountDownLayer.h
//  cycleView
//
//  Created by 王朋 on 2018/6/11.
//  Copyright © 2018 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CountDownLayer : UIView <CAAnimationDelegate>
{
    CAShapeLayer *arcLayer;
    UILabel *countDownLab;
    NSInteger countDown;
    NSTimer *timer;
}
-(instancetype)initWithFrame:(CGRect)frame countDown:(NSInteger)times;

@property (nonatomic,copy) void (^finlishAction)();
@end
