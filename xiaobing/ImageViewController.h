//
//  ImageViewController.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XBPodcast.h"
#import "PageNumberView.h"

@interface ImageViewController : UIViewController<UIScrollViewDelegate>
{
    
    UIScrollView *canvas;
    
    
    UIActivityIndicatorView *activityIndicatorView;
    
    
    PageNumberView *rateView;
    __block  UIImageView *imageView;
    
    
    
    UIButton *shareButton;
}


@property(nonatomic,strong) XBPodcast *podcast;


//-(id)initWithPodcast:(XBPodcast *)thePodcast;

@end
