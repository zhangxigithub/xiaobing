//
//  ListVIewController.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPodcastCell.h"
#import <FPPopoverController.h>

@interface ListVIewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,XBPodcastCellDelegate,FPPopoverControllerDelegate>
{
    UITableView   *table;
    UIView        *headerView;
    UIImageView   *avatarView;
    
    
    NSMutableArray *localData;
    
    
    UIButton *fliterButton;
}
@end
