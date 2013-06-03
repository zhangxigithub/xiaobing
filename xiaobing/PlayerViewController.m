//
//  PlayerViewController.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "PlayerViewController.h"
#import "UIViewController+UI.h"


@implementation PlayerViewController



-(id)initWithPodcast:(XBPodcast *)thePodcast
{
    self = [super initWithNibName:@"PlayerViewController" bundle:nil];
    if (self) {
        podcast = thePodcast;
        
        
        player = [XBPlayer sharedPlayer];
        [player play:podcast];
    }
    return self;
}

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)play:(id)sender {
    
    
    if([player status] == DOUAudioStreamerPlaying)
    {
        [self.playButton setSelected:YES];
        [player pause];
    }else
    {
        [self.playButton setSelected:NO];
        [player play];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    
    self.view.backgroundColor = kColor_ListBG;
    self.navigationItem.title = podcast.title;
    [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (void)viewDidUnload {
    [self setPlayButton:nil];
    [super viewDidUnload];
}
@end




