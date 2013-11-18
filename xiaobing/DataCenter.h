//
//  DataCenter.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-1.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#define kBaseURL   [NSURL URLWithString:@"http://xiaobingfm.sinaapp.com/api"]
#define kStoreKey  @"me.zhangxi.xiaobing-podcast"
#define kVersonKey @"me.zhangxi.xiaobing-version"




#import <Foundation/Foundation.h>

@interface DataCenter : NSObject


@property(nonatomic,strong)NSMutableArray *podcasts;



+(DataCenter *)sharedDateCenter;

-(void)getPodcastWithBlock:(void(^)(NSArray *result))finish withParams:(NSDictionary *)params;



//-(NSMutableArray *)localPodcast;
//-(NSMutableArray *)podcast;
-(void)save;
-(void)update;


//+(void)setURL:(NSString *)url toPodcast:(NSString *)podcastID;

-(NSString*)content:(NSString *)podcastID;
@end
