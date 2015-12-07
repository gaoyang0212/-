//
//  GYMyInterViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYMyInterViewController.h"
#define   INTERURL @"http://appsrv.flyxer.com/api/digest/recomm/tag/%ld?did=30113&v=2&page=1"
#define INTER_URL(ID) [NSString stringWithFormat:INTERURL,ID]
#import "GYDetailCell.h"
#import "DetailModel.h"
#import "GYChoiceCell.h"
#import "GYAnitimation.h"
#import "GYMyDetailViewController.h"
#import "GYMyDetail2ViewController.h"
@interface GYMyInterViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) GYAnitimation *ani;

@end

@implementation GYMyInterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLb.text=self.titleStr;
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.ani=[[GYAnitimation alloc]init];
    [self.ani showAnimationViewS:self.view];
    [self createFooter];
    [self setBK];
    [self registerCell];
    [self loadData];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"cellNoti" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        NSDictionary *no=note.userInfo;
        NSInteger ID=[no[@"w"] integerValue];
        NSString *string=no[@"q"];
        NSString *str=[NSString stringWithFormat:@"%ld?v",ID];
        GYMyDetailViewController *de=[[GYMyDetailViewController alloc]init];
        de.string=str;
        de.strName=string;
        de.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:de animated:YES];
    }]; 
}

- (IBAction)backAction:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark------------UITableView协议方法-------------------
//tableView末尾视图
- (void)createFooter{
    
    UIImageView *i=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,SCREENWIDTH , 15)];
    i.image=[UIImage imageNamed:@"collect_the_end"];
    self.tv.tableFooterView=i;
}

- (void)setBK{
    UIImageView *im=[[UIImageView alloc]initWithFrame:self.tv.bounds];
    im.image=[UIImage imageNamed:@"背景图"];
    self.tv.backgroundView=im;
}

//注册cell
- (void)registerCell{
    [self.tv registerNib:[UINib nibWithNibName:@"GYDetailCell" bundle:nil] forCellReuseIdentifier:@"cell2"];
    [self.tv registerNib:[UINib nibWithNibName:@"GYChoiceCell" bundle:nil] forCellReuseIdentifier:@"cell1"];
}


- (void)loadData{
    AFHTTPRequestOperationManager *m=[AFHTTPRequestOperationManager manager];
    NSInteger IDD=self.ID.integerValue;
    [m GET:INTER_URL(IDD) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.ani hideAnimationViewS];
        self.dataSource=responseObject;
        [self.tv reloadData];

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark ----------------UITableView协议-------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *d=self.dataSource[indexPath.row];
    if ([d[@"type"] isEqualToString:@"Collection"]) {
        GYChoiceCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell1"];
        [cell cellWithDic:d];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cell;
    }
    GYDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell2"];
    DetailModel *model=[[DetailModel alloc]initWithDictionary:d error:nil];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=model;
    cell.rightIm.image=[UIImage imageNamed:@"home_black_c"];
    cell.smallIm.image=[UIImage imageNamed:@"recomment_unlike"];
    cell.smallLb.text=[NSString stringWithFormat:@"%ld",model.like_count];
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *d=self.dataSource[indexPath.row];
    if ([d[@"type"] isEqualToString:@"Collection"]) {
        
        return 200;
    }
    DetailModel *model=[[DetailModel alloc]initWithDictionary:d error:nil];
    float height=[model.short_desc boundingRectWithSize:CGSizeMake(299, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.height;
    return height+190;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GYMyDetail2ViewController *de2=[[GYMyDetail2ViewController alloc]init];
    de2.dic=self.dataSource[indexPath.row];
    [self.navigationController pushViewController:de2 animated:YES];
    
}


- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSArray alloc]init];
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"viewAppear" object:nil userInfo:nil];
    
}


- (void)viewWillDisappear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"viewDisAppear" object:nil userInfo:nil];
    
}





@end
