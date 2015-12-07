//
//  GYDe2ViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYDe2ViewController.h"
#import "GYView.h"
#import "GYDetail3Cell.h"
#import "GYDe2Cell.h"
#import "GYDataManager.h"
#import "GYDataModel.h"
#import "GYMapViewController.h"
#import "UMSocial.h"
#import "UMSocialControllerService.h"
//#import "UMSocialScreenShoter.h"
@interface GYDe2ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    BOOL fold[4];
}
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UIButton *collect;

@end

@implementation GYDe2ViewController
- (IBAction)shareAction:(id)sender {
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"565bee0767e58eb178001a72" shareText:self.dic[@"title"]
                                     shareImage:nil
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToWechatSession,UMShareToDouban,UMShareToRenren,UMShareToTencent,nil]
                                       delegate:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBK];
    [self registerCell];
}
- (IBAction)collectAction:(id)sender {
  //  GYDataModel *model=[GYDataModel shared];
    
    //if (model.login==YES) {
        self.collect.selected=!self.collect.selected;
        GYDataManager *manager=[GYDataManager sharedDataBase];
        if (self.collect.selected==YES) {
            GYDataModel *model=[[GYDataModel alloc]init];
            model.ID=[self.dic[@"id"] integerValue];
            model.imStr=[self.dic[@"bg_pic"] firstObject];
            model.fstr=self.dic[@"title"];
            model.sstr=self.dic[@"sub_title"];
            model.tStr=self.dic[@"destination"];
            NSString *string1=[self.dic[@"start_date"] substringWithRange:NSMakeRange(5, 2)];
            NSString *string2=[self.dic[@"start_date"] substringWithRange:NSMakeRange(8, 2)];
            NSString *string3=[self.dic[@"end_date"] substringWithRange:NSMakeRange(5, 2)];
            NSString *string4=[self.dic[@"end_date"]  substringWithRange:NSMakeRange(8, 2)];
            model.foStr=[NSString stringWithFormat:@"%@月%@日-%@月%@日",string1,string2,string3,string4];
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
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    float width= (SCREENWIDTH-40-30)/6.f;
    if (scrollView.contentOffset.y>width+190) {
        self.titleLb.text=self.dic[@"title"];
    }
}

- (void)setBK{
//    UIImageView *im=[[UIImageView alloc]initWithFrame:self.tv.bounds];
//    im.image=[UIImage imageNamed:@"背景图"];
//    self.tv.backgroundView=im;
    
    GYView *view=[[GYView alloc]init];
    float width= (SCREENWIDTH-40-30)/6.f;
    view.frame=CGRectMake(0, 0, SCREENWIDTH, 190+width);
    [view  createHeader:self.dic];
    self.tv.tableHeaderView=view;
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"cellback" object:nil userInfo:nil];
}
- (void)registerCell{
    
    [self.tv registerNib:[UINib nibWithNibName:@"GYDetail3Cell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    [self.tv registerNib:[UINib nibWithNibName:@"GYDe2Cell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    self.tv.separatorStyle=UITableViewCellSeparatorStyleNone;
}


#pragma mark --------------------UITableView协议方法------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 6;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    else if(section==1) {
        return [self.dic[@"details"] count];
    }
    
    else if(section==4) {
        if (fold[section-2]==1) {
            return 2;
        }
        else{
            return 0;
        }
        
    }
    return 0;
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID=@"reuse id";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    if (indexPath.section==0) {
        GYDetail3Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        cell.block=^(){
            GYMapViewController *map=[[GYMapViewController alloc]init];
            NSDictionary *d=self.dic[@"location"];
            map.array=@[d[@"lat"],d[@"lng"]];
            [self.navigationController pushViewController:map animated:YES];

        };
        cell.fLb.text=self.dic[@"destination"];
        cell.sLb.text=self.dic[@"address"];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    
    else  if(indexPath.section==1){
        
        
        NSArray *a=self.dic[@"details"];
        NSDictionary *dict=a[indexPath.row];
        NSDictionary *d=dict[@"content"];
        if ([dict[@"type"] isEqualToString:@"text"]) {
            UILabel *lb=[[UILabel alloc]init];
            lb.text=d[@"text"];
            lb.font=[UIFont systemFontOfSize:13];
            CGSize size=[lb.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(SCREENWIDTH-16, FLT_MAX)];
            lb.frame=CGRectMake(8, 0, SCREENWIDTH-16, size.height);
            lb.numberOfLines=0;
            [cell.contentView addSubview:lb];
            return cell;
            
        }
        else if([dict[@"type"] isEqualToString:@"head"]){
            
            UILabel *lb=[[UILabel alloc]init];
            lb.text=d[@"head"];
            lb.numberOfLines=0;
            lb.textAlignment=NSTextAlignmentCenter;
            [cell.contentView addSubview:lb];
            CGSize size=[lb.text sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(SCREENWIDTH-16, FLT_MAX)];
            lb.frame=CGRectMake(8, 0, SCREENWIDTH-16, size.height);
            return cell;
            
        }
        else if([dict[@"type"] isEqualToString:@"pic"]){
            
            UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(8, 0, SCREENWIDTH-16, 110)];
            im.layer.cornerRadius=5.f;
            im.layer.masksToBounds=YES;
            [im sd_setImageWithURL:[NSURL URLWithString:d[@"url"]]];
            [cell.contentView addSubview:im];
            return cell;
            
        }
        else{
            GYDe2Cell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
            NSDictionary *dictionary=self.dic[@"referrer"];
            [cell.imV sd_setImageWithURL:[NSURL URLWithString:dictionary[@"photo_url"]]];
            cell.imV.layer.cornerRadius=30;
            cell.imV.layer.masksToBounds=YES;
            cell.lb.text=dictionary[@"username"];
            return cell;
        }
        
    }
    else if(indexPath.section==4){
        if (indexPath.row==0) {
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(55, 5, SCREENWIDTH, 40)];
            label.text=self.dic[@"contact"];
            label.font=[UIFont systemFontOfSize:13];
            label.numberOfLines=0;

            [cell.contentView addSubview:label];
            return cell;
        }
        else{
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(55, 5, SCREENWIDTH, 40)];
            label.font=[UIFont systemFontOfSize:13];
            label.numberOfLines=0;
            NSString *str=self.dic[@"order_url"];
             NSString *string=[str substringFromIndex:7];
            NSArray *a=[string componentsSeparatedByString:@"/"];
            label.text=[NSString stringWithFormat:@"在线预订:   %@",a.firstObject];
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            [cell.contentView addSubview:label];
            return cell;
        }
    }
    return cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 100;
    }
    else if(indexPath.section==1){
        NSArray *a=self.dic[@"details"];
        NSDictionary *dict=a[indexPath.row];
        NSDictionary *d=dict[@"content"];
        
        if ([dict[@"type"] isEqualToString:@"text"]) {
            NSString *str=d[@"text"];
            CGSize size=[str sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(SCREENWIDTH-16, FLT_MAX)];
            return  size.height+10;
            
        }
        else if([dict[@"type"] isEqualToString:@"head"]){
            NSString *str=d[@"head"];
            CGSize size=[str sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(SCREENWIDTH-16, FLT_MAX)];
            return  size.height+10;;
        }
        else{
            return 120;
        }
        
    }
    else if (indexPath.section==4){
        return 50;
    }
    return 0;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section>=2) {
        return 40;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section>=2) {
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 40)];
        UIImageView *imV=[[UIImageView alloc]initWithFrame:CGRectMake(20, 5, 2, 30)];
        imV.image=[UIImage imageNamed:@"activity_red"];
        [view addSubview:imV];
        NSArray *arr=@[@"费用",@"时间",@"预定方式",@"评论"];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(50, 5, 100, 30)];
        label.text=arr[section-2];
        label.font=[UIFont systemFontOfSize:13];
        if (section==2) {
            UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH-140, 5, 100, 30)];
            lb.text=[NSString stringWithFormat:@"%@元",self.dic[@"price"]];
            lb.textColor=[UIColor redColor];
            [view addSubview:lb];
        }
        [view addSubview:label];
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH-40, 5, 20, 20)];
        if (fold[section-2]) {
            im.image=[UIImage imageNamed:@"activity_UpAccessory"];
        }
        else{
            im.image=[UIImage imageNamed:@"activity_DownAccessory"];
        }
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        im.userInteractionEnabled=YES;
        [im addGestureRecognizer:tap];
        im.tag=998+section-2;
        [view addSubview:im];
        return view;
    }
    return nil;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    fold[tap.view.tag-998]=!fold[tap.view.tag-998];
    
    //刷新对应行
    [self.tv reloadSections:[NSIndexSet indexSetWithIndex:tap.view.tag-998+2] withRowAnimation:UITableViewRowAnimationFade];
    //[self.tv reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    NSInteger ID=[self.dic[@"id"] integerValue];
    if ([[GYDataManager sharedDataBase] isexist:ID]) {
        self.collect.selected=YES;
    }
}


@end
