//
//  GYCollectViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/19.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYCollectViewController.h"
#import "GYDataManager.h"
#import "GYDataModel.h"
#import "GYCeoCell.h"
#import "GYDe2ViewController.h"
#import "User.h"
#import "GYMineViewController.h"
@interface GYCollectViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property (nonatomic, strong) NSMutableArray *dataSource;
@property (nonatomic, strong) UIImageView *imV;
@property (nonatomic, strong) UILabel *lb;

@end

@implementation GYCollectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setBK];
    [self regiCell];
   
    [[NSNotificationCenter defaultCenter] addObserverForName:@"COLLECTADD" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        // NSArray *arr=[[GYDataManager sharedDataBase] queryData];
        //self.navigationController.tabBarItem.badgeValue=[NSString stringWithFormat:@"%lu",arr.count ];
    }];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"COLLECTDELETE" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
       // NSArray *arr=[[GYDataManager sharedDataBase] queryData];
       // self.navigationController.tabBarItem.badgeValue=[NSString stringWithFormat:@"%lu",arr.count ];
    }];

    
    
}
- (IBAction)back:(id)sender {
    User*user=[[User currentUser] decodeUser];
    user=nil;
    [[User currentUser] encodeUser:user];
    
    GYMineViewController *mine=[[GYMineViewController alloc]init];
    
    [self.navigationController pushViewController:mine animated:YES];
}
- (IBAction)editAction:(id)sender {
    [self.tv setEditing:!self.tv.isEditing animated:YES];
    
}

- (void)regiCell{
    [self.tv registerNib:[UINib nibWithNibName:@"GYCeoCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (void)setBK
{
    UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT-64)];
    im.image=[UIImage imageNamed:@"背景图"];
    self.tv.backgroundView=im;
    self.tv.contentInset=UIEdgeInsetsMake(150, 0, 0, 0);
    self.imV=[[UIImageView alloc]initWithFrame:CGRectMake(0, -150, SCREENWIDTH, 150)];
    self.imV.image=[UIImage imageNamed:@"collect_bg.jpg"];
//    self.tv.tableHeaderView=imV;
    [self.tv addSubview:self.imV];
    float height=CGRectGetHeight(self.imV.frame);
    self.lb=[[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-100, -(height/2+10), 200, 20)];
    self. lb.text=self.text;
    self.lb.textColor=[UIColor whiteColor];
    self.lb.font=[UIFont systemFontOfSize:20];
    self.lb.textAlignment=NSTextAlignmentCenter;
    [self.tv addSubview:self.lb];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y<-150) {
        CGRect frame=self.imV.frame;
        frame.size.width=(-scrollView.contentOffset.y)/150*SCREENWIDTH;
        frame.origin.x=SCREENWIDTH/2-(-scrollView.contentOffset.y)/150*SCREENWIDTH/2;
        frame.origin.y=scrollView.contentOffset.y;
        frame.size.height=-scrollView.contentOffset.y;
        self.imV.frame=frame;
        float height=CGRectGetHeight(self.imV.frame);
        self.lb.frame=CGRectMake(SCREENWIDTH/2-100, -(height/2+10), 200, 20);
    }
}
- (IBAction)backAction:(id)sender {
    GYDataModel *model=[GYDataModel shared];
    model.login=NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    GYCeoCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell"];
    GYDataModel *model=self.dataSource[indexPath.row];
    [cell.headerImage sd_setImageWithURL:[NSURL URLWithString:model.imStr]];
    cell.fLb.text=model.fstr;
    cell.sLb.text=model.sstr;
    cell.tLb.text=model.tStr;
    cell.fouLb.text=model.foStr;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    GYDataModel *model=self.dataSource[indexPath.row];
    [self.dataSource removeObjectAtIndex:indexPath.row];
    [[GYDataManager sharedDataBase] deleteData:model.ID];
   // self.navigationController.tabBarItem.badgeValue=[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count];
    [self.tv reloadData];
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //GYDataModel *model=self.dataSource[indexPath.row];
    GYDe2ViewController *de=[[GYDe2ViewController alloc]init];
   
    de.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:de animated:YES];
    
}

- (NSMutableArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSMutableArray alloc]init];
        
    }
    return _dataSource;
}

- (void)viewWillAppear:(BOOL)animated{
    
   NSArray *arr=[[GYDataManager sharedDataBase] queryData];
    [self.dataSource removeAllObjects];
    [self.dataSource addObjectsFromArray:arr];
    [self.tv reloadData];
   // self.navigationController.tabBarItem.badgeValue=[NSString stringWithFormat:@"%lu",(unsigned long)self.dataSource.count];
}

@end
