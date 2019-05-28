//
//  KPIdCodeView.m
//  1.8Things
//
//  Created by 王朋 on 2018/4/2.
//  Copyright © 2018年 王朋. All rights reserved.
//

#import "KPIdCodeView.h"
#import "UITextField+deleteBackward.h"
#define SELECTED_Color [UIColor colorWithRed:130/255.0 green:165/255.0 blue:255/255.0 alpha:1.00]
#define UNSELECTED_Color [UIColor colorWithRed:230/255.0 green:230/255.0 blue:230/255.0 alpha:1.00]

@interface KPIdCodeView ()<UITextFieldDelegate>
@property (nonatomic,strong) NSMutableArray <UITextField*>*tefArr;
@property (nonatomic,strong) NSMutableArray <UIView*>*lineArr;

@end
@implementation KPIdCodeView

-(instancetype)initWithFrame:(CGRect)frame codeCount:(NSInteger)count {
    
    self =[super initWithFrame:frame];
    self.backgroundColor =[UIColor whiteColor];
    _codeCount =count;
    [self setupUIWith:count];
    return self;
}


-(void)setupUIWith:(NSInteger)count{
    if (count<=0) {
        return ;
    }
    _tefArr =[NSMutableArray array];
    _lineArr =[NSMutableArray array];
    
    for (int index =0; index<count; index ++) {
        
        UITextField *tef =[UITextField new];
        [self addSubview:tef];
        tef.frame =CGRectMake((self.frame.size.width-(self.frame.size.height-1)*count)/(count+1)*(index+1)+(self.frame.size.height-1)*index, 0, (self.frame.size.height-1), (self.frame.size.height-1));
        [_tefArr addObject:tef];
        tef.tag =9000+index;
        tef.delegate =self;
        tef.textAlignment =NSTextAlignmentCenter;
        tef.keyboardType =UIKeyboardTypeNumberPad;
        [tef addTarget:self action:@selector(textChangeAction:) forControlEvents:UIControlEventEditingChanged];
        
        UIView *line =[UIView new];
        [self addSubview:line];
        line.frame =CGRectMake(CGRectGetMinX(tef.frame), CGRectGetMaxY(tef.frame), (self.frame.size.height-1), 1);
        [_lineArr addObject:line];
        line.tag =9100+index;
        line.backgroundColor =UNSELECTED_Color;
        
    }
    
    UITextField *tef =[self viewWithTag:9000];
    [tef becomeFirstResponder];
    
}


-(void)textFieldDidEndEditing:(UITextField *)textField {
    if (textField.text.length>0) {
        textField.text =[textField.text substringToIndex:1];
        if (textField.text.length>0&&textField==_tefArr.lastObject) {
            UIView *v =[self viewWithTag:_codeCount-1+9100];
            v.backgroundColor =SELECTED_Color;
        }
    }
}

// 删除按钮的监听 用于监听退格
- (void)textFieldDidDeleteBackward:(UITextField *)textField {
    [_tefArr enumerateObjectsUsingBlock:^(UITextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj ==textField) {
            if (idx ==0) {
                UITextField *tef =[_tefArr objectAtIndex:0];
                [tef becomeFirstResponder];
                UIView *v =[self viewWithTag:idx+9100];
                v.backgroundColor =UNSELECTED_Color;
            } else {
                UITextField *tef =[_tefArr objectAtIndex:(idx-1)];
                [tef becomeFirstResponder];
                UIView *v =[self viewWithTag:idx+9100];
                v.backgroundColor =UNSELECTED_Color;
            }
        }
    }];
    
}


-(void)textChangeAction:(UITextField *)textField{
    NSLog(@"textField1 - 输入框内容改变,当前内容为: %@",textField.text);
    if (textField==_tefArr.lastObject) {
        if (textField.text.length>0) {
            textField.text =[textField.text substringToIndex:1];
        }
        
    }
    __block NSString *codeStr =@"";
    [_tefArr enumerateObjectsUsingBlock:^(UITextField * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (textField ==obj &&textField.text.length>0) {
            if (idx+1>=_tefArr.count) {
                *stop =YES;
            } else {
                UITextField *tef =[_tefArr objectAtIndex:(idx+1)];
                [tef becomeFirstResponder];
                UIView *v =[self viewWithTag:idx+9100];
                v.backgroundColor =SELECTED_Color;
            }
        } else  if (textField ==obj &&textField.text.length==0) {
            if (idx ==0) {
                UITextField *tef =[_tefArr objectAtIndex:0];
                [tef becomeFirstResponder];
                UIView *v =[self viewWithTag:idx+9100];
                v.backgroundColor =UNSELECTED_Color;
            } else {
                UITextField *tef =[_tefArr objectAtIndex:(idx-1)];
                [tef becomeFirstResponder];
                UIView *v =[self viewWithTag:idx+9100];
                v.backgroundColor =UNSELECTED_Color;
            }
        }
        codeStr =[codeStr stringByAppendingString:obj.text];
        
        
    }];
    NSLog(@"%@-----codeStr---",codeStr);
    if (codeStr.length<=0) {
        
    }
    if (codeStr.length>=_codeCount) {
        //网络请求
        [self endEditing:YES];
        //两种方法实现回调
        if (_idCodeCallBack) {
            _idCodeCallBack(codeStr);
        }
        
        if (self.delegate &&[self.delegate respondsToSelector:@selector(getCodeToRequestWeb:)]) {
            
            [self.delegate getCodeToRequestWeb:codeStr];
        }
    }
}


@end
