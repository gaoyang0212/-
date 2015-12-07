//
//  GYDetailViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYDetailViewController.h"
#import "AFNetworking.h"
#import "GYDetailCell.h"
#import "UIImageView+WebCache.h"
#import "DetailModel.h"
#import "MBProgressHUD.h"
#import "GYDetail2ViewController.h"
#define DETAIL @"http://appsrv.flyxer.com/api/digest/collection/%@=2&page=1"
#define DETAILM_URL(i) [NSString stringWithFormat:DETAIL,i]
#import "GYHeader.h"
#import "GYAnitimation.h"
@interface GYDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) GYAnitimation *ani;
@property (nonatomic, strong) UITableView *tv;
@property (nonatomic, strong) NSArray *array;
@end

@implementation GYDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLb.text=self.strName;
    self.navigationController.navigationBarHidden=YES;
    //[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.ani=[[GYAnitimation alloc]init];
    [self loadData];
    [self registerCell];
    [self setBK];
    [self createFooter];
    [self tv];
    [self.ani showAnimationViewS:self.view];
}
- (IBAction)back:(id)sender {
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"back" object:nil userInfo:nil];
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
       
            //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.ani hideAnimationViewS];
            self.array=responseObject;
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
    cell.model=model;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    DetailModel *model=self.dataSource[indexPath.row];
    float height=[model.short_desc boundingRectWithSize:CGSizeMake(299, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:nil context:nil].size.height;
    
    return height+190;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GYDetail2ViewController *de2=[[GYDetail2ViewController alloc]init];
    de2.hidesBottomBarWhenPushed=YES;
    de2.dic=self.array[indexPath.row];
    [self.navigationController pushViewController:de2 animated:YES];
    
}

//懒加载
- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
    }
    return _dataSource;
}

-(UITableView *)tv{
    if (!_tv) {
        _tv=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREENWIDTH, SCREENHEIGHT-64) style:UITableViewStylePlain];
        _tv.dataSource=self;
        _tv.delegate=self;
        [self.view addSubview:_tv];
    }
    return _tv;
}
@end
