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


@property(nonatomic,strong) NSArray *podcasts;


+(DataCenter *)sharedDateCenter;









-(void)getPodcastWithBlock:(void(^)(NSArray *result))finish withParams:(NSDictionary *)params;




//-(void)save;
-(void)update;




@end
