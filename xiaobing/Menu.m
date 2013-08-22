//
//  Menu.m
//  xiaobing
//
//  Created by zhangxi on 13-7-22.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "Menu.h"
#import "PodcastList.h"
#import "UMSocial.h"
#import <ZXMacro.h>
#import "XBPlayer.h"


@implementation Menu

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void)checkAndFollow
{
    BOOL isOauth = [UMSocialAccountManager isOauthWithPlatform:UMShareToSina];
    
    
    if(isOauth)
    {
        [self follow];
    }else
    {
        UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
        snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
            
            NSLog(@"2.response is %@",response);
            [self follow];
            
        });
    }
}
-(void)follow
{
    [[UMSocialDataService defaultDataService] requestAddFollow:UMShareToSina
                                                  followedUsid:@[@"1366326195"] completion:^(UMSocialResponseEntity *response) {
                                                      NSLog(@"1.%@",response);
                                                      if([response.message isEqualToString:@"no error"])
                                                      {
                                                          ALERT(@"关注成功 ^_^");
                                                      }else
                                                      {
                                                          ALERT(@"BUG了 >_<");
                                                      }
                                                      
                                                      
                                                      
                                                  }];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"小饼FM";
    
    
    //    if(iOS<7)
    //    {
    //        self.listenButton.backgroundColor =  [UIColor clearColor];
    //    }
    
    
    
    
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(10, kContent_Height/2, 300, 1)];
    line.backgroundColor = RGB(240, 240, 240);
    [self.view addSubview:line];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if([[XBPlayer sharedPlayer] currentPodcastTitle]!= Nil)
    {
        self.currentLabel.text = [[XBPlayer sharedPlayer] currentPodcastTitle];
    }else
        self.currentLabel.text = @"";
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)listen:(id)sender {
    
    PodcastList *list = [[PodcastList alloc] initWithNibName:@"PodcastList" bundle:nil];
    
    
    
    
    NSString *title;
    if(iOS>=7)
    {
        title = @" ";
    }else
    {
        title = @"返回";
    }
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:title
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:nil
                                                                action:nil];
    [self.navigationItem setBackBarButtonItem:backItem];
    
    
    [self.navigationController pushViewController:list animated:YES];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    switch (buttonIndex) {
        case 0:
            [self checkAndFollow];
            break;
        case 1:
            [self share];
            break;
        case 2:
            
            break;
        default:
            break;
    }
}
-(void)share
{
    //[UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
    //[UMSocialData defaultData].extConfig.appUrl = @"http://zhangxi.me";//设置你应用的下载地址
    
    //2.用微信web类型，用户点击直接打开web
    /*    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeOther;
     WXWebpageObject *webObject = [WXWebpageObject object];
     webObject.webpageUrl = @"https://www.umeng.com"; //设置你自己的url地址
     [UMSocialData defaultData].extConfig.wxMediaObject = webObject;
     */
    
    
    
    NSString *shareText = @"@小饼FM ";
    UIImage *shareImage = [UIImage imageNamed:@"Icon"];          //分享内嵌图片

    //NSString *shareText = [UMSocialData defaultData].shareText;           //分享内嵌文字
    //UIImage *shareImage = [UMSocialData defaultData].shareImage;          //分享内嵌图片
    
    //如果得到分享完成回调，可以设置delegate
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"51abf69b56240b183404f364"
                                      shareText:shareText
                                     shareImage:shareImage
                                shareToSnsNames:nil
                                       delegate:nil];
    
    //
    //    [UMSocialSnsService presentSnsIconSheetView:[[[UIApplication sharedApplication] keyWindow] rootViewController]
    //                                         appKey:@"51abf69b56240b183404f364"
    //                                      shareText:@"@小饼FM"
    //                                     shareImage:[UIImage imageNamed:@"icon.png"]
    //                                shareToSnsNames:@[UMShareToSina,UMShareToTencent,UMShareToRenren,
    //                                                  UMShareToDouban,UMShareToQzone,UMShareToEmail,UMShareToSms,UMShareToWechat,UMShareToFacebook,UMShareToTwitter]
    //                                       delegate:nil];
    
}
- (IBAction)rate:(id)sender {
    
    UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@""
                                                        delegate:self
                                               cancelButtonTitle:@"取消 >_<"
                                          destructiveButtonTitle:Nil
                                               otherButtonTitles:@"关注 小饼FM",@"分享",nil];
    [action showInView:self.view];
}
@end
