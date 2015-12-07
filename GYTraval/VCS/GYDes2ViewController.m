//
//  GYDes2ViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/18.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYDes2ViewController.h"
#import "GYDataManager.h"
#import "GYDataModel.h"
@interface GYDes2ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIButton *collect;

@end

@implementation GYDes2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)collectAction:(id)sender {
    //GYDataModel *model=[GYDataModel shared];
    
    //if (model.login==YES) {
        self.collect.selected=!self.collect.selected;
        GYDataManager *manager=[GYDataManager sharedDataBase];
        if (self.collect.selected==YES) {
            GYDataModel *model=[[GYDataModel alloc]initDic:self.dic];
            [manager addData:model];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"COLLECTADD" object:nil];
            
            
        }
        else{
            [manager deleteData:[self.dic[@"id"] integerValue]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"COLLECTDELETE" object:nil];
        }
        
        
//    }
//    else{
//        UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"请登录" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
//        [alert show];
//    }

}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float width= (SCREENWIDTH-40-30)/6.f;
    if (scrollView.contentOffset.y>=width+190) {
        self.titleLb.text=self.dic[@"title"];
    }
    
}
- (void)viewWillAppear:(BOOL)animated{
    NSInteger ID=[self.dic[@"id"] integerValue];
    if ([[GYDataManager sharedDataBase] isexist:ID]) {
        self.collect.selected=YES;
    }
}

@end
