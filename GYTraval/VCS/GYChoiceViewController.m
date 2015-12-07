//
//  GYChoiceViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYChoiceViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "GYChoiceCell.h"
#import "GYCell2.h"
#import "MJRefresh.h"
#import "GYHeader.h"
#define CHOICE @"http://appsrv.flyxer.com/api/digest/main?did=30113&qid=0&v=2&page=%ld"
#define CHOICE_URL(page) [NSString stringWithFormat:CHOICE,page]
#define baseTag 998
#import "GYDetailViewController.h"
#import "GYDe2ViewController.h"
#import "GYAnitimation.h"
#import "GYDataManager.h"
#import "GYCollectViewController.h"
@interface GYChoiceViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
{
    //数据源数组
    NSMutableArray *_array;
    NSTimer *_timer;
    //标记cell的数组
    NSArray *_cell1A;
    NSInteger _currentPage;
    NSString *_sName;
    
}
@property (nonatomic, strong)GYAnitimation *ani;
@property (weak, nonatomic) IBOutlet UIView *vie;
@end

@implementation GYChoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _currentPage=1;
    _array=[[NSMutableArray alloc]init];
    self.navigationController.navigationBarHidden=YES;
    [self loadData:YES];
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.ani=[[GYAnitimation alloc]init];
    [self.ani showAnimationView:self.view];
    [self registerCell];
    [self addRefresh];
    [self setBK];
    //self.vie.alpha=0;
    
    //cell1通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(notiAction:) name:@"cellNoti" object:nil];
   // [self setCollect];
}

- (void)setCollect{
    GYCollectViewController *collect=[[GYCollectViewController alloc]init];
    NSArray *arr=[[GYDataManager sharedDataBase] queryData];
     collect.navigationController.tabBarItem.badgeValue=[NSString stringWithFormat:@"%lu",arr.count ];
}
- (void)notiAction:(NSNotification *)noti{
    
    NSDictionary *no=noti.userInfo;
     NSInteger ID=[no[@"w"] integerValue];
    NSString *string=no[@"q"];
        NSString *str=[NSString stringWithFormat:@"%ld?v",ID];
        GYDetailViewController *detail=[[GYDetailViewController alloc]init];
        detail.string=str;
        detail.strName=string;
        detail.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:detail animated:YES];

}

//设置背景

- (void)setBK{
    UIImageView *im=[[UIImageView alloc]initWithFrame:self.tv.bounds];
    im.image=[UIImage imageNamed:@"背景图"];
    self.tv.backgroundView=im;

}

//添加下拉刷新 上啦加载
- (void)addRefresh{
    
    MJRefreshNormalHeader *header=[MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [self loadData:YES];
    }];
    self.tv.header=header;
    
    MJRefreshAutoNormalFooter *footer=[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [self loadData:NO];
    }];
    self.tv.footer=footer;
    
}

//注册cell
- (void)registerCell{
    [self.tv registerNib:[UINib nibWithNibName:@"GYChoiceCell" bundle:nil] forCellReuseIdentifier:@"Cell1"];
    
    [self.tv registerNib:[UINib nibWithNibName:@"GYCell2" bundle:nil] forCellReuseIdentifier:@"Cell2"];
}

#pragma mark ------------------UItableView--------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSDictionary *dic=_array[indexPath.row];

    NSString *str=dic[@"type"];
    
    if ([str isEqualToString:@"Collection"]) {
        
        GYChoiceCell *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell1"];
        
        [cell cellWithDic:dic];

        return cell;
    }
    else{
        
        GYCell2 *cell=[tableView dequeueReusableCellWithIdentifier:@"Cell2"];
        [cell cellWithDic:dic];
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=_array[indexPath.row];
    
    NSString *str=dic[@"type"];
    
    if ([str isEqualToString:@"Collection"]==NO) {
        //[[NSNotificationCenter defaultCenter] postNotificationName:@"cell2Noti" object:nil userInfo:nil];
        GYDe2ViewController *de=[[GYDe2ViewController alloc]init];
            de.hidesBottomBarWhenPushed=YES;
            de.dic=dic;
            [self.navigationController pushViewController:de animated:YES];
       
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dic=_array[indexPath.row];
    NSString *str=dic[@"type"];
    if ([str isEqualToString:@"Collection"]) {
        
        return 200;
    }
    NSString *string=dic[@"short_desc"];
    float height=[string boundingRectWithSize:CGSizeMake(304, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
    
    return 260+height;
    
}


//下载数据
- (void)loadData:(BOOL)refresh{
    
    AFHTTPRequestOperationManager *manger=[AFHTTPRequestOperationManager manager];
    NSInteger page=refresh?1:_currentPage+1;
    [manger GET:CHOICE_URL(page) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (refresh==YES) {
            [_array removeAllObjects];
        }
        NSArray *ar=responseObject[@"recomms"];
        [_array addObjectsFromArray:ar];
        if (refresh==NO) {
            _currentPage ++;
            [self.tv.footer endRefreshing];
        }
        
        //[MBProgressHUD hideHUDForView:self.view animated:YES];
        [self.ani hideAnimationView];
        [self.tv reloadData];
        [self.tv.header endRefreshing];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

- (void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"viewAppear" object:nil userInfo:nil];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"viewDisAppear" object:nil userInfo:nil];
    
}








@end
