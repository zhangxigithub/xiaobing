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


@interface XBPlayer : NSObject
{
    DOUAudioStreamer *streamer;
}

-(DOUAudioStreamerStatus)status;


+(XBPlayer *)sharedPlayer;

-(void)play:(XBPodcast *)podcast;
-(void)pause;
-(void)stop;
-(void)play;
@end
