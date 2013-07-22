//
//  PodcastList.h
//  xiaobing
//
//  Created by zhangxi on 13-7-22.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PodcastList : UIViewController<UITableViewDataSource,UITableViewDelegate>

{
    NSMutableArray *localData;
}
@property (weak, nonatomic) IBOutlet UITableView *table;

@end
