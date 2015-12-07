//
//  GYRegisterViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYRegisterViewController.h"
#import "AFNetworking.h"
#import "NSString+Hashing.h"
@interface GYRegisterViewController ()


@end

@implementation GYRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
}



- (IBAction)backAction:(id)sender {
   
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.username resignFirstResponder];
    [self.password resignFirstResponder];
    [self.repassword resignFirstResponder];

}
- (IBAction)reAction:(id)sender {

    // 1. 验证是否有空
    if (self.username.text.length == 0 ||
        self.password.text.length == 0 ||
        self.repassword.text.length == 0) {
        
        [self showAlert:@"关键内容不能为空"];
        return;
    }
    
    // 2. 验证用户名是否存在
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    path = [path stringByAppendingString:@"/user.plist"];
    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    if (!dic) {
        dic = [[NSMutableDictionary alloc] init];
    }
    if (dic[self.username.text]) {
        // 说明用户名存在
        [self showAlert:@"用户名已存在"];
        return;
    }
    
    // 3. 判断是否两个输入框的内容一致
    if (![self.password.text isEqualToString:self.repassword.text]) {
        // 说明不一致
        [self showAlert:@"两次输入的密码不一致"];
        
        return;
    }
    
    // 4. 注册完成
    [dic setValue:self.password.text forKey:self.username.text];
    [dic writeToFile:path atomically:NO];
    [self showAlert:@"注册成功"];
    if (self.block) {
        NSArray *array=@[self.username.text, self.password.text];
        self.block(array);
    }
}

- (void)showAlert:(NSString *)message{
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:message delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
    [alert show];
}














@end
