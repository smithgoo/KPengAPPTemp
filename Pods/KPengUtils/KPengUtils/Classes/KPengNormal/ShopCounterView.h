//
//  ShopCounterView.h
//  MainProject
//
//  Created by 王朋 on 2017/5/18.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShopCounterView : UIView

// 加号按钮
@property (nonatomic,strong) UIButton *subtractionBtn;

//减号按钮
@property (nonatomic,strong) UIButton *plusBtn;


//显示的label
@property (nonatomic,strong) UILabel *showLab;


@property (nonatomic,copy) void(^choiceCountCallBack)(int counts);

@end
