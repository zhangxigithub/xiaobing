//
//  ImageViewController.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "ImageViewController.h"
#import <UIImageView+AFNetworking.h>


@implementation ImageViewController

-(id)initWithPodcast:(XBPodcast *)thePodcast
{
    self = [super init];
    if (self) {
        podcast = thePodcast;
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];

    
    canvas = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    canvas.userInteractionEnabled = NO;
    [self.view addSubview:canvas];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:canvas.bounds];
    [imageView setImageWithURL:podcast.imageURL];
    [canvas addSubview:imageView];
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self dismissModalViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
