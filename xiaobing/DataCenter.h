//
//  DataCenter.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-1.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#define kBaseURL [NSURL URLWithString:@"http://xiaobingfm.sinaapp.com/api"]

#import <Foundation/Foundation.h>
#import <AFHTTPClient.h>
#import <JSONKit.h>
#import <AFJSONRequestOperation.h>

@interface DataCenter : NSObject


@property(nonatomic,strong) AFHTTPClient *client;


+(DataCenter *)sharedDateCenter;

-(void)getPodcastWithBlock:(void(^)(NSArray *result))finish withParams:(NSDictionary *)params;



-(NSArray *)localPodcast;
@end
