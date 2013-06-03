//
//  PlayerViewController.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPlayer.h"
#import "XBPodcast.h"

@interface PlayerViewController : UIViewController
{
    XBPlayer *player;
    XBPodcast *podcast;
}


-(id)initWithPodcast:(XBPodcast *)thePodcast;

- (IBAction)back:(id)sender;

@end
