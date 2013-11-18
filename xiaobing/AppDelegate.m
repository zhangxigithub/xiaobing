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
    
    [MobClick startWithAppkey:@"51abf69b56240b183404f364"];
    
    [UMSocialData setAppKey:@"51abf69b56240b183404f364"];
    
    [WXApi registerApp:@"wx7a0f9be121c270af"];
    
    [UMSocialControllerService defaultControllerService].socialData.extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    [UMSocialControllerService defaultControllerService].socialData.extConfig.appUrl = @"http://zhangxi.me";
    

    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    
    
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[Menu alloc] initWithNibName:@"Menu" bundle:nil]];
    

    self.window.rootViewController = navigationController;

    
    
    
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    
    [MobClick updateOnlineConfig];
    [[DataCenter sharedDateCenter] update];
    
    
    
    return YES;
}

-(BOOL)canBecomeFirstResponder
{
    return YES;
}


-(void)remoteControlReceivedWithEvent:(UIEvent *)event
{
    
    if(event.type != UIEventTypeRemoteControl) return;
    
    switch (event.subtype) {
            
        case UIEventSubtypeRemoteControlPlay:
        {
            XBPlayer *thePLayer = [XBPlayer sharedPlayer];
//            if ([thePLayer status] == DOUAudioStreamerPlaying) {
//                [thePLayer pause];
//            }else
//            {
                [thePLayer play];
//            }
        
        }
        case UIEventSubtypeRemoteControlPause:
        {
            XBPlayer *thePLayer = [XBPlayer sharedPlayer];
//            if ([thePLayer status] == DOUAudioStreamerPlaying) {
                [thePLayer pause];
//            }else
//            {
//                [thePLayer play];
//            }
            
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
}

@end
