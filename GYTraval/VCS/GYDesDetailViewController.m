//
//  GYDesDetailViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYDesDetailViewController.h"
#import "GYDescDetailModel.h"
#import "GYDESDETACell.h"
#import "GYAnitimation.h"
#import "GYDes2ViewController.h"
#define DESDETAIL @"http://appsrv.flyxer.com/api/digest/recomm/dest/%ld?v=2&page=%ld"
#define DESDETAIL_URL(ID,page) [NSString stringWithFormat:DESDETAIL,ID,page]
@interface GYDesDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
      NSInteger page;
      int i;
    NSMutableArray *_arr;
    
}

@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property(nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic, strong) GYAnitimation *ani;
@property (nonatomic, strong) UIImageView *foo;
@end

@implementation GYDesDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _arr=[[NSMutableArray alloc]init];
    self.ani=[[GYAnitimation alloc]init];
    [self.ani showAnimationViewS:self.view];
    [self loadData:NO];
    [self setBK];
    [self registerCell];
    [self addLoad];
    self.titleLb.text=self.str;
    page=1;
    i=0;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.y>SCREENHEIGHT-64) {
        self.titleLb.text=@"热门产品";
        scrollView.pagingEnabled=NO;
    }
    if (scrollView.contentOffset.y<=SCREENHEIGHT-64) {
        self.titleLb.text=self.str;
        scrollView.pagingEnabled=YES;
    }
}

- (void)createHeaderView{
    
    UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64)];
    [im sd_setImageWithURL:[NSURL URLWithString:self.imageStr]];
    im.userInteractionEnabled=YES;
    self.foo=[[UIImageView alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-20, SCREENHEIGHT-110, 40, 40)];
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    self.foo.userInteractionEnabled=YES;
    [self.foo addGestureRecognizer:tap];
    [im addSubview:self.foo];
    self.tv.pagingEnabled=YES;
    self.tv.tableHeaderView=im;
    NSArray *arr=@[[UIImage imageNamed:@"upBtn.png"],[UIImage imageNamed:@"activity_moreD2.png"]];
    self.foo.animationImages=arr;
    self.foo.animationDuration=0.75;
    self.foo.animationRepeatCount=0;
    [self.foo startAnimating];
    
}
- (void)tapAction:(UITapGestureRecognizer *)tap{
    [self.tv setContentOffset:CGPointMake(0, SCREENHEIGHT-64) animated:YES];
}

//添加上啦加载
- (void)addLoad{
    
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self loadData:YES];
    }];
    self.tv.footer=footer;
}

- (void)registerCell{
    [self.tv registerNib:[UINib nibWithNibName:@"GYDESDETACell" bundle:nil] forCellReuseIdentifier:@"cell"];
}
- (void)setBK{
    UIImageView *im=[[UIImageView alloc]initWithFrame:self.tv.bounds];
    im.image=[UIImage imageNamed:@"背景图"];
    self.tv.backgroundView=im;
}

- (void)loadData:(BOOL)refresh{
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
  
    page=refresh?page+1:1;
    [manager GET:DESDETAIL_URL(self.ID,page) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [self createHeaderView];
        if (refresh==NO) {
            [_arr removeAllObjects];
        }
        [_arr addObjectsFromArray:responseObject];
        [self.ani hideAnimationViewS];
        for (NSDictionary *d in responseObject) {
            GYDescDetailModel *model=[[GYDescDetailModel alloc]initWithDictionary:d error:nil];
            [self.dataSource addObject:model];
        }
        if (refresh==YES) {
            [self.tv.footer endRefreshing];
        }
        [self.tv reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark----------------------UItableView协议方法------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GYDESDETACell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.model=self.dataSource[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 125;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GYDes2ViewController *de=[[GYDes2ViewController alloc]init];
    de.dic=_arr[indexPath.row];
    [self.navigationController pushViewController:de animated:YES];
    
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}



- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

@end
