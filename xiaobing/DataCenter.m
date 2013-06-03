//
//  DataCenter.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-1.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "DataCenter.h"
#import "XBPodcast.h"

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

-(NSArray *)localPodcast
{
    
    NSArray *result = [NSKeyedUnarchiver unarchiveObjectWithFile:[NSHomeDirectory() stringByAppendingPathComponent:@"/Documents/podcasts"]];
    
    return  result;
}
-(void)getPodcastWithBlock:(void(^)(NSArray *result))finish
{
    NSMutableURLRequest *request = [self.client requestWithMethod:@"GET"
                                                             path:@"podcast.php"
                                                       parameters:@{}];
    AFJSONRequestOperation *op = [AFJSONRequestOperation JSONRequestOperationWithRequest:request
     success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
         
         //NSLog(@"%@",JSON);
         
         
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

@end
