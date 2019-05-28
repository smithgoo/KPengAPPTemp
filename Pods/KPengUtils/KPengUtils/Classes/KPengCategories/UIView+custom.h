//
//  UIView+custom.h
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (custom)

+ (id)initWithOwner:(id)owner;
+ (id)initWithOwner:(id)owner index:(NSUInteger)index;
+ (id)initWithOwner:(id)owner nibName:(NSString *)nibName index:(NSUInteger)index;

- (void)removeAllSubViews;
- (void)removeAllSubViews:(int)tag;
- (void)removeAllSubViews:(int)minTag maxTag:(int)maxTag;

- (void)mergeCommandExecuting:(NSArray *)commands;

@end
