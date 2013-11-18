//
//  PlayerViewController.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "PlayerViewController.h"
#import "UIViewController+UI.h"
#import "UMSocial.h"
#import <UIImageView+AFNetworking.h>
#import "DOUAudioFileProvider.h"
#import "DataCenter.h"

@implementation PlayerViewController


static NSDateFormatter *formatter;

-(id)initWithPodcast:(XBPodcast *)thePodcast
{
    self = [super initWithNibName:@"PlayerViewController" bundle:nil];
    //self = [super initWithNibName:@"Player" bundle:nil];
    if (self) {
        podcast = thePodcast;
        
        
        player = [XBPlayer sharedPlayer];
        player.delegate = self;
        
        if([[player currentPodcastID] isEqualToString:podcast.podcastID])
        {
            if([player isPlaying] == NO)
                [player play];
        }
        else
        {
            [player play:podcast];
        }
        
        
        formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"mm:ss"];
    }
    return self;
}
-(void)position:(float)position
{
    NSLog(@"%f",position);
}
-(void)time:(NSTimeInterval)time1 in:(NSTimeInterval)time2
{
    self.durationTimeLabel.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time1]];
    self.totalTimeLabel.text = [formatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:time2]];
    
    self.progressView.progress = time1/time2;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    DOUAudioFileProvider *p = [DOUAudioFileProvider fileProviderWithAudioFile:podcast];
    
    
    NSLog(@"%@",podcast.audioFileURL);
    
    NSLog(@"%@",(p.isFinished==YES)?@"yes":@"no");
    NSLog(@"%@",p.cachedURL);
    NSLog(@"%@",p.cachedPath);
}
-(void)changeStatus:(DOUAudioStreamerStatus)status
{
    switch (status) {
        case DOUAudioStreamerPlaying:
            NSLog(@"DOUAudioStreamerPlaying");
            //[_labelInfo setText:@"playing"];
            //[_buttonPlayPause setTitle:@"Pause" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerPaused:
            NSLog(@"p");
            //[_labelInfo setText:@"paused"];
            //[_buttonPlayPause setTitle:@"Play" forState:UIControlStateNormal];
            break;
            
        case DOUAudioStreamerFinished:
            //[self.playButton setSelected:YES];
            [player stop];
            NSLog(@"f");
            //[_labelInfo setText:@"finished"];
            //[self actionNext:nil];
            break;
            
        case DOUAudioStreamerBuffering:
            NSLog(@"bu");
            //[_labelInfo setText:@"buffering"];
            break;
            
        case DOUAudioStreamerError:
            NSLog(@"E");
            //[_labelInfo setText:@"error"];
            break;
        default:
            break;
    }

}
- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)play:(id)sender {
    
    
    if([player status] == DOUAudioStreamerPlaying)
    {
        [player pause];
    }else
    {
        [player play];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //[self addBackButton];
    //[self loadContent];
    self.contentTextView.text = podcast.content;
    [self.coverImageView setImageWithURL:podcast.coverURL placeholderImage:[UIImage imageNamed:@"cover_holder"]];
//    [self.coverImageView setImage:[UIImage imageNamed:@"cover_holder"]];
    
    //self.view.backgroundColor = kColor_ListBG;
    self.navigationItem.title = podcast.title;
    
    [self.playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateSelected];
    [self.playButton setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    
//    
//    
//    UIButton *shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [shareButton setImage:[UIImage imageNamed:@"iconShare"] forState:UIControlStateNormal];
//    
//    shareButton.frame = CGRectMake(0, 0, 35, 35);
//    [shareButton addTarget:self
//                    action:@selector(share)
//          forControlEvents:UIControlEventTouchUpInside];
//    
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:shareButton];
    //self.navigationItem.rightBarButtonItem = item;
    
    


    //left.title = @" ";

    //self.navigationItem.leftBarButtonItem = left;
    
    //+++++++++++++++
    
    self.progressView.trackImage    = [UIImage imageNamed:@"track"];
    self.progressView.progressImage = [UIImage imageNamed:@"navBg"];
    
    
    
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"zx_play"
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                      
                                                      [self.playButton setSelected:NO];
                                                      
                                                  }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:@"zx_pause"
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *note) {
                                                       [self.playButton setSelected:YES];
                                                      
                                                  }];
    
    
    
    //+++++++++++++++
}

-(void)share
{
    [UMSocialSnsService presentSnsIconSheetView:[[[UIApplication sharedApplication] keyWindow] rootViewController]
                                         appKey:@"51abf69b56240b183404f364"
                                      shareText:@"@小饼FM"
                                     shareImage:[UIImage imageNamed:@"icon.png"]
                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,
     UMShareToDouban,UMShareToQzone,UMShareToEmail,UMShareToSms,UMShareToWechatTimeline,UMShareToFacebook,UMShareToTwitter]
                                       delegate:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadContent
{
    
//
//    NSMutableURLRequest *request = [[[DataCenter sharedDateCenter] client] requestWithMethod:@"GET"
//                                                             path:@"content.php"
//                                                       parameters:@{@"id":podcast.podcastID}];
//    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
//    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//        
//        
//        _contentTextView.text = [operation responseString];
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//    [op start];
}

- (void)viewDidUnload {
    [self setPlayButton:nil];
    [self setCoverImageView:nil];
    [self setProgressView:nil];
    [self setDurationTimeLabel:nil];
    [self setTotalTimeLabel:nil];
    [self setContentTextView:nil];
    [super viewDidUnload];
}
@end




