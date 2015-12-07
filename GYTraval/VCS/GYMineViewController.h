//
//  GYMineViewController.h
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYMineViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *regisAction;

- (IBAction)regiAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *username;


@property (weak, nonatomic) IBOutlet UITextField *password;
- (IBAction)loginButton:(id)sender;

@end
