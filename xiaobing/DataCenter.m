//
//  DataCenter.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-1.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "DataCenter.h"
#import "XBPodcast.h"
#import <JSONKit.h>

@implementation DataCenter

static DataCenter *dataCenter;

+(DataCenter *)sharedDateCenter
{    
    @synchronized(self)
    {
        if(dataCenter == nil)
        {
            dataCenter = [[DataCenter alloc] init];
        }
    }
    return dataCenter;
}
- (id)init
{
    self = [super init];
    if (self) {
        self.client = [AFHTTPClient clientWithBaseURL:kBaseURL];
        
        
        
        
        NSMutableArray *podcasts = [self localPodcast];
        
        self.podcasts = [NSMutableArray array];
        
        for(NSDictionary *podcast in podcasts)
        {
            XBPodcast *onePodcast = [[XBPodcast alloc] initWithDictionary:podcast];
            [self.podcasts addObject:onePodcast];
        }
        
        
        
    }
    return self;
}

-(NSMutableArray *)localPodcast
{
    NSMutableArray *podcasts = [[[NSUserDefaults standardUserDefaults] objectForKey:kStoreKey] mutableCopy];
    
    if(podcasts == nil)
    {
        
        NSString *json = FileString(@"list", @"json");
        
        NSArray *newPodcast = [json objectFromJSONString];
        
        [[NSUserDefaults standardUserDefaults]setObject:newPodcast
                                                 forKey:kStoreKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        podcasts = [newPodcast mutableCopy];
    }
    
    return podcasts;
}
//-(NSMutableArray *)podcast
//{
//
//    NSMutableArray *podcasts = [self localPodcast];
//    
//    NSMutableArray *result = [NSMutableArray array];
//    for(NSDictionary *podcast in podcasts)
//    {
//        XBPodcast *onePodcast = [[XBPodcast alloc] initWithDictionary:podcast];
//        [result addObject:onePodcast];
//    }
//    return result;
//}

//+(void)setURL:(NSString *)url toPodcast:(NSString *)podcastID
//{
//    //NSMutableArray *podcasts = [[[NSUserDefaults standardUserDefaults] objectForKey:kStoreKey] mutableCopy];
//    //NSMutableArray *newPod = [NSMutableArray array];
//    //if(podcasts == nil) return;
//    
//    for(NSDictionary *thePodcast in self)
//    {
//        if([podcastID isEqualToString:thePodcast[@"id"]])
//        {
//            NSMutableDictionary *newPodcast = [thePodcast mutableCopy];
//            [newPodcast setObject:url forKey:@"podcastURL"];
//
//            
//            [newPod addObject:newPodcast];
//        }else
//        {
//            [newPod addObject:thePodcast];
//        }
//    }
//    
//    [[NSUserDefaults standardUserDefaults]setObject:newPod
//                                             forKey:kStoreKey];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//}



-(void)save
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    /*
     {
     "id": "9",
     "type": "0",
     "title": "vol7 女神对话",
     "cover": "http://xiaobingfm.sinaapp.com/image/bird.jpg",
     "content": "时间花在哪里是看得见的。——颜宁",
     "imageURL": "",
     "largeImageURL": "",
     "podcastURL": "http://xiaobingfm.sinaapp.com/podcast/demo.mp3",
     "date": "2013-06-07 00:00:00"
     }
     */
    NSMutableArray *dataArray = [NSMutableArray array];
    for(XBPodcast *podcast in self.podcasts)
    {
        NSDictionary *onePodcast  = @{@"id":podcast.podcastID,
                                      @"type":@"0",
                                      @"title":podcast.title,
                                      @"cover":podcast.coverURL.absoluteString,
                                      @"content":podcast.content,
                                      @"imageURL":podcast.imageURL.absoluteString,
                                      @"largeImageURL":podcast.largeImageURL.absoluteString,
                                      @"podcastURL":podcast.podcastURL.absoluteString,
                                      @"date":[formatter stringFromDate:podcast.date]
                                      };
        [dataArray addObject:onePodcast];
    }
    [[NSUserDefaults standardUserDefaults]setObject:dataArray
                                             forKey:kStoreKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
-(void)getPodcastWithBlock:(void(^)(NSArray *result))finish withParams:(NSDictionary *)params
{
    
    //finish([XBPodcast podcastsFromArray:[FileString(@"list", @"") objectFromJSONString]]);
    //return;
    
    NSMutableURLRequest *request = [self.client requestWithMethod:@"GET"
                                                             path:@"podcast.php"
                                                       parameters:params];
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
         
         NSLog(@"%@",JSON);
         
         
         NSMutableArray *result = [XBPodcast podcastsFromArray:JSON];
         
         NSData *data = [NSKeyedArchiver archivedDataWithRootObject:result];
         
         BOOL save = [data writeToFile:[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/podcasts"] atomically:YES];
         
         LOGBOOL(save);
         
         finish(result);
         
         
     } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
         
     }];
    
    [op start];
    
    
    
    //finish(@[@"aaaa"]);
}
-(NSString *)content:(NSString *)podcastID
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"GET"
                                                             path:@"content.php"
                                                       parameters:@{@"id":podcastID}];
    AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
    //http://xiaobingfm.sinaapp.com/api/content.php?id=33
    return @"";
}
@end
