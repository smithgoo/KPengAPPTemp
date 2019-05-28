//
//  KPIdCodeView.h
//  1.8Things
//
//  Created by 王朋 on 2018/4/2.
//  Copyright © 2018年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol CodeStrDelegate <NSObject>

-(void)getCodeToRequestWeb:(NSString*)str;


@end

@interface KPIdCodeView : UIView

-(instancetype)initWithFrame:(CGRect)frame codeCount:(NSInteger)count;
@property (nonatomic,assign) NSInteger codeCount;

@property (nonatomic,copy) void(^idCodeCallBack)(NSString *code);

@property (nonatomic,weak) id <CodeStrDelegate> delegate;
@end
