//
//  GYTab.m
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYTab.h"

@interface GYTab ()

@end

@implementation GYTab

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)addViewController:(UIViewController *)vc Title:(NSString *)title ImageN:(NSString *)imageNormal ImageS:(NSString *)imageSele{
    vc.title=title;
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:vc];
    
    UIImage *imagen=[UIImage imageNamed:imageNormal];
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0) {
        imagen=[imagen imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UIImage *images=[UIImage imageNamed:imageSele];
    if ([UIDevice currentDevice].systemVersion.floatValue>=7.0) {
        images=[images imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    
    nav.tabBarItem=[[UITabBarItem alloc]initWithTitle:title image:imagen selectedImage:images];
    //nav.navigationBar.backgroundColor=[UIColor redColor];
    
    [self addChildViewController:nav];
    
    
}
@end
