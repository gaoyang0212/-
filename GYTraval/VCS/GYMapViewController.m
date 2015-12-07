//
//  GYMapViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYMapViewController.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
@interface GYMapViewController ()<MAMapViewDelegate>

@end

@implementation GYMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showMapView];
    
    [self mapBasicHandle];
    [self annotaionView];
    
    [self maplocation];
    NSLog(@"%@",self.array);
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 64)];
    view.backgroundColor=[UIColor orangeColor];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(5, 25, 50, 40);
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:btn];
    [self.view addSubview:view];
}

- (void)btnAction{
    [self.navigationController popViewControllerAnimated:YES];
}
/**地图定位*/
-(void)maplocation
{
    //开启地图定位
    _mapView.showsUserLocation=YES;
    
}

//显示地图
-(void)showMapView
{
    
    [MAMapServices sharedServices].apiKey=@"fab62c08e420514413eaedf099fa23ed";
    
    //创建地图
    _mapView=[[MAMapView alloc]initWithFrame:CGRectMake(0, 64,SCREENWIDTH, SCREENHEIGHT-64)];
    
    //设置地图的回调
    _mapView.delegate=self;
    
    //将地图添加到仕途上
    [self.view addSubview:_mapView];
    
    
}

/**地图操作*/
-(void)mapBasicHandle
{
    
    //设置地图的齿合度 官方为3--19  实际为0--21
    [_mapView setZoomLevel:10];
    
    
    //设置地图显示的中心点位置
    //CLLocationCoordinate2D location=CLLocationCoordinate2DMake(39.989631, 116.481018);
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(39.989631, 116.481018);
    [_mapView setCenterCoordinate:location];
    
    
}
/**地图上的大头针  覆盖物的使用*/
-(void)annotaionView
{
    //向地图中添加覆盖物
    
    MAPointAnnotation *point=[[MAPointAnnotation alloc]init];
    //设置覆盖物的经纬度
    point.coordinate=CLLocationCoordinate2DMake(39.989631, 116.481018);
    //设置覆盖物的标题与副标题
    
    point.title=@"终点在这里";
    //
    point.subtitle=@"haha";
    
    //将覆盖物添加到地图
    
    [_mapView addAnnotation:point];
}
/** 当向地图中添加覆盖物是 调用该方法 需要在这个方法中制定覆盖物的类型   协议方法*/
- (MAAnnotationView*)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    
    static NSString *str=@"annID";
    
    //在服用队列中获得大头针
    MAPinAnnotationView *pins=(MAPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:str];
    if(!pins)
    {
        pins=[[MAPinAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:str];
    }
    
    //设置大头针允许拖拽
    pins.draggable=YES;
    //    //设置大头针允许显示气泡
    pins.canShowCallout=YES;
    //    //设置大头针插入动画
    pins.animatesDrop=YES;
    //    //设置pin颜色
    //    pin.pinColor=MAPinAnnotationColorGreen;
    
    /**用图片自定制大头针*/
    pins.image=[UIImage imageNamed:@"marker_inside_pink"];
    CGRect frame=pins.frame;
    frame.size=CGSizeMake(50, 50);
    pins.frame=frame;
    return pins;
    
}

@end
