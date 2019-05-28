//
//  UIAlertView+Block.h
//  MainProject
//
//  Created by 王朋 on 2017/7/19.
//  Copyright © 2017年 王朋. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIAlertView (Block)
- (void)handlerClickedButton:(void (^)(NSInteger btnIndex))aBlock;

@end
