//
//  GYSettingViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYSettingViewController.h"
#import "GYSetCell.h"
#import "GYSet2Cell.h"
@interface GYSettingViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tv;

@end

@implementation GYSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self registerCell];
    
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)registerCell{
    [self.tv registerNib:[UINib nibWithNibName:@"GYSetCell" bundle:nil] forCellReuseIdentifier:@"cell"];
    [self.tv registerNib:[UINib nibWithNibName:@"GYSet2Cell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    //self.tv.separatorStyle= UITableViewCellSeparatorStyleSingleLine;
    self.tv.tableFooterView=[[UIView alloc]init];
    UIImageView *im=[[UIImageView alloc]initWithFrame:self.tv.bounds];
    im.image=[UIImage imageNamed:@"背景图"];
    self.tv.backgroundView=im;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 4;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NSArray *tiArr=@[@"去评分",@"推荐给好友",@"给点建议吧",@"关于我们"];
        NSArray *imArr=@[@"star",@"我的-打分",@"我的-反馈",@"我的-关于"];
        GYSetCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
        cell.imV.image=[UIImage imageNamed:imArr[indexPath.row]];
        cell.lb.text=tiArr[indexPath.row];
        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        return cell;
    }
    else{
        GYSet2Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        return cell;
    }
   
}










@end
