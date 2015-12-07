//
//  GYMapViewController.h
//  GYTraval
//
//  Created by qianfeng on 15/11/29.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
@interface GYMapViewController : UIViewController
{
    
    
    /**s声明地图变量**/
    MAMapView *_mapView;
    
    
}
@property(nonatomic,strong) NSArray *array;

@end
