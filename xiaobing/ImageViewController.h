//
//  ImageViewController.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPodcast.h"

@interface ImageViewController : UIViewController
{
    XBPodcast *podcast;
    
}
-(id)initWithPodcast:(XBPodcast *)thePodcast;
@end
