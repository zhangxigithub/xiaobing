//
//  AboutViewController.m
//  xiaobing
//
//  Created by zhangxi on 13-6-3.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "AboutViewController.h"
//#import "UIViewController+UI.h"
//#import <AudioToolbox/AudioToolbox.h>
//#import "FeedBack.h"
//#import "List.h"
//#import "PageNumberView.h"
//#import <MBProgressHUD.h>
//#import <QuartzCore/QuartzCore.h>

@implementation AboutViewController

//
//- (id)init
//{
//    self = [super initWithNibName:@"AboutViewController" bundle:nil];
//    if (self) {
//        
//    }
//    return self;
//}
//
//
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    [self addBackButton];
//    //self.view.backgroundColor = kColor_MessageBg;
//    
//    self.navigationItem.title = @"关于小饼FM";
//    
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"voice" ofType:@"mp3"];
//    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
//    player = [[AVAudioPlayer alloc] initWithData:data error:nil];
//
//    
//    
//    logoView.layer.cornerRadius = 5;
//    logoView.clipsToBounds = YES;
//}
//-(void)viewDidUnload
//{
//    logoView = nil;
//    [super viewDidUnload];
//}
//- (void)didReceiveMemoryWarning
//{
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//- (IBAction)feed:(UIButton *)sender {
//    
//    [UMFeedback showFeedback:self withAppkey:@"51abf69b56240b183404f364"];
//}
//-(void)showVioceView:(BOOL)show
//{
//    if(show)
//    {
//        player.delegate = self;
//        
//        hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        hud.mode = MBProgressHUDModeAnnularDeterminate;
//        hud.labelText = @"播放中";
//        
//
//        
////        voiceView = [[UIView alloc] initWithFrame:self.view.bounds];
////        voiceView.backgroundColor = RGBAlpha(0, 0, 0, 0.5);
////        
////        page = [[PageNumberView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
////        page.center = CGPointMake(voiceView.frame.size.width/2, voiceView.frame.size.height/2-50);
////        page.value = 0;
////        [voiceView addSubview:page];
////        
////        [self.view addSubview:voiceView];
////        
////        
//        musicTimer = [NSTimer scheduledTimerWithTimeInterval:1
//                                                      target:self
//                                                    selector:@selector(updateMusic)
//                                                    userInfo:nil
//                                                     repeats:YES];
////
//    }else
//    {
//        [hud hide:YES];
//        [musicTimer invalidate];
////        [UIView animateWithDuration:0.6
////                         animations:^{
////                             voiceView.alpha = 0;
////                         } completion:^(BOOL finished) {
////                             [voiceView removeFromSuperview];
////                         }];
//    }
//}
//
//-(void)updateMusic
//{
//    hud.progress = (float)player.currentTime/(float)player.duration;
//    
//}
//-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
//{
//    [self showVioceView:NO];
//}
//- (IBAction)voice:(id)sender {
//    
//    [self showVioceView:YES];
//    [player play];
//    
//    
//    //AudioServicesPlaySystemSound (_soundFileObject);
//}
//
//- (IBAction)talk:(id)sender {
//    FeedBack *feed = [[FeedBack alloc] init];
//    [self.navigationController pushViewController:feed animated:YES];
//}
//
//- (IBAction)list:(id)sender {
//    
//    ALERT(@"再放一个列表会不会重复？想加一个关注微博的，再看吧.");
//    
//    List *list = [[List alloc] init];
//    [self.navigationController pushViewController:list animated:YES];
//}
//
//- (IBAction)rate:(id)sender {
//    ALERT(@"提示评价");
//}
@end
