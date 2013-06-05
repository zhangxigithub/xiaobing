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
#import "FliterTableViewController.h"
#import "AboutViewController.h"
#import <UMSocial.h>

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
    self.navigationItem.title = @"小饼FM";
    
    finish  = NO;
    loading = NO;
    

    //[self.navigationController setNavigationBarHidden:YES animated:NO];

//    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"brnlthr_nav.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    //[[UINavigationBar appearance]setTintColor:kColor_NavBg];

    //self.navigationController.navigationBar.backgroundColor = kColor_NavBg;
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(28, 0, 3, kContent_Height)];
    line.backgroundColor = kColor_ListLine;
    [self.view addSubview:line];
    //+++++++++++++++++++++++++++++++++++
    table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kContent_Width, kContent_Height-44)
                                         style:UITableViewStylePlain];
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    table.backgroundColor = [UIColor clearColor];
    table.dataSource = self;
    table.delegate = self;
    table.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    [self.view addSubview:table];
    
    //+++++++++++++++++++++++++++++++++++
    headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kContent_Width, 150)];
    headerView.backgroundColor = kColor_ListHeader;
    //[self.view addSubview:headerView];
    
    //+++++++++++++++++++++++++++++++++++
    fliterButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    fliterButton.frame = CGRectMake(0, 0, 35, 35);
    [fliterButton addTarget:self
                     action:@selector(fliter)
           forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:fliterButton];

    //+++++++++++++++++++++++++++++++++++
    
    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [shareButton setImage:[UIImage imageNamed:@"iconShare"] forState:UIControlStateNormal];
    
    shareButton.frame = CGRectMake(0, 0, 35, 35);
    [shareButton addTarget:self
                    action:@selector(share)
        forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    
    self.navigationItem.rightBarButtonItems = @[item,item2];;
    
    
    
    
    
    
    
    
    
    //+++++++++++++++++++++++++++++++++++
    tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(40, 0, 240, 40)];
    tableFooterView.backgroundColor = kColor_ListBG;
    UIActivityIndicatorView *action  =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    [action startAnimating];
    action.center = CGPointMake(120, 20);
    [tableFooterView addSubview:action];

    
    
    
    
    
    
    
    //+++++++++++++++++++++++++++++++++++
    //localData = [[[DataCenter sharedDateCenter] localPodcast] mutableCopy];

    //if(localData == nil)
    //{
    localData = [NSMutableArray array];
    
    [self loadPodcats];
    
    
    //}
    [self scrollViewDidScroll:table];
    
}




-(void)loadPodcats
{
    
    NSLog(@"泥马给力啊～～");
    loading = YES;
    [[DataCenter sharedDateCenter] getPodcastWithBlock:^(NSArray *result) {
        
    
        if(result.count > 0 && result != nil)
        {
            [localData addObjectsFromArray:result];
            [table reloadData];
            finish = NO;
        }else
        {
            finish = YES;
        }
        
        table.tableFooterView = nil;
        loading = NO;
        
    } withParams:
     @{
     @"offset":[NSString stringWithFormat:@"%d",localData.count],
     @"length":@"10"
     }];
}
-(void)fliter
{
    AboutViewController *about = [[AboutViewController alloc] init];
    [self.navigationController pushViewController:about animated:YES];
    
    
    
    
    
    
    
//    FliterTableViewController *fliter = [[FliterTableViewController alloc] init];
//    
//    FPPopoverController *popover = [[FPPopoverController alloc] initWithViewController:fliter];
//    popover.delegate  = self;
//    popover.border = NO;
//    [popover presentPopoverFromView:fliterButton];
}
-(void)share
{
    
//    UMSocialIconActionSheet *iconActionSheet = [[UMSocialControllerService defaultControllerService] getSocialIconActionSheetInController:self];
//    UIViewController *rootViewController = [[[UIApplication sharedApplication] delegate] window].rootViewController;
//    [iconActionSheet showInView:rootViewController.view];
//    
//    
//    
//    return;
    
    //`UMShareToSina`,`UMShareToTencent`,`UMShareToRenren`,`UMShareToDouban`,`UMShareToQzone`,`UMShareToEmail`,`UMShareToSms`,`UMShareToWechat`,`UMShareToFacebook`,`UMShareToTwitter`
    
    [UMSocialSnsService presentSnsIconSheetView:[[[UIApplication sharedApplication] keyWindow] rootViewController]
                                         appKey:@"51abf69b56240b183404f364"
                                      shareText:@"@小饼FM"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,
                                       UMShareToDouban,UMShareToQzone,UMShareToEmail,UMShareToSms,UMShareToWechat,UMShareToFacebook,UMShareToTwitter]
                                       delegate:nil];
}
- (void)popoverControllerDidDismissPopover:(FPPopoverController *)popoverController
{
    [popoverController dismissPopoverAnimated:YES];
}
- (void)presentedNewPopoverController:(FPPopoverController *)newPopoverController
          shouldDismissVisiblePopover:(FPPopoverController*)visiblePopoverController
{
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    return;
    if(scrollView == table)
    {
        //NSLog(@"%f",table.contentOffset.y);
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
        case Podcast: return 124;
        case Text:    return podcast.height;
        case Image:   return 90;
        default:
            break;
    }
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
    
    
    
    if(loading == NO && finish == NO &&  indexPath.row == localData.count-1)
    {
        [self loadPodcats];
        table.tableFooterView = tableFooterView;
    }
    
    
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
