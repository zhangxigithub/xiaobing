//
//  AudioPlayer.m
//  Share
//
//  Created by Lin Zhang on 11-4-26.
//  Copyright 2011年 www.eoemobile.com. All rights reserved.
//

#import "XBPlayer.h"


static void *kStatusKVOKey = &kStatusKVOKey;
static void *kDurationKVOKey = &kDurationKVOKey;

@implementation XBPlayer

static XBPlayer *player;

+(XBPlayer *)sharedPlayer
{
    if(player == nil)
    {
        player = [[XBPlayer alloc] init];
    }
    return player;
}

- (id)init
{
    self = [super init];
    if (self) {
        
        self.timer =  [NSTimer scheduledTimerWithTimeInterval:0.2
                                                       target:self
                                                     selector:@selector(timerAction:)
                                                     userInfo:nil
                                                      repeats:YES];
        
    }
    return self;
}
//- (void)resetStreamer
//{
//    if (streamer != nil) {
//        [streamer pause];
//        [streamer removeObserver:self forKeyPath:@"status"];
//        [streamer removeObserver:self forKeyPath:@"duration"];
//        streamer = nil;
//    }
//    
//
//    
//    //streamer = [DOUAudioStreamer streamerWithAudioFile:track];
//    
//    [streamer addObserver:self
//               forKeyPath:@"status"
//                  options:NSKeyValueObservingOptionNew
//                  context:kStatusKVOKey];
//    
//    [streamer addObserver:self
//               forKeyPath:@"duration"
//                  options:NSKeyValueObservingOptionNew
//                  context:kDurationKVOKey];
//    
//    //[streamer play];
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (context == kStatusKVOKey) {
        [self performSelector:@selector(updateStatus)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else if (context == kDurationKVOKey) {
        [self performSelector:@selector(timerAction:)
                     onThread:[NSThread mainThread]
                   withObject:nil
                waitUntilDone:NO];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}
- (void)timerAction:(id)timer
{
    
    [self.delegate time:[streamer currentTime]  in:[streamer duration]];
    return;
    if ([streamer duration] == 0.0) {
        //[_progressView setProgress:0.0f animated:NO];
        [self.delegate position:0];
    }
    else {
         [self.delegate position:[streamer currentTime] / [streamer duration]];
        //[_progressView setProgress:[_streamer currentTime] / [_streamer duration] animated:YES];
    }
}
-(DOUAudioStreamerStatus)status
{
    return [streamer status];
}
- (void)updateStatus
{
    [self.delegate changeStatus:[streamer status]];
    switch ([streamer status]) {
        case DOUAudioStreamerPlaying:
            //[_labelInfo setText:@"playing"];
            //[_buttonPlayPause setTitle:@"Pause" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerPaused:
            //[_labelInfo setText:@"paused"];
            //[_buttonPlayPause setTitle:@"Play" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerFinished:
            //[_labelInfo setText:@"finished"];
            //[self actionNext:nil];
            break;
            
        case DOUAudioStreamerBuffering:
            //[_labelInfo setText:@"buffering"];
            break;
            
        case DOUAudioStreamerError:
            //[_labelInfo setText:@"error"];
            break;
    }
}


-(void)play:(XBPodcast *)podcast
{
    if (streamer != nil) {
        [streamer pause];
        [streamer removeObserver:self forKeyPath:@"status"];
        [streamer removeObserver:self forKeyPath:@"duration"];
        streamer = nil;
    }
    self.currentPodcastID = podcast.podcastID;
    streamer = [DOUAudioStreamer streamerWithAudioFile:podcast];
    
    [streamer addObserver:self
               forKeyPath:@"status"
                  options:NSKeyValueObservingOptionNew
                  context:kStatusKVOKey];
    
    [streamer addObserver:self
               forKeyPath:@"duration"
                  options:NSKeyValueObservingOptionNew
                  context:kDurationKVOKey];
    
    [streamer play];
}

-(void)pause
{
    [streamer pause];
}
-(void)stop
{
    [streamer stop];
}
-(void)play
{
    [streamer play];
}

-(BOOL)isPlaying
{
    return [streamer status] == DOUAudioStreamerPlaying;
}




@end
