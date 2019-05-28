//
//  KpengSingShowView.m
//  SingDemo
//
//  Created by 王朋 on 2017/9/30.
//  Copyright © 2017年 王朋. All rights reserved.
//
#import "KpengSingShowView.h"
#define km_rgb_hex(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@interface KpengSingShowView ()
{
    CABasicAnimation *basicAnimation;
    NSTimeInterval leftDuration;
    int leftTime;
    NSTimer *firstTimer;
    NSTimer *secondTimer;
}
@property (nonatomic,strong) UILabel *backLabel;
@property (nonatomic,strong) UILabel *bottomLabel;
@property (nonatomic,strong) UILabel *frontLabel;
@end

@implementation KpengSingShowView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createLabel];
        [self createMask];
    }
    return self;
}

- (void)createLabel
{
    _bottomLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [self addSubview:_bottomLabel];
    _backLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [self addSubview:_backLabel];
    _frontLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [self addSubview:_frontLabel];
}

- (void)createMask
{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    layer.colors = @[(id)[UIColor clearColor],(id)[UIColor redColor].CGColor,(id)[UIColor blackColor].CGColor,(id)[UIColor clearColor].CGColor];
    layer.locations = @[@(0.01),@(0.1),@(0.9),@(0.99)];
    
    
    CALayer *layer1 = [CALayer layer];
    layer1.frame = self.bounds;
    [_bottomLabel.layer addSublayer: layer1];
    
    
    _frontLabel.layer.mask = layer;
    
}

- (void)showAnimationWithDuration:(NSTimeInterval)duration showText:(NSString*)text alignment:(NSTextAlignment)alignment backColor:(UIColor*)backColor foreColor:(UIColor*)foreColor progressViewColor:(UIColor*)progressViewColor font:(UIFont*)font {
    _backLabel.text = text;
    _frontLabel.text = text;
    
    _backLabel.textAlignment = alignment;
    _frontLabel.textAlignment = alignment;
    
    _backLabel.textColor = backColor;
    _frontLabel.textColor = foreColor;
    _backLabel.font = font;
    _frontLabel.font = font;
    
      _bottomLabel.layer.backgroundColor =progressViewColor.CGColor;
    
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animation];
    basicAnimation1.keyPath = @"transform.translation.x";
    basicAnimation1.fromValue = @(-self.bounds.size.width);
    basicAnimation1.toValue = @(0);
    basicAnimation1.duration = duration;
    basicAnimation1.repeatCount = LONG_MAX;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeForwards;
    [_bottomLabel.layer addAnimation:basicAnimation1 forKey:nil];
    
    basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.translation.x";
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(self.bounds.size.width);
    basicAnimation.duration = duration;
    basicAnimation.repeatCount = LONG_MAX;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [_frontLabel.layer.mask addAnimation:basicAnimation forKey:nil];
    __block int rightNowTime =1;
    firstTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.text = [NSString stringWithFormat:text,(int)duration-rightNowTime];
        rightNowTime ++;
        leftTime =rightNowTime;
        if (duration ==rightNowTime) {
            _frontLabel.textColor =[UIColor whiteColor];
            _backLabel.textColor =[UIColor whiteColor];
            
        }else if (rightNowTime>duration) {
            [timer invalidate];
            timer = nil;
            [self performSelector:@selector(pauseAnimation) withObject:nil afterDelay:1.0];
            
        }
    }];
    
    
    [firstTimer fire];
}



- (void)showAnimationWithDuration:(NSTimeInterval)duration showText:(NSString*)text{
    CABasicAnimation *basicAnimation1 = [CABasicAnimation animation];
    basicAnimation1.keyPath = @"transform.translation.x";
    basicAnimation1.fromValue = @(-self.bounds.size.width);
    basicAnimation1.toValue = @(0);
    basicAnimation1.duration = duration;
    basicAnimation1.repeatCount = LONG_MAX;
    basicAnimation1.removedOnCompletion = NO;
    basicAnimation1.fillMode = kCAFillModeForwards;
    [_bottomLabel.layer addAnimation:basicAnimation1 forKey:nil];
    
    basicAnimation = [CABasicAnimation animation];
    basicAnimation.keyPath = @"transform.translation.x";
    basicAnimation.fromValue = @(0);
    basicAnimation.toValue = @(self.bounds.size.width);
    basicAnimation.duration = duration;
    basicAnimation.repeatCount = LONG_MAX;
    basicAnimation.removedOnCompletion = NO;
    basicAnimation.fillMode = kCAFillModeForwards;
    
    [_frontLabel.layer.mask addAnimation:basicAnimation forKey:nil];
    __block int rightNowTime =1;
    firstTimer =[NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        self.text = [NSString stringWithFormat:text,(int)duration-rightNowTime];
        rightNowTime ++;
        leftTime =rightNowTime;
        if (duration ==rightNowTime) {
            _frontLabel.textColor =[UIColor whiteColor];
            _backLabel.textColor =[UIColor whiteColor];
            
        }else if (rightNowTime>duration) {
            [timer invalidate];
            timer = nil;
            [self performSelector:@selector(pauseAnimation) withObject:nil afterDelay:1.0];
            
        }
    }];
    
    
    [firstTimer fire];
}

//暂停动画
- (void)pauseAnimation {
    
    //（0-5）
    //开始时间：0
    //    myView.layer.beginTime
    //1.取出当前时间，转成动画暂停的时间
    CFTimeInterval pauseTime = [_bottomLabel.layer convertTime:CACurrentMediaTime() fromLayer:nil];
    
    //2.设置动画的时间偏移量，指定时间偏移量的目的是让动画定格在该时间点的位置
    _bottomLabel.layer.timeOffset = pauseTime;
    
    //3.将动画的运行速度设置为0， 默认的运行速度是1.0
    _bottomLabel.layer.speed = 0;
    
}


- (void)setBackColor:(UIColor *)backColor
{
    _backColor = backColor;
    _backLabel.textColor = backColor;
    _bottomLabel.layer.backgroundColor =km_rgb_hex(0x0198AE).CGColor;
    
}

- (void)setForeColor:(UIColor *)foreColor
{
    _foreColor = foreColor;
    _frontLabel.textColor = foreColor;
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    _backLabel.font = font;
    _frontLabel.font = font;
}

- (void)setAlignment:(NSTextAlignment)alignment
{
    _alignment = alignment;
    _backLabel.textAlignment = alignment;
    _frontLabel.textAlignment = alignment;
}

- (void)setText:(NSString *)text
{
    _text = text;
    _backLabel.text = text;
    _frontLabel.text = text;
}

@end
