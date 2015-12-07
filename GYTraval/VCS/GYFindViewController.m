//
//  GYFindViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYFindViewController.h"
#define FINDURL @"http://appsrv.flyxer.com/api/digest/discovery?did=30113"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "GYInterest.h"
#import "GYView.h"
#import "GYChCell.h"
#import "GYHotCell.h"
#import "GYHeader.h"
#import "GYChoiViewController.h"
#import "GYMyInterViewController.h"
#import "GYNextStopViewController.h"
#import "GYAnitimation.h"
#import "GYFindSearchViewController.h"
#import "GYArticleViewController.h"
#import "GYAllChoiViewController.h"
#import "GYDe2ViewController.h"
@interface GYFindViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

//广告栏数组
@property (nonatomic, strong) NSMutableArray *dataSource;
//数据源字典
@property (nonatomic, strong) NSDictionary *dicSource;

@property (nonatomic, strong) UIPageControl *pageControll;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong)GYAnitimation *ani;
@end

@implementation GYFindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    self.tv.separatorStyle= UITableViewCellSeparatorStyleNone;
    //[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    self.ani =[[GYAnitimation alloc]init];
    [self.ani showAnimationView:self.view];
    [self loadData];
    [self registerCell];
    [self setBK];
    
}
- (IBAction)searchAction:(id)sender {
    GYFindSearchViewController *search=[[GYFindSearchViewController alloc]init];
    search.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:search animated:YES];
}


//设置背景

- (void)setBK{
    UIImageView *im=[[UIImageView alloc]initWithFrame:self.tv.bounds];
    im.image=[UIImage imageNamed:@"背景图"];
    self.tv.backgroundView=im;
}
//注册cell
- (void)registerCell{
    
    [self.tv registerNib:[UINib nibWithNibName:@"GYChCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
    
    [self.tv registerNib:[UINib nibWithNibName:@"GYHotCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
}

- (void)loadData{
    
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    
    [manger GET:FINDURL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.dicSource=responseObject;
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2]];
        [self.dataSource addObjectsFromArray:responseObject[@"articles"]];
        //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.ani hideAnimationView];
        [self createView];
        [self.tv reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

//广告栏
- (void)createView{
    UIView *vi=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 170)];
    self.tv.tableHeaderView=vi;
    UIScrollView *scro=[[UIScrollView alloc]initWithFrame:vi.bounds];
    self.scrollView=scro;
    scro.delegate=self;
    [vi addSubview:scro];
     [vi addSubview:self.pageControll];
    for (int i=0; i<self.dataSource.count+2; i++) {
      
        UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(i*SCREENWIDTH, 0, SCREENWIDTH, CGRectGetHeight(scro.frame))];
        NSInteger ID;
        if (i==self.dataSource.count+1) {
             NSDictionary *di=self.dataSource[0];
             [img sd_setImageWithURL:[NSURL URLWithString:di[@"bg_pic"]]];
             ID=[di[@"id"] integerValue];
        }
        else if (i==0){
            NSDictionary *di=self.dataSource.lastObject;
            [img sd_setImageWithURL:[NSURL URLWithString:di[@"bg_pic"]]];
             ID=[di[@"id"] integerValue];
        }
        else{
        NSDictionary *d=self.dataSource[i-1];
        [img sd_setImageWithURL:[NSURL URLWithString:d[@"bg_pic"]]];
          ID=[d[@"id"] integerValue];
        }
        img.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(articleTapAction:)];
        [img addGestureRecognizer:tap];
        img.tag=998+ID;
        [scro addSubview:img];
        scro.contentSize=CGSizeMake(CGRectGetMaxX(img.frame), 0);
        
    }
    scro.showsHorizontalScrollIndicator=NO;
    scro.pagingEnabled=YES;
    scro.contentOffset=CGPointMake(SCREENWIDTH, 0);
}

//广告栏详情
- (void)articleTapAction:(UITapGestureRecognizer *)tap{
    GYArticleViewController *article=[[GYArticleViewController alloc]init];
    article.hidesBottomBarWhenPushed=YES;
    article.ID=tap.view.tag-998;
    UIImageView *im=(UIImageView *)tap.view;
    article.imag=im.image;
    [self.navigationController pushViewController:article animated:YES];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView == self.scrollView) {
        NSInteger page=scrollView.contentOffset.x/SCREENWIDTH;
        if (page==self.dataSource.count+1) {
            scrollView.contentOffset=CGPointMake(SCREENWIDTH, 0);
            self.pageControll.currentPage=0;
        }
        else if (page==0){
            scrollView.contentOffset=CGPointMake(SCREENWIDTH*self.dataSource.count, 0);
            self.pageControll.currentPage=self.dataSource.count-1;
        }
        else{
            self.pageControll.currentPage=page-1;
        }

    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    if (scrollView == self.scrollView) {
        NSInteger page=scrollView.contentOffset.x/SCREENWIDTH;
        if (page==self.dataSource.count+1) {
            scrollView.contentOffset=CGPointMake(SCREENWIDTH, 0);
            self.pageControll.currentPage=0;
        }
        else if (page==0){
            scrollView.contentOffset=CGPointMake(SCREENWIDTH*self.dataSource.count, 0);
            self.pageControll.currentPage=self.dataSource.count-1;
        }
        else{
            self.pageControll.currentPage=page-1;
        }

    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView==self.scrollView) {
        [self.timer setFireDate:[NSDate distantFuture]];
    }
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    if (scrollView==self.scrollView) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.5]];
    }
    
}

