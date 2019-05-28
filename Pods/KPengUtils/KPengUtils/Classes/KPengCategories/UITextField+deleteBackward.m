//
//  UITextField+deleteBackward.m
//  CatchDoll
//
//  Created by 王朋 on 2018/3/30.
//  Copyright © 2018年 Jack_Tao. All rights reserved.
//

#import "UITextField+deleteBackward.h"
#import <objc/runtime.h>
NSString * const WPTextFieldDidDeleteBackwardNotification = @"com.smithgoo.textfield.did.notification";
@implementation UITextField (deleteBackward)
+ (void)load {
    //交换2个方法中的IMP
    Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"deleteBackward"));
    Method method2 = class_getInstanceMethod([self class], @selector(wp_deleteBackward));
    method_exchangeImplementations(method1, method2);
}

- (void)wp_deleteBackward {
    [self wp_deleteBackward];
    
    if ([self.delegate respondsToSelector:@selector(textFieldDidDeleteBackward:)])
    {
        id <WPTextFieldDelegate> delegate  = (id<WPTextFieldDelegate>)self.delegate;
        [delegate textFieldDidDeleteBackward:self];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:WPTextFieldDidDeleteBackwardNotification object:self];
}
@end
