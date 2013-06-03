//
//  ListVIewController.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "ListVIewController.h"
#import "XBPodcast.h"
#import "XBPodcastCell.h"
#import "DataCenter.h"
#import <UIImageView+AFNetworking.h>
#import "PlayerViewController.h"

@implementation ListVIewController

- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColor_ListBG;
    [self.navigationController setNavigationBarHidden:YES animated:NO];

//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"brnlthr_nav.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    //[[UINavigationBar appearance]setTintColor:kColor_NavBg];

    //self.navigationController.navigationBar.backgroundColor = kColor_NavBg;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(28, 0, 3, kContent_Height)];
    line.backgroundColor = kColor_ListLine;
    [self.view addSubview:line];
    //+++++++++++++++++++++++++++++++++++
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, kContent_Width, kContent_Height-50)
                                         style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = [UIColor clearColor];
    table.dataSource = self;
    table.delegate = self;
    table.contentInset = UIEdgeInsetsMake(100, 0, 0, 0);
    [self.view addSubview:table];
    
    //+++++++++++++++++++++++++++++++++++
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kContent_Width, 150)];
    headerView.backgroundColor = kColor_ListHeader;
    [self.view addSubview:headerView];
    
  
    
    localData = [[[DataCenter sharedDateCenter] localPodcast] mutableCopy];

    if(localData == nil)
    {
    localData = [NSMutableArray array];
    
    [[DataCenter sharedDateCenter] getPodcastWithBlock:^(NSArray *result) {
        
        [localData addObjectsFromArray:result];
        [table reloadData];
    }];
    }
    [self scrollViewDidScroll:table];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView == table)
    {
        NSLog(@"%f",table.contentOffset.y);
        if(scrollView.contentOffset.y <= -50)
        {
            headerView.frame = CGRectMake(0, 0,kContent_Width, -scrollView.contentOffset.y);
        }
        
        else if(scrollView.contentOffset.y >= 0)
        {
            headerView.frame = CGRectMake(0, 0, kContent_Width, 50);
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return localData.count;
}
- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    XBPodcast *podcast = localData[indexPath.row];
    switch (podcast.type) {
        case Podcast:return 150;
        case Text:   return 100;
        case Image:  return 100;
        default:
            break;
    }
    return 100;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    XBPodcast *podcast = localData[indexPath.row];
    
    NSString *identifier;
    switch (podcast.type) {
            
        case Podcast:identifier = @"XB0";  break;
        case Text:   identifier = @"XB1";  break;
        case Image:  identifier = @"XB2";  break;
    }
    
    XBPodcastCell *cell = (XBPodcastCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[XBPodcastCell alloc] initWithType:podcast.type];
        cell.delegate = self;
    }
    
    cell.podcast = podcast;
    return cell;
}

-(void)play:(XBPodcast *)podcast
{
    PlayerViewController *player = [[PlayerViewController alloc] initWithPodcast:podcast];
    [self.navigationController pushViewController:player animated:YES];
}
-(void)showImage:(XBPodcast *)podcast
{
    NSLog(@"%@",podcast.imageURL);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
