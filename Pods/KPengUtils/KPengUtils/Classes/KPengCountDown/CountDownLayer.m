//
//  CountDownLayer.m
//  cycleView
//
//  Created by 王朋 on 2018/6/11.
//  Copyright © 2018 王朋. All rights reserved.
//

#import "CountDownLayer.h"

@implementation CountDownLayer

-(instancetype)initWithFrame:(CGRect)frame countDown:(NSInteger)times{
    
    self =[super initWithFrame:frame];
    [self setupUI:times];
    return self;
}

-(void)setupUI:(NSInteger)times {
    
    UIBezierPath *path =[UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) radius:self.frame.size.width/2 startAngle:-0.5*M_PI endAngle:2*M_PI clockwise:YES];
    CAShapeLayer *bgLayer =[CAShapeLayer layer];
    [self.layer addSublayer:bgLayer];
    bgLayer.path =path.CGPath;
    bgLayer.fillColor =[UIColor clearColor].CGColor;
    bgLayer.strokeColor =[UIColor colorWithRed:33.0/255.0 green:33.0/255.0 blue:33.0/255.0 alpha:1.0].CGColor;
    bgLayer.lineWidth =3;
    arcLayer =[CAShapeLayer layer];
    arcLayer.path =path.CGPath;
    arcLayer.fillColor =[UIColor clearColor].CGColor;
    arcLayer.strokeColor =[UIColor whiteColor].CGColor;
    arcLayer.lineWidth =3;
    arcLayer.frame =CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    [self.layer addSublayer:arcLayer];
    
 
    
    countDownLab =[UILabel new];
    countDownLab.font =[UIFont systemFontOfSize:10];
    countDownLab.numberOfLines =2;
    [self addSubview:countDownLab];
    countDownLab.frame =CGRectMake(0, (self.frame.size.height-42)/2, self.frame.size.width, 42);
    countDownLab.textColor =[UIColor blackColor];
    countDownLab.textAlignment =NSTextAlignmentCenter;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"跳过\n%lds",times]];
    NSRange range =[[NSString stringWithFormat:@"跳过\n%lds",times] rangeOfString:@"跳过"];
    //addAttributes：添加多个属性
    NSMutableDictionary * dic=[NSMutableDictionary dictionary];
    dic[NSFontAttributeName]=[UIFont boldSystemFontOfSize:12];
    [attrStr addAttributes:dic range:range];
    countDownLab.attributedText =attrStr;
    
    
    
    countDown =times;
    [self drawLineAnimation:arcLayer withTime:times];
    
}
 
-(void)drawLineAnimation:(CALayer*)layer withTime:(NSInteger)times

{
    
    CABasicAnimation *bas=[CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    
    bas.duration=times;
    
    bas.delegate=self;
    
    bas.fromValue=[NSNumber numberWithInteger:1];
    
    bas.toValue=[NSNumber numberWithInteger:0];
    
    [layer addAnimation:bas forKey:@"key"];
 
}

- (void)animationDidStart:(CAAnimation *)anim {
 
    timer= [NSTimer timerWithTimeInterval:1 target:self selector:@selector(countDownAction) userInfo:nil repeats:YES];
    // 正常触发
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
}

- (void)countDownAction {
    countDown --;
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"跳过\n%lds",countDown]];
    NSRange range =[[NSString stringWithFormat:@"跳过\n%lds",countDown] rangeOfString:@"跳过"];
    //addAttributes：添加多个属性
    NSMutableDictionary * dic=[NSMutableDictionary dictionary];
    dic[NSFontAttributeName]=[UIFont boldSystemFontOfSize:12];
    [attrStr addAttributes:dic range:range];
    countDownLab.attributedText =attrStr;
    if (countDown <=0) {
        [timer invalidate];
        timer =nil;
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    if (flag) {
        if (_finlishAction) {
            [self removeFromSuperview];
            _finlishAction();
        }
    }
}




@end
