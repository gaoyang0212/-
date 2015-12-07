//
//  GYNextStopViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYNextStopViewController.h"
#import "GYAnitimation.h"
#define NEXT @"http://appsrv.flyxer.com/api/digest/article/%ld"
#define NEXT_URL(ID) [NSString stringWithFormat:NEXT,ID]
@interface GYNextStopViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    float height1;
    float height2;
}
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) GYAnitimation *ani;
@end

@implementation GYNextStopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.ani=[[GYAnitimation alloc]init];
    [self.ani showAnimationViewS:self.view];
    self.titleLb.text=self.titleStr;
    [self setBK];
    [self loadData];
}
- (void)setHeader{
    UIImageView *i=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 250)];
    i.image=self.imag;
    self.tv.tableHeaderView=i;
    self.tv.separatorStyle=UITableViewCellSeparatorStyleNone;

}
- (void)setBK{
    UIImageView *im=[[UIImageView alloc]initWithFrame:self.tv.bounds];
    im.image=[UIImage imageNamed:@"背景图"];
    self.tv.backgroundView=im;
}

- (void)loadData{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    [manager GET:NEXT_URL(self.ID) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self setHeader];
        [self.ani hideAnimationViewS];
        self.dataSource=responseObject[@"body"];
        [self.tv reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID=@"reuse id";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:reuseID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSDictionary *dic=self.dataSource[indexPath.row];
    NSDictionary *d=dic[@"content"];
    if ([dic[@"type"] isEqualToString:@"text"]) {
        UILabel *lb=[[UILabel alloc]init];
        lb.text=d[@"text"];
        lb.font=[UIFont systemFontOfSize:13];
        CGSize size=[lb.text sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(SCREENWIDTH-16, FLT_MAX)];
        lb.frame=CGRectMake(8, 0, size.width, size.height);
        lb.numberOfLines=0;
        [cell.contentView addSubview:lb];
        return cell;

    }
    else if([dic[@"type"] isEqualToString:@"head"]){

        UILabel *lb=[[UILabel alloc]init];
        lb.text=d[@"head"];
        lb.numberOfLines=0;
        lb.textAlignment=NSTextAlignmentCenter;
        [cell.contentView addSubview:lb];
        CGSize size=[lb.text sizeWithFont:[UIFont systemFontOfSize:20] constrainedToSize:CGSizeMake(SCREENWIDTH-16, FLT_MAX)];
        lb.frame=CGRectMake(8, 0, size.width, size.height);
        return cell;

    }
    else{
        float height=[d[@"height"] floatValue];
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(8, 0, SCREENWIDTH-16, height)];
        im.layer.cornerRadius=5.f;
        im.layer.masksToBounds=YES;
        [im sd_setImageWithURL:[NSURL URLWithString:d[@"url"]]];
        [cell.contentView addSubview:im];
        return cell;

    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=self.dataSource[indexPath.row];
    NSDictionary *d=dic[@"content"];

    if ([dic[@"type"] isEqualToString:@"text"]) {
        NSString *str=d[@"text"];
         CGSize size=[str sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(SCREENWIDTH-16, FLT_MAX)];
        return  size.height+10;
        
    }
    else if([dic[@"type"] isEqualToString:@"head"]){
        NSString *str=d[@"head"];
        CGSize size=[str sizeWithFont:[UIFont systemFontOfSize:13] constrainedToSize:CGSizeMake(SCREENWIDTH-16, FLT_MAX)];
        return  size.height+10;;
    }
    else{
        return [d[@"height"] floatValue];;
    }

}

- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSArray alloc]init];
    }
    return _dataSource;
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)shareAction:(id)sender {
    
}

















@end
