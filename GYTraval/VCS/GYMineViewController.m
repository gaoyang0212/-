//
//  GYMineViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYMineViewController.h"
#import "GYRegisterViewController.h"
#import "AFNetworking.h"
#import "NSString+Hashing.h"
#import "GYSettingViewController.h"
#import "GYCollectViewController.h"
#import "GYDataManager.h"
#import "GYDataModel.h"
#import "UMSocial.h"
#import "UMSocialControllerService.h"
#import "User.h"
@interface GYMineViewController ()

@end

@implementation GYMineViewController
- (IBAction)xinlang:(id)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            
            [self push:self.username.text];
        }
    });
}
- (IBAction)wechat:(id)sender {
    UMSocialSnsPlatform *snsPlatform = [UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToWechatSession];
    
    snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
        
        if (response.responseCode == UMSResponseCodeSuccess) {
            
            
            [self push:self.username.text];
        }
    });

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    self.password.secureTextEntry=YES;
            
}

- (IBAction)SetAction:(id)sender {
    GYSettingViewController *set=[[GYSettingViewController alloc]init];
    set.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:set animated:YES];
}

- (IBAction)regiAction:(id)sender {
    GYRegisterViewController *reg=[[GYRegisterViewController alloc]init];
    reg.hidesBottomBarWhenPushed=YES;
    reg.block=^(NSArray *array){
        self.username.text=array[0];
        self.password.text=array[1];
    };
    [self.navigationController pushViewController:reg animated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
}
- (IBAction)loginButton:(id)sender {
    
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingString:@"/user.plist"];
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];

    
    if (self.username.text.length==0||self.password.text.length==0) {
        [self showAlert:@"关键内容不能为空"];
        return;
    }
    if ([dic[self.username.text] isEqualToString:self.password.text]) {
        
//        GYDataModel *model=[GYDataModel shared];
//        model.login=YES;
       [self push:self.username.text];
        User *user=[[User alloc]init];
        user.userName=self.username.text;
        user.password=self.password.text;
        [[User currentUser] encodeUser:user];
    }
    else{
        [self showAlert:@"登录失败"];
    }
     

 
}
- (void)showAlert:(NSString *)message{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alert show];
}

- (void)push:(NSString *)text{
     GYCollectViewController *collect=[[GYCollectViewController alloc]init];
    //collect.hidesBottomBarWhenPushed=YES;
    collect.text=text;
    [self.navigationController pushViewController:collect animated:YES];
}


@end
