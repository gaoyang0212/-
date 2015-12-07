//
//  GYArticleViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/17.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYArticleViewController.h"
#import "GYHeader.h"
#import "GYAnitimation.h"
@interface GYArticleViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSDictionary *_dictionary;
    NSString *_tit;
}
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UIView *headV;
@property (nonatomic, strong)UIImageView *imV;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@end

@implementation GYArticleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self loadData];
    [self setBK];
    self.headV.alpha=0;
    self.automaticallyAdjustsScrollViewInsets=NO;
   
}


- (void)setHeader{
    self.imV=[[UIImageView alloc]initWithFrame:CGRectMake(0, -200, SCREENWIDTH, 200)];
    self.imV.image=self.imag;
    //self.tv.tableHeaderView=self.imV;
    self.tv.contentInset=UIEdgeInsetsMake(200, 0, 0, 0);
    [self.tv addSubview:self.imV];
    self.tv.separatorStyle=UITableViewCellSeparatorStyleNone;
  
}
- (void)setBK{
    UIImageView *im=[[UIImageView alloc]initWithFrame:self.tv.bounds];
    im.image=[UIImage imageNamed:@"背景图"];
    self.tv.backgroundView=im;
   
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y>=0) {
        self.titleLabel.text=_tit;
        self.headV.alpha=1;
    }
    if (scrollView.contentOffset.y<0) {
        self.headV.alpha=0.16;
        self.titleLabel.text=@"";

    }
    if (scrollView.contentOffset.y<-200) {
        CGRect frame=self.imV.frame;
        frame.origin.y=scrollView.contentOffset.y;
        frame.size.height=-scrollView.contentOffset.y;
        frame.size.width=(-scrollView.contentOffset.y)/200*SCREENWIDTH;
        frame.origin.x=SCREENWIDTH/2-(-scrollView.contentOffset.y)/200*SCREENWIDTH/2;
        self.imV.frame=frame;

    }

}

- (void)loadData{
    GYAnitimation *ani=[[GYAnitimation alloc]init];
    [ani showAnimationViewS:self.view];
    AFHTTPSessionManager *manager=[AFHTTPSessionManager manager];
    [manager GET:ARTICLE_URL(self.ID) parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [self setHeader];
        _dictionary=responseObject;
        self.dataSource=responseObject[@"body"];
        _tit=_dictionary[@"title"];
        [self.tv reloadData];
        
        [ani hideAnimationView];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *reuseID=@"reuse id";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    NSDictionary *dict=self.dataSource[indexPath.row];
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
    else{
        
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(8, 0, SCREENWIDTH-16, 110)];
        im.layer.cornerRadius=5.f;
        im.layer.masksToBounds=YES;
        [im sd_setImageWithURL:[NSURL URLWithString:d[@"url"]]];
        [cell.contentView addSubview:im];
        return cell;
        
    }

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict=self.dataSource[indexPath.row];
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

@end
