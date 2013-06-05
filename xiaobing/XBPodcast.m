//
//  XBPodcast.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-2.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "XBPodcast.h"

@implementation XBPodcast

-(NSURL *)audioFileURL
{
    return self.podcastURL;
}

- (id)init
{
    self = [super init];
    if (self) {
        self.rowHeight = -1;
    }
    return self;
}
-(float)height
{
    if(self.rowHeight <0)
    {
        CGSize size = [self.content sizeWithFont:kContent_Font
                               constrainedToSize:CGSizeMake(220, 9999)
                                   lineBreakMode:NSLineBreakByCharWrapping];
        
        self.rowHeight = size.height+42;
    }
    return self.rowHeight;
}

/*
 {
 "type": 2,
 "title": "\u6211\u662f\u4e00\u4e2a\u6807\u9898",
 "content": "\u6211\u662f\u5185\u5bb9\uff0c\u6211\u662f\u5185\u5bb9\uff0c\u6211\u662f\u5185\u5bb9\uff0c\u6211\u662f\u5185\u5bb9\uff0c\u6211\u662f\u5185\u5bb9\uff0c\u6211\u662f\u5185\u5bb9",
 "date": 1370147957,
 "imageURL": "http:\/\/xiaobingfm.sinaapp.com\/image\/demo.jpg",
 "podcastURL": "http:\/\/xiaobingfm.sinaapp.com\/podcast\/demo.mp3"
 }
 
 */


static NSDateFormatter *formatter;

-(id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [self init];
    if (self) {
        
        if(formatter == nil)
        {
            formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }
        
        self.podcastID = [NSString stringWithFormat:@"%d",[dictionary[@"id"] intValue]];
        self.type  = [dictionary[@"type"] intValue];
        self.title = dictionary[@"title"];
        self.content = dictionary[@"content"];
        self.coverURL   = [NSURL URLWithString:dictionary[@"cover"]];
        
        self.date = [formatter dateFromString:dictionary[@"date"]];
        //NSLog(@"...%@",self.date);
        //self.date = [NSDate date];
        self.imageURL = [NSURL URLWithString:dictionary[@"imageURL"]];
        self.podcastURL = [NSURL URLWithString:dictionary[@"podcastURL"]];
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@?%d",dictionary[@"largeImageURL"],arc4random()]];
        
        self.largeImageURL = url;
        if([dictionary[@"largeImageURL"] isEqualToString:@""])
            self.largeImageURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://xiaobingfm.sinaapp.com/image/jinyu.jpg?%d",arc4random()]];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.podcastID forKey:@"zx_podcastID"];
    [aCoder encodeObject:self.podcastURL forKey:@"zx_podcastURL"];
    [aCoder encodeObject:self.title forKey:@"zx_title"];
    [aCoder encodeObject:self.coverURL forKey:@"zx_cover"];
    [aCoder encodeObject:self.content forKey:@"zx_content"];
    [aCoder encodeInt:self.type forKey:@"zx_type"];
    [aCoder encodeObject:self.imageURL forKey:@"zx_imageURL"];
    [aCoder encodeObject:self.date forKey:@"zx_date"];
    [aCoder encodeFloat:self.rowHeight forKey:@"zx_rowHeight"];
    [aCoder encodeObject:self.largeImageURL forKey:@"zx_largeImageURL"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [self init];
    if(self)
    {
        self.podcastID = [aDecoder decodeObjectForKey:@"zx_podcastID"];
        self.podcastURL = [aDecoder decodeObjectForKey:@"zx_podcastURL"];
        self.title = [aDecoder decodeObjectForKey:@"zx_title"];
        self.coverURL = [aDecoder decodeObjectForKey:@"zx_cover"];
        self.content = [aDecoder decodeObjectForKey:@"zx_content"];
        self.type = [aDecoder decodeIntForKey:@"zx_type"];
        self.imageURL = [aDecoder decodeObjectForKey:@"zx_imageURL"];
        self.date = [aDecoder decodeObjectForKey:@"zx_date"];
        self.rowHeight = [aDecoder decodeFloatForKey:@"zx_rowHeight"];
        self.largeImageURL = [aDecoder decodeObjectForKey:@"zx_largeImageURL"];
    }
    return self;
}
-(NSData *)data
{
    return [NSKeyedArchiver archivedDataWithRootObject:self];
}
+(XBPodcast *)initWithData:(NSData *)data
{
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

+(NSMutableArray *)podcastsFromArray:(NSArray *)array
{
    NSMutableArray *result = [NSMutableArray array];
    for (NSDictionary *data in array) {
        [result addObject:[[XBPodcast alloc] initWithDictionary:data]];
    }
    return result;
}
-(NSString *)description
{
    NSLog(@"===============");
    NSLog(@"ID:%@",self.podcastID);
    NSLog(@"type:%d\n",self.type);
    NSLog(@"title:%@\n",self.title);
    NSLog(@"content:%@\n",self.content);
    NSLog(@"date:%@\n",self.date);
    NSLog(@"image:%@\n",self.imageURL);
    NSLog(@"podcast:%@\n",self.podcastURL);
    NSLog(@"cover:%@\n",self.coverURL);
    NSLog(@"largeImage:%@\n",self.largeImageURL);
    NSLog(@"===============");

    return [super description];
}

@end
