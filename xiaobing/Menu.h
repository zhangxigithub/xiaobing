//
//  Menu.h
//  xiaobing
//
//  Created by zhangxi on 13-7-22.
//  Copyright (c) 2013年 me.zhangxi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UMSocial.h>

@interface Menu : UIViewController<UIActionSheetDelegate,UMSocialUIDelegate>

- (IBAction)listen:(id)sender;
- (IBAction)rate:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *listenButton;
@property (weak, nonatomic) IBOutlet UIButton *rateButton;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;

@end
