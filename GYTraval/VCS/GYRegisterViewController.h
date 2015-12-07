//
//  GYRegisterViewController.h
//  GYTraval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYRegisterViewController : UIViewController

- (IBAction)backAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UITextField *repassword;

@property (weak, nonatomic) IBOutlet UIButton *regisButt;
@property(nonatomic,copy)void(^block) (NSArray *array);

- (IBAction)reAction:(id)sender;
@end
