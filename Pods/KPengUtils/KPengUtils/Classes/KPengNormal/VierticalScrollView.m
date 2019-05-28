//
//  VierticalScrollView.m
//  上下滚动btn
//
//  Created by 王朋 on 16/2/25.
//  Copyright © 2016年 kPeng. All rights reserved.
//

#import "VierticalScrollView.h"
#import "UIView+FrameExtension.h"
#define Screen_width ([UIScreen mainScreen].bounds.size.width)
#define Screen_height ([UIScreen mainScreen].bounds.size.height)
#define BTNWidth self.bounds.size.width
#define BTNHeight self.bounds.size.height

@interface VierticalScrollView ()
@property (nonatomic,strong) NSMutableArray *titles;
@property(assign, nonatomic)NSInteger titleIndex;
@property(assign, nonatomic)NSInteger index;
@end
@implementation VierticalScrollView

-(void)setBlackColor:(UIColor *)blackColor {
    _blackColor =blackColor;
}

-(void)setFrontColor:(UIColor *)frontColor {
    _frontColor =frontColor;
}


-(instancetype)initWithArray:(id)titles andFrame:(CGRect)frame titleLocation:(NSString *)location withTitleColor:(UIColor*)currentTitlecolor time:(NSTimeInterval)ti{
    if (self = [super initWithFrame:frame]) {
      
        NSMutableArray *MutableTitles = [NSMutableArray arrayWithArray:titles];
        NSString *str = @"";
        self.titles = MutableTitles;
        [self.titles addObject:str];
        self.index = 1;
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(0, 0, BTNWidth, BTNHeight);
        btn.tag = self.index;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:self.titles[0] forState:UIControlStateNormal];
        btn.titleLabel.font =[UIFont systemFontOfSize:14];
        btn.titleLabel.numberOfLines=2;
        [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        if ([location isEqualToString:@"left"]) {
          btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        } else  if ([location isEqualToString:@"right"]) {
            btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        } else {
           btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        }
       
        
        [self addSubview:btn];
        self.clipsToBounds = YES;
        
        [NSTimer scheduledTimerWithTimeInterval:ti target:self selector:@selector(nextButton:) userInfo:location repeats:YES];
    }
    
    return self;
}

+(instancetype)initWithTitleArray:(id)titles andFrame:(CGRect)frame titleLocation:(NSString *)location withTitleColor:(UIColor*)currentTitlecolor time:(NSTimeInterval)ti{
    return [[self alloc]initWithArray:titles andFrame:frame titleLocation:location withTitleColor:currentTitlecolor time:ti];
}

-(void)nextButton:(NSTimer *)timer{
    UIButton *firstBtn = [self viewWithTag:self.index];
    UIButton *modelBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, BTNHeight, BTNWidth, BTNHeight)];
    modelBtn.tag = self.index + 1;
    if ([self.titles[self.titleIndex+1] isEqualToString:@""]) {
        self.titleIndex = -1;
        self.index = 0;
    }
    if (modelBtn.tag == self.titles.count) {
        
        modelBtn.tag = 1;
    }
    
    [modelBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [modelBtn setTitle:self.titles[self.titleIndex+1] forState:UIControlStateNormal];
      [modelBtn setTitleColor:_frontColor forState:UIControlStateNormal];
      [modelBtn setBackgroundColor:_blackColor];
    modelBtn.titleLabel.font =[UIFont systemFontOfSize:14];
      modelBtn.titleLabel.numberOfLines=2;
    
    if ([[timer userInfo] isEqualToString:@"left"]) {
        modelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
      
    } else  if ([[timer userInfo] isEqualToString:@"right"]) {
        modelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
      
    } else {
        modelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    }

    [self addSubview:modelBtn];
    
    [UIView animateWithDuration:0.25 animations:^{
 
        firstBtn.frame =CGRectMake(0, -56, BTNWidth, BTNHeight);
        modelBtn.frame =CGRectMake(0, 0, BTNWidth, BTNHeight);
    } completion:^(BOOL finished) {
        [firstBtn removeFromSuperview];
        
    } ];
    self.index++;
    self.titleIndex++;
    
}

-(void)clickBtn:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(clickTitleButton:)]) {
        
        [self.delegate clickTitleButton:btn];
        
    }
}

@end
