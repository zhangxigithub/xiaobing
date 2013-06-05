//
//  AppDelegate.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-1.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "AppDelegate.h"
#import "GuideViewController.h"
#import "DataCenter.h"
#import "ListVIewController.h"
#import <MobClick.h>
#import <AVFoundation/AVFoundation.h>
#import <UMSocial.h>
#import "XBPlayer.h"
#import <UMFeedback.h>
#import <MTStatusBarOverlay.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"%@",NSHomeDirectory());
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    [MobClick startWithAppkey:@"51abf69b56240b183404f364"];
    
    [WXApi registerApp:@"wx7a0f9be121c270af"];
    [UMSocialControllerService defaultControllerService].socialData.extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [UMSocialControllerService defaultControllerService].socialData.extConfig.appUrl = @"http://zhangxi.me";
    
    
    [UMSocialData setAppKey:@"51abf69b56240b183404f364"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //self.window.rootViewController = [[GuideViewController alloc] init];
    
    for(int i=0;i<=9;i++)
        for(int j=0;j<=9;j++)
            for(int k=0;k<=9;k++)
            {
                if(i*11+j*11+k*11 == i*100+j*100+k)
                {
                    NSLog(@"%d%d+%d%d+%d%d = %d%d%d",i,i,j,j,k,k,i,j,k);
                }
            }
    
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ListVIewController alloc] init]];
    


     [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
    
    [NSTimer scheduledTimerWithTimeInterval:30
                                     target:self
                                   selector:@selector(checkFeedBack)
                                   userInfo:nil
                                    repeats:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(umCheck:)
                                                 name:UMFBCheckFinishedNotification
                                               object:nil];
    
    return YES;
}
-(void)checkFeedBack
{
    [UMFeedback checkWithAppkey:@"51abf69b56240b183404f364"];
}



- (void)umCheck:(NSNotification *)notification {
    

    NSLog(@"notification = %@", notification.userInfo);
    
    if (notification.userInfo) {
        
        NSArray * newReplies = [notification.userInfo objectForKey:@"newReplies"];
        NSLog(@"newReplies = %@", newReplies);
        NSString *title = [NSString stringWithFormat:@"小饼给你回复了,去看看吧"];
        
        
        MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];

        //[overlay postMessage:title animated:YES];
        
        [overlay postImmediateFinishMessage:title duration:2 animated:YES];
        
        
        
//        
//        
//        NSMutableString *content = [NSMutableString string];
//        for (int i = 0; i < [newReplies count]; i++) {
//            NSString * dateTime = [[newReplies objectAtIndex:i] objectForKey:@"datetime"];
//            NSString *_content = [[newReplies objectAtIndex:i] objectForKey:@"content"];
//            [content appendString:[NSString stringWithFormat:@"%d .......%@.......\r\n", i+1,dateTime]];
//            [content appendString:_content];
//            [content appendString:@"\r\n\r\n"];
//        }
//        

    }
}
-(BOOL)canBecomeFirstResponder
{
    return YES;
}
-(void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    if(event.type != UIEventTypeRemoteControl) return;
    
    switch (event.subtype) {
        case UIEventSubtypeRemoteControlTogglePlayPause:
        {
            XBPlayer *thePLayer = [XBPlayer sharedPlayer];
            if ([thePLayer status] == DOUAudioStreamerPlaying) {
                [thePLayer pause];
            }else
            {
                [thePLayer play];
            }
        
        }
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [UMSocialSnsService  applicationDidBecomeActive];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
