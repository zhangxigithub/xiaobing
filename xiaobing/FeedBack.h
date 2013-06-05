//
//  FeedBack.h
//  xiaobing
//
//  Created by 张 玺 on 13-6-5.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIBubbleTableView.h>
#import <UMFeedback.h>
#import <NSBubbleData.h>

@interface FeedBack : UIViewController<UMFeedbackDataDelegate,UIBubbleTableViewDataSource,UITextFieldDelegate,UIScrollViewDelegate>
{
    UMFeedback *umFeedback;
    UIBubbleTableView *table;
    NSMutableArray *localData;
    
    
    UITextField *input;
    NSDateFormatter *formatter;
    
    UIImageView *bg;
    
    
    NSBubbleData *lastPost;
}
@end
