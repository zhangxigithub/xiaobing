//
//  AppDelegate.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-1.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPlayer.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    XBPlayer *player;
}
@property (strong, nonatomic) UIWindow *window;

@end
