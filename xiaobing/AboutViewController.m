//
//  AboutViewController.m
//  xiaobing
//
//  Created by zhangxi on 13-6-3.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "AboutViewController.h"
#import "UIViewController+UI.h"
#include <AudioToolbox/AudioToolbox.h>

@implementation AboutViewController


- (id)init
{
    self = [super initWithNibName:@"AboutViewController" bundle:nil];
    if (self) {
        
    }
    return self;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    self.navigationItem.title = @"关于小饼FM";
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"voice" ofType:@"mp3"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    player = [[AVAudioPlayer alloc] initWithData:data error:nil];

}
-(void)viewDidUnload
{
    [super viewDidUnload];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)feed:(UIButton *)sender {
    
    [UMFeedback showFeedback:self withAppkey:@"51abf69b56240b183404f364"];
}

- (IBAction)voice:(id)sender {
    

    [player play];
    
    
    //AudioServicesPlaySystemSound (_soundFileObject);
}
@end
