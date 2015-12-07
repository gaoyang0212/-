//
//  GYChoiViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYChoiViewController.h"
#import "GYChCell.h"
#import "GYAnitimation.h"
#import "GYAllChoiViewController.h"
#import "GYHeader.h"
@interface GYChoiViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (nonatomic, strong) NSArray *arr;
@end

@implementation GYChoiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBK];
    [self registerCell];
    
}


//注册cell
- (void)registerCell{
    [self.tv registerNib:[UINib nibWithNibName:@"GYChCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
//背景图
- (void)setBK{
    UIImageView *im=[[UIImageView alloc]initWithFrame:self.tv.bounds];
    im.image=[UIImage imageNamed:@"背景图"];
    self.tv.backgroundView=im;
    
    UIImageView *imV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 15)];
    imV.image=[UIImage imageNamed:@"collect_the_end"];
    self.tv.tableFooterView=imV;

}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ----------------UITableView协议方法-----------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GYChCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSDictionary *d=self.dataSource[indexPath.row];
    [cell cellWithDic:d];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    GYAllChoiViewController *all=[[GYAllChoiViewController alloc]init];
    all.hidesBottomBarWhenPushed=YES;
     NSDictionary *d=self.dataSource[indexPath.row];
    NSInteger ID=[d[@"id"] integerValue];
    NSString *st=[NSString stringWithFormat:@"%ld?v",ID];
    all.string=st;
    all.strName=d[@"title"];
    all.des=d[@"short_desc"];
    [self.navigationController pushViewController:all animated:YES];
}


@end
