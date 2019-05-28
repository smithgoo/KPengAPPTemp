//
//  ShopCounterView.m
//  MainProject
//
//  Created by 王朋 on 2017/5/18.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "ShopCounterView.h"
#define km_rgb_hex(rgbValue)    [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
@implementation ShopCounterView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self =[super initWithFrame:frame];
    self.layer.borderColor =(__bridge CGColorRef _Nullable)([UIColor colorWithRed:153.0f green:153.0f blue:153.0f alpha:1.0f]);
    self.layer.borderWidth =.5;
    [self setupUI];
    return self;
}

- (void)setupUI {

    _subtractionBtn  =[UIButton new];
    _subtractionBtn.tag=10001;
    _subtractionBtn.layer.borderColor =km_rgb_hex(0xdfdfdf).CGColor;
    _subtractionBtn.layer.borderWidth =.5;
    [_subtractionBtn setImage:[UIImage imageNamed:@"subtract"] forState:UIControlStateNormal];
    _subtractionBtn.backgroundColor =[UIColor whiteColor];
    [_subtractionBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self addSubview:_subtractionBtn];
    _subtractionBtn.frame =CGRectMake(0, 0, self.bounds.size.height, self.bounds.size.height);
    
    
    
    _plusBtn  =[UIButton new];
    _plusBtn.tag=10002;
    _plusBtn.layer.borderColor =km_rgb_hex(0xdfdfdf).CGColor;
    _plusBtn.layer.borderWidth =.5;
    [_plusBtn setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];
    [_plusBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    _plusBtn.backgroundColor =[UIColor whiteColor];
    [self addSubview:_plusBtn];
    _plusBtn.frame =CGRectMake(self.bounds.size.width-self.bounds.size.height, 0, self.bounds.size.height, self.bounds.size.height);

    
    _showLab =[UILabel new];
    _showLab.layer.borderColor=km_rgb_hex(0xdfdfdf).CGColor;
    _showLab.layer.borderWidth =0.5;
    _showLab.textAlignment =NSTextAlignmentCenter;
    _showLab.font =[UIFont systemFontOfSize:14];
    _showLab.backgroundColor =[UIColor whiteColor];
    _showLab.text =@"0";
    _showLab.textColor =[UIColor redColor];
    [self addSubview:_showLab];
    _plusBtn.frame =CGRectMake(self.bounds.size.height, 0,self.bounds.size.width-2* self.bounds.size.height, self.bounds.size.height);

    
    [_subtractionBtn addTarget:self action:@selector(methodAction:) forControlEvents:UIControlEventTouchUpInside];
    [_plusBtn addTarget:self action:@selector(methodAction:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)methodAction:(UIButton*)sender {

    int index =[_showLab.text intValue];
   
    if (sender.tag ==10001) {
   
        if (index ==0) {
            return;
        }
        index --;
        _showLab.text =[NSString stringWithFormat:@"%d",index];
    }else {
        index ++;
        _showLab.text =[NSString stringWithFormat:@"%d",index];
    }
     if (_choiceCountCallBack) {
        _choiceCountCallBack(index);
    }

}

 


@end
