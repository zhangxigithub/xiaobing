//
//  XBPodcastCell.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "XBPodcastCell.h"
#import <UIImageView+AFNetworking.h>
#import "ImageViewController.h"
#import <GGFullScreenImageViewController.h>

@implementation XBPodcastCell

- (id)initWithType:(XBType )theType
{
    type = theType;
    
    NSString *identifier;
    switch (type) {
            
        case Podcast:identifier = @"XB0"; break;
        case Text:   identifier = @"XB1";  break;
        case Image:  identifier = @"XB2"; break;
    }
    
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        bgImage = ResizableImage(@"cellBg", 27, 13, 5, 5);
        
        icon = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 30, 30)];
        icon.image =[UIImage imageNamed:[NSString stringWithFormat:@"icon_%d",type]];
        [self addSubview:icon];
        
        
        
        switch (type) {   
            case Podcast:
            {
                titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(68, 12, 200, 20)];
                [self addSubview:titleLabel];
                
                content = [[UITextView alloc] initWithFrame:CGRectMake(60, 30, 190, 70)];
                
                UIButton *playButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [playButton setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
                playButton.frame = CGRectMake(250, 38, 40, 40);
                [playButton addTarget:self
                               action:@selector(play)
                     forControlEvents:UIControlEventTouchUpInside];
                [self addSubview:playButton];
                
                
            }break;
            case Text:
            {
                content = [[UITextView alloc] initWithFrame:CGRectMake(60, 8, 236, self.bounds.size.height-16)];
                content.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            }break;
            case Image:
            {
                content = [[UITextView alloc] initWithFrame:CGRectMake(60, 8, 190, 64 )];
                

                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(240, 10, 60, 60)];
                imageView.userInteractionEnabled = YES;
                [imageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showImage)]];
                [self addSubview:imageView];
            } break;
        }
        
        
        [self addSubview:content];
        content.scrollEnabled = NO;
        content.editable = NO;
        content.font         = kContent_Font;
        content.textColor    = kContent_Color;

        
        titleLabel.font      = kTitle_Font;
        titleLabel.textColor = kTitle_Color;
        

        
        
    }
    return self;
}
-(void)play
{
    [self.delegate play:self.podcast];
}


static GGFullscreenImageViewController *vc;
-(void)showImage
{
//    ImageViewController *image = [[ImageViewController alloc] initWithPodcast:self.podcast];
   UIViewController *controller = [[[UIApplication sharedApplication] keyWindow] rootViewController];
//    [controller presentModalViewController:image animated:YES];
//    
//    
    
    
    
    if(vc == nil)
    {
        vc = [[GGFullscreenImageViewController alloc] init];
    }
        vc.liftedImageView = imageView;
    [controller presentViewController:vc animated:YES completion:^{
        
    }];
    
    
    
    
    
    [self.delegate showImage:self.podcast];
}
-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    
    CGRect frame = CGRectMake(50, 7, 250, rect.size.height-10);
    [bgImage drawInRect:frame];
}

-(void)setPodcast:(XBPodcast *)thePodcast
{
    _podcast = thePodcast;

    switch (_podcast.type) {
            
        case Podcast:
            titleLabel.text = _podcast.title;
            content.text    = _podcast.content;
            break;
            
            
        case Text:
            content.text    = _podcast.content;
            break;
            
            
        case Image:
            content.text    = _podcast.content;
            [imageView setImageWithURL:_podcast.imageURL];
            break;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(NSString *)reuseIdentifier
{
    NSString *identifier;
    switch (type) {
            
        case Podcast:identifier = @"XB0"; break;
        case Text:   identifier = @"XB1";  break;
        case Image:  identifier = @"XB2"; break;
    }
    return identifier;
}
@end
