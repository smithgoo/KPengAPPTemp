//
//  UITextField+custom.h
//  RequestLibApi
//
//  Created by 邓文华 on 2017/7/30.
//  Copyright © 2017年 赵郧陕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (custom)

/**
 是否包含表情
 
 @param string 文字
 @return 是否包含反馈
 */
- (BOOL)isContainsEmoji:(NSString *)string;

/**
 是否是数字

 @param number 文字
 @return 是否是反馈
 */
- (BOOL)validateNumber:(NSString*)number;

/**
 判断是不是九宫格
 @param string  输入的字符
 @return YES(是九宫格拼音键盘)
 */
- (BOOL)isNineKeyBoard:(NSString *)string;
@end
