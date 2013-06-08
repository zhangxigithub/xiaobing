//
//  UIViewController+UI.m
//  xiaobing
//
//  Created by zhangxi on 13-6-3.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "UIViewController+UI.h"

@implementation UIViewController (UI)

-(void)addBackButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 33, 27);
    [button addTarget:self
               action:@selector(back)
           forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}
-(void)addRefreshButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"refresh"] forState:UIControlStateNormal];
    button.frame = CGRectMake(0, 0, 33, 27);
    [button addTarget:self
               action:@selector(refresh)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItem = item;
}
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
