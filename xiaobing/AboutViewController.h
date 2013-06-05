//
//  AboutViewController.h
//  xiaobing
//
//  Created by zhangxi on 13-6-3.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMFeedback.h>
#include <AudioToolbox/AudioToolbox.h>

@interface AboutViewController : UIViewController

@property (readwrite)    CFURLRef        soundFileURLRef;
@property (readonly)    SystemSoundID    soundFileObject;


- (IBAction)feed:(UIButton *)sender;
- (IBAction)voice:(id)sender;

@end
