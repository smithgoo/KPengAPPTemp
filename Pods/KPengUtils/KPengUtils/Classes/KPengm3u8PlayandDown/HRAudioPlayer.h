//
//  HRAudioPlayer.h
//  HRAudioPlayer
//
//  Created by Kpeng on 2017/7/28.
//  Copyright © 2017年 Kpeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HRAudioPlayerDelegate <NSObject>

-(void)getPlayerTime:(NSTimeInterval )time andTotal:(NSTimeInterval)totalTime;

-(void)getAudioPlayerFinished:(BOOL)success;

-(void)getPlayerError:(NSError *)error;

@end

@interface HRAudioPlayer : NSObject

@property(nonatomic,weak)id<HRAudioPlayerDelegate> delegate;

+(HRAudioPlayer *)sharePLayer;

+(void )destruction;

-(void)playWithUrl:(NSURL *)url;

-(void)pause;

-(void)resume;

-(void)stop;


-(BOOL)isPlaying;

- (void)setCurrentTimeForPlayer:(NSTimeInterval)currentTime;

@end

