//
//  UITextField+deleteBackward.h
//  CatchDoll
//
//  Created by 王朋 on 2018/3/30.
//  Copyright © 2018年 Jack_Tao. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol WPTextFieldDelegate <UITextFieldDelegate>
@optional
- (void)textFieldDidDeleteBackward:(UITextField *)textField;
@end
@interface UITextField (deleteBackward)
@property (weak, nonatomic) id<WPTextFieldDelegate> delegate;
@end
/**
 *  监听删除按钮
 *  object:UITextField
 */
extern NSString * const WPTextFieldDidDeleteBackwardNotification;

