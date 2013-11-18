//
//  PodcastList.m
//  xiaobing
//
//  Created by zhangxi on 13-7-22.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "PodcastList.h"
#import <ZXMacro.h>
#import "XBPodcast.h"
#import "XBPlayer.h"
#import "PlayerViewController.h"
#import "DataCenter.h"

@implementation PodcastList

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return localData.count;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 52;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *idetifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:idetifier];
    
    if(cell == nil)
    {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:idetifier];
    }
    XBPodcast *podcast = (XBPodcast *)localData[indexPath.row];
    
    //[[XBPlayer sharedPlayer] isPlaying] && 
    if([[[XBPlayer sharedPlayer] currentPodcastID] isEqual:podcast.podcastID])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    cell.textLabel.text = podcast.title;
    
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
    XBPodcast *podcast = (XBPodcast *)localData[indexPath.row];
    
    PlayerViewController *player = [[PlayerViewController alloc] initWithPodcast:podcast];

    
    NSString *title;
    if(iOS>=7)
    {
        title = @" ";
    }else
    {
        title = @"返回";
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:nil
                                                                action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    
    [self.navigationController pushViewController:player animated:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    localData = [[DataCenter sharedDateCenter] podcasts];
    
    self.navigationItem.title = @"Podcasts";
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.table reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
