//
//  FeedBack.m
//  xiaobing
//
//  Created by 张 玺 on 13-6-5.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import "FeedBack.h"
#import "UIViewController+UI.h"
#import <MBProgressHUD.h>
#import <MTStatusBarOverlay.h>
@implementation FeedBack


- (void)getFinishedWithError: (NSError *)error
{

    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    if(error != nil)
    {
        ALERT(@"加载失败 (￣^￣)ゞ");
        return;
    }else
    {
        /*
         {
         "app_version" = "1.0";
         appkey = 51abf69b56240b183404f364;
         carrier = "";
         contact =         {
         };
         content = ccc1;
         "created_at" = 1370443643091;
         datetime = "2013-06-05 22:47:23";
         "device_model" = "x86_64";
         "feedback_id" = "FB[51abf69b56240b183404f364_3f39ba7e75136508d4297b9664dbb3ebe439fd1b]";
         isreplied = 0;
         isviewed = 1;
         language = en;
         lastreplydate = "2013-06-05 22:47:23";
         mc = "10:9A:DD:59:BE:3B";
         "os_version" = "6.1";
         remark =         {
         };
         resolution = "960 x 640";
         "sdk_type" = iphone;
         "sdk_version" = "1.4";
         thread = ccc1;
         timestamp = 1370443643091;
         type = "new_feedback";
         "updated_at" = 1370443643091;
         "user_id" = 3f39ba7e75136508d4297b9664dbb3ebe439fd1b;
         }
         */
        /*
         if ([reply objectForKey:@"type"] isEqualToString:@"dev_reply"]){
         NSLog(@"开发者回复");
         }else{
         NSLog(@"用户回复");
         }
         */
    NSLog(@"%@",umFeedback.topicAndReplies);
        [localData removeAllObjects];
        [self addText];
        for(NSDictionary *dic in umFeedback.topicAndReplies)
        {
            
            NSBubbleType type;
            
            if ([[dic objectForKey:@"type"] isEqualToString:@"dev_reply"]){
                type = BubbleTypeSomeoneElse;
            }else{
                type = BubbleTypeMine;
            }
            
            NSDate *date = [formatter dateFromString:dic[@"datetime"]];
            
            NSBubbleData *data = [NSBubbleData dataWithText:dic[@"content"]
                                                       date:date
                                                       type:type];
            NSLog(@"data");
            [localData addObject:data];
        }
        [table reloadData];
    }
}
-(void)addText
{
    
    NSBubbleData *data = [NSBubbleData dataWithText:@"Hi~like it?"
                                               date:[NSDate dateWithTimeIntervalSince1970:1370446267]
                                               type:BubbleTypeSomeoneElse];
    [localData addObject:data];

    
}
- (void)postFinishedWithError:(NSError *)error
{
    [[MTStatusBarOverlay sharedInstance] hide];
    
    NSLog(@"%@",error);
    if(error)
    {
        ALERT(@"发送失败 (￣^￣)ゞ");
    }else
    {
        [localData addObject:lastPost];
        
        [table reloadData];


        table.contentOffset = CGPointMake(0, table.contentSize.height-table.frame.size.height);
        input.text = @"";
        
    }
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = kColor_MessageBg;
    
    self.navigationItem.title = @"反馈";
    [self addBackButton];
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    localData = [NSMutableArray array];
    umFeedback = [UMFeedback sharedInstance];
    [umFeedback setAppkey:@"51abf69b56240b183404f364" delegate:self];
    
    CGRect tableFrame = self.view.bounds;
    tableFrame.size.height -= 40+44;
    
    table = [[UIBubbleTableView alloc] initWithFrame:tableFrame];
    table.delegate = self;
    table.typingBubble = NSBubbleTypingTypeNobody;
    table.bubbleDataSource = self;
    [self.view addSubview:table];
    
    
    bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"inputBg"]];
    bg.frame = CGRectMake(0, kContent_Height-44-40, kContent_Width, 40);
    [self.view addSubview:bg];
    
    input = [[UITextField alloc] initWithFrame:CGRectMake(10, kContent_Height-44-40, kContent_Width-20, 40)];
    input.contentVerticalAlignment = UIControlContentHorizontalAlignmentCenter;
    [input setBorderStyle:UITextBorderStyleNone];
    input.delegate = self;
    [self.view addSubview:input];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(change:)
                                                 name:UIKeyboardWillChangeFrameNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(umCheck:)
                                                 name:UMFBCheckFinishedNotification
                                               object:nil];
    
    
    [umFeedback get];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

- (void)umCheck:(NSNotification *)notification {
    
    
    NSLog(@"notification = %@", notification.userInfo);
    
    if (notification.userInfo) {
        
        NSArray * newReplies = [notification.userInfo objectForKey:@"newReplies"];
        NSLog(@"newReplies = %@", newReplies);
        
        NSBubbleData *data = [NSBubbleData dataWithText:newReplies[0][@"content"]
                                                   date:[NSDate date]
                                                   type:BubbleTypeSomeoneElse];
        [localData addObject:data];
        [table reloadData];
        table.contentOffset = CGPointMake(0, table.contentSize.height-table.frame.size.height);
    }
}


-(void)change:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [aValue CGRectValue];
    LOGFRAME(frame);
    
    [UIView animateWithDuration:0.3
                     animations:^{
                      
                         
                         CGRect inputFrame = bg.frame;
                         inputFrame.origin.y = frame.origin.y-20-44-40;
                         bg.frame = inputFrame;
                         
                         inputFrame.origin.x = 22;
                         inputFrame.origin.y +=2;
                         inputFrame.size.width = kContent_Width-44;
                         input.frame = inputFrame;
                         
                         CGRect tableFrame = table.frame;
                         tableFrame.size.height = frame.origin.y-20-44-40;
                         table.frame = tableFrame;
                         
                     }];
    
    
    
    
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    [input resignFirstResponder];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    [dictionary setObject:input.text forKey:@"content"];
    
    //[dictionary setObject:@"2" forKey:@"age_group"];
    //[dictionary setObject:@"female" forKey:@"gender"];
    //[dictionary setObject:@[@"Good",@"VIP"] forKey:@"tags"];
    //NSDictionary *contact = [NSDictionary dictionaryWithObject:_emailField.text forKey:@"email"];
    //[dictionary setObject:contact forKey:@"contact"];
    //NSDictionary *remark = [NSDictionary dictionaryWithObject:_nameField.text forKey:@"name"];
    //[dictionary setObject:remark forKey:@"remark"];
    [umFeedback post:dictionary];
    [input resignFirstResponder];
    
    
    [[MTStatusBarOverlay sharedInstance] postMessage:@"发送中..."];
 lastPost =   [NSBubbleData dataWithText:input.text
                          date:[NSDate date]
                          type:BubbleTypeMine];
    
    return YES;
}
-(void)viewDidUnload
{
    [super viewDidUnload];
    umFeedback.delegate = nil;

}

- (NSInteger)rowsForBubbleTable:(UIBubbleTableView *)tableView
{
    return localData.count;
}
- (NSBubbleData *)bubbleTableView:(UIBubbleTableView *)tableView dataForRow:(NSInteger)row
{
    return localData[row];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