- (void)timerAction{
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+SCREENWIDTH, 0) animated:YES];
    
}

#pragma mark --------------UITableView协议方法---------------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==2) {
      return 4;
    }
    else if (section==3){
        
        return [self.dicSource[@"top_selections"] count]+1;
    }
    
    return 2;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *reuseID=@"reuse id";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:reuseID];
    if (!cell) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseID];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    //cell的选中状态
    cell.selectionStyle= UITableViewCellSelectionStyleNone;
    //第0组
    if (indexPath.section==0) {
        
        if (indexPath.row==0) {
            cell.textLabel.text=@"发现 · 我的兴趣";
            cell.accessoryType=UITableViewCellAccessoryNone;
            return cell;
        }
        [self Mycell0:cell];
    
        return cell;
    }
    //第1组
    else if(indexPath.section==1)
    {
        if (indexPath.row==0) {
            cell.textLabel.text=@"发现 · 下一站";
            return cell;
        }
        
        [self myCell1:cell];
        
        return cell;
    }
    
    //第2组
    else if(indexPath.section==2){
        if (indexPath.row==0) {
            cell.textLabel.text=@"发现 · 精选主题";
            cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
            return cell;
        }
        GYChCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        NSArray *array=self.dicSource[@"collections"];
        NSDictionary *d=array[indexPath.row-1];
        [cell cellWithDic:d];
        return cell;
    }
    //第3组
    else{
        if (indexPath.row==0) {
            cell.textLabel.text=@"发现 · 一周最热";
            return cell;
        }
        GYHotCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
        for (UIView *view in cell.hotImg.subviews) {
            [view removeFromSuperview];
        }
        NSArray *array=self.dicSource[@"top_selections"];
        
        NSDictionary *d=array[indexPath.row-1];
        [cell cellWithDic:d];
        if (indexPath.row==1) {
            cell.hotImg.image=[UIImage imageNamed:@"home_red_num2_long"];
            UILabel *label=[[UILabel alloc]initWithFrame:cell.hotImg.bounds];
            label.text=@"Top1";
            label.textAlignment=NSTextAlignmentCenter;
            label.textColor=[UIColor whiteColor];
            [cell.hotImg addSubview:label];
        }
        else if (indexPath.row==2){
            cell.hotImg.image=[UIImage imageNamed:@"home_red_num2_long"];
            UILabel *label=[[UILabel alloc]initWithFrame:cell.hotImg.bounds];
            label.text=@"Top2";
            label.textAlignment=NSTextAlignmentCenter;
            label.textColor=[UIColor whiteColor];
            [cell.hotImg addSubview:label];

            
        }
        else if(indexPath.row ==3){
           
            cell.hotImg.image=[UIImage imageNamed:@"home_red_num2_long"];
            UILabel *label=[[UILabel alloc]initWithFrame:cell.hotImg.bounds];
            label.text=@"Top3";
            label.textAlignment=NSTextAlignmentCenter;
            label.textColor=[UIColor whiteColor];
            [cell.hotImg addSubview:label];

        }
        
        return cell;
    }
    
}
- (void)Mycell0:(UITableViewCell *)cell{
    NSArray *interA=self.dicSource[@"tags"];
    UIScrollView *scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 175)];
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
    for (int i=0; i<interA.count; i++) {
        
        [cell.contentView addSubview:scrollView];
        float width=(SCREENWIDTH-48)/5.f;
        GYInterest *model=[[GYInterest alloc]initWithDictionary:interA[i] error:nil];
        NSDictionary *dic=interA[i];
        model.ID=[dic[@"id"] stringValue];
        UILabel *idlb=[[UILabel alloc]init];
        idlb.text=model.ID;
        UIImageView *v=[[UIImageView alloc]initWithFrame:CGRectMake((8+width)*(i%6)+20, 8+80*(i/6), width, 70)];
        [v addSubview:idlb];
        v.tag=100+i;
        idlb.tag=v.tag+200;
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
        [im sd_setImageWithURL:[NSURL URLWithString:model.icon]];
        [v addSubview:im];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap0Action:)];
        v.userInteractionEnabled=YES;
        [v addGestureRecognizer:tap];
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 42, 30, 30)];
        label.text=model.name;
        label.tag=v.tag+400;
        label.textAlignment=NSTextAlignmentCenter;
        label.font=[UIFont systemFontOfSize:13];
        [v addSubview:label];
        scrollView.contentSize=CGSizeMake(CGRectGetMaxX(v.frame), 0);
        [scrollView addSubview:v];
   }
}

