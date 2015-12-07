//
//  GYMyDetailViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/17.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYMyDetailViewController.h"
#import "AFNetworking.h"
#import "GYDetailCell.h"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"
#import "MBProgressHUD.h"
#import "GYDetail2ViewController.h"
#import "GYMyDe2ViewController.h"
#import "GYHeader.h"
#import "GYAnitimation.h"
@interface GYMyDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) GYAnitimation *ani;
@property (nonatomic, strong) NSArray *arr;
@end

@implementation GYMyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLb.text=self.strName;
    self.navigationController.navigationBarHidden=YES;
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.ani=[[GYAnitimation alloc]init];
    [self.ani showAnimationViewS:self.view];
    [self loadData];
    [self registerCell];
    [self setBK];
    [self createFooter];
    
}


- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
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
    [self.tv registerNib:[UINib nibWithNibName:@"GYDetailCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}


- (void)loadData{
    AFHTTPRequestOperationManager *m=[AFHTTPRequestOperationManager manager];
    [m GET:DETAILM_URL(self.string) parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        self.arr=responseObject;
        [self.ani hideAnimationViewS];
        for (NSDictionary *d in responseObject) {
            DetailModel *model=[[DetailModel alloc]initWithDictionary:d error:nil];
            [self.dataSource addObject:model];
        }
        
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
    GYDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    DetailModel *model=self.dataSource[indexPath.row];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.model=model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailModel *model=self.dataSource[indexPath.row];
    float height=[model.short_desc boundingRectWithSize:CGSizeMake(299, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.height;
    
    return height+190;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GYMyDe2ViewController *de=[[GYMyDe2ViewController alloc]init];
    NSDictionary *dict=self.arr[indexPath.row];
    de.dic=dict;
    [self.navigationController pushViewController:de animated:YES];
    
}

//懒加载
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}


@end
