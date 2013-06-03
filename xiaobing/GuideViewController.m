//
//  GuideViewController.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-1.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()

@end

@implementation GuideViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColor_Blue;
    
    
    canvas = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    canvas.showsHorizontalScrollIndicator = NO;
    canvas.pagingEnabled = YES;
    canvas.contentSize = CGSizeMake(kContent_Width*5, kContent_Height);
    canvas.delegate = self;
    [self.view addSubview:canvas];
    
    
    
    tip = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kContent_Width/5, 6)];
    tip.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tip];
}





- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    tip.frame = CGRectMake(scrollView.contentOffset.x/5, 0, kContent_Width/5, 6);
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