- (void)tap0Action:(UITapGestureRecognizer *)tap{
    UILabel *lt=(UILabel *)[self.view viewWithTag:tap.view.tag+400];
    UILabel *lb=(UILabel *)[self.view viewWithTag:tap.view.tag+200];
    GYMyInterViewController *inter=[[GYMyInterViewController alloc]init];
    inter.hidesBottomBarWhenPushed=YES;
    inter.ID=lb.text;
    inter.titleStr=lt.text;
    [self.navigationController pushViewController:inter animated:YES];
}


- (void)myCell1:(UITableViewCell *)cell{
    NSArray *array=self.dicSource[@"next_stops"];
    for (int i=0; i<array.count; i++) {
        NSDictionary *dicti=array[i];
        float width=(SCREENWIDTH-24)/2.f;
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake((8+width)*(i%2)+8, 8+110*(i/2), width, 100)];
        
        [im sd_setImageWithURL:[NSURL URLWithString:dicti[@"bg_pic"]]];
        im.layer.cornerRadius=5.f;
        im.layer.masksToBounds=YES;
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(im.frame)/2-50, CGRectGetHeight(im.frame)/2-20, 100, 40)];
        label.text=dicti[@"title"];
        label.numberOfLines=0;
        label.font=[UIFont systemFontOfSize:15];
        label.textAlignment=NSTextAlignmentCenter;
        label.textColor=[UIColor whiteColor];
        [im addSubview:label];
        im.userInteractionEnabled=YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap1Action:)];
        [im addGestureRecognizer:tap];
        [cell.contentView addSubview:im];
        NSInteger ID=[dicti[@"id"] integerValue];
        im.tag=998+ID;
        label.tag=im.tag+998;
    }
}

- (void)tap1Action:(UITapGestureRecognizer *)tap{
    GYNextStopViewController *next=[[GYNextStopViewController alloc]init];
    next.hidesBottomBarWhenPushed=YES;
    UILabel *lb=(UILabel *)[self.view viewWithTag:tap.view.tag+998];
    next.titleStr=lb.text;
    next.ID=tap.view.tag-998;
    UIImageView *imV=(UIImageView *)tap.view;
    next.imag=imV.image;
    [self.navigationController pushViewController:next animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            return 35;
        }
        return 115;
    }
    else if (indexPath.section==3){
        if (indexPath.row==0) {
            return 30;
        }
        return 110;
    }
    else if(indexPath.section==1){
        if (indexPath.row==0) {
            return 35;
        }
        return 230;
    }
    else{
        if (indexPath.row==0) {
            return 35;
        }
        return 175;
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==2) {
        if (indexPath.row==0) {
            GYChoiViewController *ch=[[GYChoiViewController alloc]init];
            ch.hidesBottomBarWhenPushed=YES;
            ch.dataSource=self.dicSource[@"collections"];
            [self.navigationController pushViewController:ch animated:YES];
        }
        else{
            GYAllChoiViewController *all=[[GYAllChoiViewController alloc]init];
            all.hidesBottomBarWhenPushed=YES;
            NSArray *arr=self.dicSource[@"collections"];
            NSDictionary *d=arr[indexPath.row-1];
            NSInteger ID=[d[@"id"] integerValue];
            NSString *st=[NSString stringWithFormat:@"%ld?v",ID];
            all.string=st;
            all.strName=d[@"title"];
            all.des=d[@"short_desc"];
            [self.navigationController pushViewController:all animated:YES];

        }
        
    }
    if (indexPath.section==3) {
        if (indexPath.row!=0) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"提示" message:@"没有数据" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alert show];
        }
    }
}

//懒加载
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

- (UIPageControl *)pageControll {
    if (!_pageControll) {
        _pageControll=[[UIPageControl alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-50, 150, 100, 10)];
        _pageControll.numberOfPages=self.dataSource.count;
        _pageControll.currentPageIndicatorTintColor=[UIColor whiteColor];
        //_pageControll.backgroundColor=[UIColor redColor];
    }
    return _pageControll;
}

- (NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}

- (void)viewWillAppear:(BOOL)animated{
    if (self.dataSource.count>0) {
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.5]];
//        NSLog(@"计时器开始");
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    if (self.dataSource.count>0) {
        [self.timer setFireDate:[NSDate distantFuture]];
       
    }
}
@end
