//
//  XBPodcast.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <DOUAudioStreamer.h>
typedef enum
{
    Podcast =0,
    Text    =1,
    Image   =2
}XBType;


@interface XBPodcast : NSObject<NSCoding,DOUAudioFile>

@property(nonatomic,assign) XBType    type;

@property(nonatomic,strong) NSString *podcastID;
@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSString *content;
@property(nonatomic,strong) NSURL    *coverURL;
@property(nonatomic,copy) NSDate   *date;
@property(nonatomic,strong) NSURL    *imageURL;
@property(nonatomic,strong) NSURL    *largeImageURL;
@property(nonatomic,strong) NSURL    *podcastURL;

@property(nonatomic,assign) float     rowHeight;



-(id)initWithDictionary:(NSDictionary *)dictionary;
-(NSURL *)audioFileURL;

-(float)height;

-(NSData *)data;
+(XBPodcast *)initWithData:(NSData *)data;

+(NSMutableArray *)podcastsFromArray:(NSArray *)array;


@end
