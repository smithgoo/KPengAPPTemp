//
//  NSTimer+custom.m
//  yxzj
//
//  Created by tokee on 15/9/22.
//  Copyright (c) 2015年 tokee. All rights reserved.
//

#import "NSTimer+custom.h"

@implementation NSTimer (custom)

- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(void))block
{
    return [self initWithFireDate:date interval:seconds target:self.class selector:@selector(runBlock:) userInfo:block repeats:repeats];
}

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(void))block
{
    return [self scheduledTimerWithTimeInterval:seconds target:self selector:@selector(runBlock:) userInfo:block repeats:repeats];
}

+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)seconds repeats:(BOOL)repeats block:(void (^)(void))block
{
    return [self timerWithTimeInterval:seconds target:self selector:@selector(runBlock:) userInfo:block repeats:repeats];
}

#pragma mark - Private methods

+ (void)runBlock:(NSTimer *)timer
{
    if ([timer.userInfo isKindOfClass:NSClassFromString(@"NSBlock")])
    {
        void (^block)(void) = timer.userInfo;
        block();
    }
}

@end
