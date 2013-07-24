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
-(NSMutableArray *)podcast
{

    NSMutableArray *podcasts = [self localPodcast];
    
    NSMutableArray *result = [NSMutableArray array];
    for(NSDictionary *podcast in podcasts)
    {
        XBPodcast *onePodcast = [[XBPodcast alloc] initWithDictionary:podcast];
        [result addObject:onePodcast];
    }
    return result;
}

+(void)setURL:(NSString *)url toPodcast:(NSString *)podcastID
{
    NSMutableArray *podcasts = [[[NSUserDefaults standardUserDefaults] objectForKey:kStoreKey] mutableCopy];
    NSMutableArray *newPod = [NSMutableArray array];
    if(podcasts == nil) return;
    
    for(NSDictionary *thePodcast in podcasts)
    {
        if([podcastID isEqualToString:thePodcast[@"id"]])
        {
            NSMutableDictionary *newPodcast = [thePodcast mutableCopy];
            [newPodcast setObject:url forKey:@"podcastURL"];

            
            [newPod addObject:newPodcast];
        }else
        {
            [newPod addObject:thePodcast];
        }
    }
    
    [[NSUserDefaults standardUserDefaults]setObject:newPod
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
}
@end
