//
//  AudioPlayer.h
//  Share
//
//  Created by Lin Zhang on 11-4-26.
//  Copyright 2011年 www.eoemobile.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DOUAudioStreamer.h>
#import "XBPodcast.h"



@protocol XBPlayerDelegate

-(void)changeStatus:(DOUAudioStreamerStatus )status;
-(void)position:(float)position;
-(void)time:(NSTimeInterval)time1 in:(NSTimeInterval)time2;
@end

@interface XBPlayer : NSObject
{
    DOUAudioStreamer *streamer;
}

-(DOUAudioStreamerStatus)status;
@property(nonatomic,weak) id<XBPlayerDelegate>delegate;
@property(nonatomic,strong) NSTimer *timer;
+(XBPlayer *)sharedPlayer;

-(void)play:(XBPodcast *)podcast;
-(void)pause;
-(void)stop;
-(void)play;
@end
