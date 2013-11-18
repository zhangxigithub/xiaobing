//
//  ListVIewController.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPodcastCell.h"

@interface ListVIewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate,XBPodcastCellDelegate>
{
    UITableView   *table;
    UIView        *headerView;
    UIImageView   *avatarView;
    
    
    NSMutableArray *localData;
    
    
    UIButton *fliterButton;
    
    UIView *tableFooterView;

    __block BOOL finish;
    __block BOOL loading;
}
@end
