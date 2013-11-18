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
#import "UMSocial.h"
#import "XBPlayer.h"

#import "ZXRemoteNotification.h"
#import <ZXMacro.h>
#import "Menu.h"
#import <AVFoundation/AVFoundation.h>

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    NSLog(@"kContent_Height:%f",kContent_Height);
    NSLog(@"kScreen_Height:%f",kScreen_Height);
    NSLog(@"%@",NSHomeDirectory());
    
//    NSLog(@"%@",[UITableViewCell superclass]);
//    NSString *al = [[UITableViewCell superclass] description];
//    ALERT(al);

    [MobClick startWithAppkey:@"51abf69b56240b183404f364"];
    [UMSocialData setAppKey:@"51abf69b56240b183404f364"];
    

    
    [WXApi registerApp:@"wx7a0f9be121c270af"];
    [UMSocialControllerService defaultControllerService].socialData.extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [UMSocialControllerService defaultControllerService].socialData.extConfig.appUrl = @"http://zhangxi.me";
    

    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    
    /*
    newPlayer = [[AVPlayer alloc] initWithURL:[NSURL URLWithString:@"http://xiaobingfm-podcast.stor.sinaapp.com/%E5%B0%8F%E9%A5%BC%E7%94%B5%E5%8F%B0%20vol6%E4%BA%94%E9%81%93%E5%8F%A3%E6%98%AF%E4%B8%96%E7%95%8C%E4%B8%AD%E5%BF%83.mp3"]];
    [newPlayer play];
    
    

    
    AVPlayerItem *item = [newPlayer currentItem];
    */
    
    

    
    //[UIApplication registerRemote];
    
    /*
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ListVIewController alloc] init]];
    
*/
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[Menu alloc] initWithNibName:@"Menu" bundle:nil]];
    
    //navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.window.rootViewController = navigationController;

     [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    
    [MobClick updateOnlineConfig];
    [[DataCenter sharedDateCenter] update];
    
    
//    [NSTimer scheduledTimerWithTimeInterval:30
//                                     target:self
//                                   selector:@selector(checkFeedBack)
//                                   userInfo:nil
//                                    repeats:YES];
    
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(umCheck:)
//                                                 name:UMFBCheckFinishedNotification
//                                               object:nil];
    
    return YES;
}
//-(void)checkFeedBack
//{
//    [UMFeedback checkWithAppkey:@"51abf69b56240b183404f364"];
//}



//- (void)umCheck:(NSNotification *)notification {
//    
//
//    
//    NSLog(@"notification = %@", notification.userInfo);
//    
//    if (notification.userInfo) {
//        
//        NSArray * newReplies = [notification.userInfo objectForKey:@"newReplies"];
//        NSLog(@"newReplies = %@", newReplies);
//        NSString *title = [NSString stringWithFormat:@"小饼给你回复了,去看看吧"];
//        
//        
//        MTStatusBarOverlay *overlay = [MTStatusBarOverlay sharedInstance];
//
//        //[overlay postMessage:title animated:YES];
//        
//        [overlay postImmediateFinishMessage:title duration:2 animated:YES];
//        
//        
//        
////        
////        
////        NSMutableString *content = [NSMutableString string];
////        for (int i = 0; i < [newReplies count]; i++) {
////            NSString * dateTime = [[newReplies objectAtIndex:i] objectForKey:@"datetime"];
////            NSString *_content = [[newReplies objectAtIndex:i] objectForKey:@"content"];
////            [content appendString:[NSString stringWithFormat:@"%d .......%@.......\r\n", i+1,dateTime]];
////            [content appendString:_content];
////            [content appendString:@"\r\n\r\n"];
////        }
////        
//
//    }
//}
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
    default:
            break;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    //[[DataCenter sharedDateCenter] save];
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
    //[[DataCenter sharedDateCenter] save];
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
