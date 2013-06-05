//
//  XBPodcastCell.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPodcast.h"

@protocol XBPodcastCellDelegate

-(void)play:(XBPodcast *)podcast;
-(void)showImage:(XBPodcast *)podcast;

@end


@interface XBPodcastCell : UITableViewCell
{
    UIImage *bgImage;
    UIImageView *icon;
    XBType type;
    
    
    
    
    UILabel     *titleLabel;
    UITextView  *content;
    UIImageView *imageView;
    
    
    UILabel     *dateLabel;

}



@property(nonatomic,strong) XBPodcast *podcast;
@property(nonatomic,weak) id<XBPodcastCellDelegate> delegate;



- (id)initWithType:(XBType )theType;
@end
