//
//  PlayerViewController.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "PlayerViewController.h"



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

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end




