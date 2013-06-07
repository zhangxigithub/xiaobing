//
//  List.m
//  xiaobing
//
//  Created by zhangxi on 13-6-7.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "List.h"
#import "UIViewController+UI.h"

@implementation List



- (id)init
{
    self = [super initWithNibName:@"List" bundle:nil];
    if (self) {
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addBackButton];
    self.navigationItem.title = @"Podcast列表";
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
