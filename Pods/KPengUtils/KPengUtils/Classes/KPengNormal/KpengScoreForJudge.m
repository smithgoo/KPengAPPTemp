//
//  KpengScoreForJudge.m
//  MainProject
//
//  Created by smithgoo on 2017/11/1.
//  Copyright © 2017年 tony. All rights reserved.
//

#import "KpengScoreForJudge.h"
#import "UIView+size.h"
@interface KpengScoreView ()
/**
 角度幅度
 */
@property (nonatomic,assign) CGFloat radius;

@property (nonatomic,assign) CGRect rectFrame;
@end
@implementation KpengScoreView : UIView
#define pth (M_PI/180)
-(instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    [self initmeatData:frame];
    return self;
}

-(void)initmeatData:(CGRect)frame {
    _rectFrame =frame;
    self.backgroundColor = [UIColor clearColor];
    self.opaque = NO;
    CGFloat x = CGRectGetWidth(frame)/2;
    CGFloat y = CGRectGetHeight(frame)/2;
    self.radius = MIN(x, y);
    _backColor   =[UIColor blackColor];
    _strokeColor = [UIColor clearColor];
 }

-(void)setProgress:(CGFloat)progress {
    if (progress < 0) {
        _progress = 0;
    }else if(progress > 1){
        _progress = 1;
    }else{
        _progress = progress;
    }
    [self setNeedsDisplay];
 }

-(void)setBackColor:(UIColor *)backColor {
    _backColor =backColor;
    [self setNeedsDisplay];
 }

-(void)setFillColor:(UIColor *)fillColor {
    _fillColor =fillColor;
    [self setNeedsDisplay];
 }

-(void)setStrokeColor:(UIColor *)strokeColor {
    _strokeColor =strokeColor;
    [self setNeedsDisplay];
 }



- (void) drawRect:(CGRect)rect{
    CGFloat centerX = CGRectGetMidX(rect);
    CGFloat centerY = CGRectGetMidY(rect);
    /**
     *  算小圆radius: 五角星中 每个角是36度 r0/斜边 = sin(18)
     *                                radius/斜边 = cos(36)
     *                              -> r0*cos(36) = sin(18)*radius
     *                              -> r0 = radius*sin(18)/cos(36)
     */
    CGFloat r0 = self.radius * sin(18 * pth)/cos(36 * pth);//计算半经
    CGFloat x1[5] = {0} ,y1[5] = {0} ,x2[5] = {0} ,y2[5] = {0};
    //计算坐标
    for (int i = 0; i < 5; i++) {
        x1[i] = centerX + self.radius * cos((90 + i * 72)*pth);
        y1[i] = centerY - self.radius * sin((90 + i * 72)*pth);
        x2[i] = centerX + r0 * cos((54 + i * 72)*pth);
        y2[i] = centerY - r0 * sin((54 + i * 72)*pth);
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, x1[0], y1[0]);
    for (int i = 1; i<5; i++) {
        CGPathAddLineToPoint(path, NULL, x2[i], y2[i]);
        CGPathAddLineToPoint(path, NULL, x1[i], y1[i]);
    }
    CGPathAddLineToPoint(path, NULL, x2[0], y2[0]);
    CGPathCloseSubpath(path);
    
    CGContextSetFillColorWithColor(context, self.backColor.CGColor);
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGRect rangefull = CGRectMake(x1[1], 0, (x1[4] - x1[1]), y1[2]);
    CGContextFillRect(context, rangefull);
    
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    
    CGContextSetFillColorWithColor(context, self.fillColor.CGColor);
    CGContextSetStrokeColorWithColor(context, self.strokeColor.CGColor);
    
    CGContextAddPath(context, path);
    CGContextClip(context);
    CGRect range = CGRectMake(x1[1], 0, (x1[4] - x1[1])*self.progress, y1[2]);
    CGContextFillRect(context, range);
    
    CGContextAddPath(context, path);
    CGContextStrokePath(context);
    
    CFRelease(path);
}

@end


@interface KpengScoreForJudge()
@property (nonatomic,strong) NSMutableArray<KpengScoreView *> *starViews;
@end

@implementation KpengScoreForJudge


- (instancetype)initWithFrame:(CGRect)frame {
    
    self =[super initWithFrame:frame];
    
    [self setupUI];
    return self;
}

- (void)setupUI {
    
    _starViews = [NSMutableArray array];
    
    _rate = 0;
    _leftMargin = 10;
    _rightMargin = 10;
    _midMargin = 2;
    self.maxCount = 5;
}

- (void) setMaxCount:(NSInteger)maxCount{
    _maxCount = maxCount;
    
    [self.starViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.starViews removeAllObjects];
    for (int i = 0; i< maxCount; i++) {
        CGFloat w = (self.frame.size.width - self.leftMargin - self.rightMargin - self.midMargin*(self.maxCount - 1))/self.maxCount;
        CGFloat width = MIN(w, self.frame.size.height);
        CGFloat x = self.leftMargin + i *(width + self.midMargin);
        CGFloat y = 0;
        KpengScoreView *view = [[KpengScoreView alloc]initWithFrame:CGRectMake(x, y, width, width)];
        view.centerY = CGRectGetHeight(self.frame)/2;
        [self addSubview:view];
        [self.starViews addObject:view];
    }
    
    [self setNeedsLayout];
    [self refresh];
}

- (void) refresh{
    for (int i = 0; i < self.starViews.count; i++) {
        KpengScoreView *view = self.starViews[i];
        view.fillColor =_fillColor;
        if (self.rate >= i+1) {
            view.progress = 1;
        }else if(self.rate > i){
            view.progress = self.rate - i;
        }else{
            view.progress = 0;
        }
    }
}

#pragma mark - 设分
- (void) setRate:(CGFloat)rate{
    _rate = rate;
    [self refresh];
}

#pragma makr - touches
- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        if (self.needMoveTouch) {
    CGPoint point = [[touches anyObject]locationInView:self];
    [self configraRateWithPoint:point];
        }
}
- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
        if (self.needMoveTouch) {
    CGPoint point = [[touches anyObject]locationInView:self];
    [self configraRateWithPoint:point];
        }
    
}

- (void) configraRateWithPoint:(CGPoint)point{
    for (int i = 0; i < self.maxCount; i++) {
        KpengScoreView *view = self.starViews[i];
        if (CGRectContainsPoint(view.frame, point)) {
            CGFloat distance = (point.x - self.leftMargin - i*CGRectGetWidth(view.frame) - i *self.midMargin)/CGRectGetWidth(view.frame);
            if (distance < 0.5 ) {
                distance = 0.0;
            }else if(distance<1){
                distance =0.5;
            } else{
                distance = 1.;
            }
         
            CGFloat rate = i+distance ;
            if (rate > self.maxCount - 0.1) {
                self.rate = self.maxCount;
            }else if(rate < 0.1){
                self.rate = 0;
            }else{
                self.rate = rate;
            }
            if (_scoreRefersh) {
                _scoreRefersh(rate);
            }
        }
    }
}

@end
