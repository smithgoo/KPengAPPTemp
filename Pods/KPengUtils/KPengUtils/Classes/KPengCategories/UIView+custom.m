//
//  UIView+custom.m
//  ugo
//
//  Created by tokee on 15/8/18.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import "UIView+custom.h"

@implementation UIView (custom)

+ (id)initWithOwner:(id)owner
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:owner options:nil] objectAtIndex:0];
}

+ (id)initWithOwner:(id)owner index:(NSUInteger)index
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:owner options:nil] objectAtIndex:index];
}

+ (id)initWithOwner:(id)owner nibName:(NSString *)nibName index:(NSUInteger)index
{
    return [[[NSBundle mainBundle] loadNibNamed:nibName owner:owner options:nil] objectAtIndex:index];
}

- (void)removeAllSubViews:(int)tag
{
    for (long i = (self.subviews.count - 1); i >= 0; i--) {
        UIView *view = [self.subviews objectAtIndex:i];
        if (view.tag == tag) {
            [view removeFromSuperview];
        }
    }
}

- (void)removeAllSubViews:(int)minTag maxTag:(int)maxTag
{
    for (long i = (self.subviews.count - 1); i >= 0; i--) {
        UIView *view = [self.subviews objectAtIndex:i];
        if (view.tag >= minTag && view.tag <= maxTag) {
            [view removeFromSuperview];
        }
    }
}

- (void)removeAllSubViews
{
    for (long i = (self.subviews.count - 1); i >= 0; i--) {
        UIView *view = [self.subviews objectAtIndex:i];
        [view removeFromSuperview];
    }
}

 

@end
