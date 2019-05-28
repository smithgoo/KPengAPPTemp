//
//  UIAlertView+Block.m
//  MainProject
//
//  Created by 王朋 on 2017/7/19.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import "UIAlertView+Block.h"
#import <objc/runtime.h>

@implementation UIAlertView (Block)
- (void)handlerClickedButton:(void (^)(NSInteger btnIndex))aBlock{
    self.delegate = self;
    objc_setAssociatedObject(self, @"UIAlertView_key_clicked", aBlock, OBJC_ASSOCIATION_COPY);
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    void (^block)(NSInteger btnIndex) = objc_getAssociatedObject(self, @"UIAlertView_key_clicked");
    if (block) block(buttonIndex);
}

@end
