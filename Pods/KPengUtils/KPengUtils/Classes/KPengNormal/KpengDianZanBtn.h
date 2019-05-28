//
//  KpengDianZanBtn.h
//  dianzanBtnDemo
//
//  Created by 王朋 on 2017/11/6.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 按钮使用前这个点赞的按钮的高度 最好不要超过44  为了实现动画效果 最小为30*30 最大为44*44
 */
@interface KpengDianZanBtn : UIButton

@property (nonatomic,strong) NSString *title;

@property (nonatomic,copy) void(^btnActionCallBack)(BOOL states,UIButton *sender);

@property (nonatomic,strong) UILabel * addLab;
@end
