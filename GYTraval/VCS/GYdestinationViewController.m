//
//  GYdestinationViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYdestinationViewController.h"
#import "AFNetworking.h"
#import "GYCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#define DES_URL @"http://appsrv.flyxer.com/api/digest/recomm/dests?page=1"
#import "GYHeader.h"
#import "GYDesDetailViewController.h"
#import "GYAnitimation.h"
@interface GYdestinationViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong)GYAnitimation *ani;
@end

@implementation GYdestinationViewController
- (IBAction)searchAction:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    //[MBProgressHUD showHUDAddedTo:self.view  animated:YES];
    self.ani=[[GYAnitimation alloc]init];
    [self.ani showAnimationView:self.view];
    [self registerCVCell];
    [self loadData];
    [self setBK];
}
//设置背景

- (void)setBK{
    UIImageView *im=[[UIImageView alloc]initWithFrame:self.cv.bounds];
    im.image=[UIImage imageNamed:@"背景图"];
    self.cv.backgroundView=im;
}

//请求数据
- (void)loadData{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager GET:DES_URL parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        //[MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.ani hideAnimationView];
        self.dataSource=responseObject;
        [self.cv reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

//注册cell
- (void)registerCVCell{
    
    [self.cv registerNib:[UINib nibWithNibName:@"GYCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];
    
    [self.cv registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"view"];
}
#pragma mark ---------------UICollectionView协议方法---------------
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return  self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    GYCollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic=self.dataSource[indexPath.row];
    [cell.imgV sd_setImageWithURL:[NSURL URLWithString:dic[@"bg_pic"]]];
    cell.imgV.layer.cornerRadius=5.f;
    cell.imgV.layer.masksToBounds=YES;
    cell.lb.text=dic[@"name"];
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREENWIDTH-24)/2, (SCREENWIDTH-24)/2);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 8;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    return CGSizeMake(SCREENWIDTH, 40);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *view=[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"view" forIndexPath:indexPath];
    for (UIView *view1 in view.subviews) {
        [view1 removeFromSuperview];
    }
    UILabel *la=[[UILabel alloc]initWithFrame:CGRectMake(8, 0, SCREENWIDTH, 40)];
    la.text=@"热门目的地";
    [view addSubview:la];
    return view;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     NSDictionary *dic=self.dataSource[indexPath.row];
    NSInteger ID=[dic[@"id"] integerValue];
    GYDesDetailViewController *det=[[GYDesDetailViewController alloc]init];
    det.hidesBottomBarWhenPushed=YES;
    det.ID=ID;
    UIImageView *im=[[UIImageView alloc]init];
    [im sd_setImageWithURL:[NSURL URLWithString:dic[@"bg_pic"]]];
    det.imageStr=dic[@"bg_pic"];
    det.str=dic[@"name"];
    [self.navigationController pushViewController:det animated:YES];
    
}




//懒加载
- (NSArray *)dataSource{
    if (!_dataSource) {
        _dataSource=[[NSArray alloc]init];
    }
    return _dataSource;
}

@end
