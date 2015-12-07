//
//  GYAnitimation.m
//  GYTraval
//
//  Created by qianfeng on 15/11/15.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYAnitimation.h"
#import "GYHeader.h"
@implementation GYAnitimation

- (void)showAnimationView:(UIView *)view{
    
    NSMutableArray *imArr=[[NSMutableArray alloc]init];
    for (int i=0; i<22; i++) {
        
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"deeplink_%d",i+1]];
        [imArr addObject:image];
    }
    self.animationImages=imArr;
    self.animationRepeatCount = 0;
    self.animationDuration=1.5;
    self.frame=CGRectMake(SCREENWIDTH/2-100, SCREENHEIGHT/2-35, 200, 70);
    [view addSubview:self];
    [self startAnimating];
}

- (void)hideAnimationView{
    [self stopAnimating];
}
- (void)showAnimationViewS:(UIView *)view{
    
    NSMutableArray *imArr=[[NSMutableArray alloc]init];
    for (int i=0; i<10; i++) {
        
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"icon_ci_infotab_b_%d0",i+1]];
        [imArr addObject:image];
    }
    self.animationImages=imArr;
    self.animationRepeatCount = 0;
    self.animationDuration=1.5;
    self.frame=CGRectMake(SCREENWIDTH/2-35, SCREENHEIGHT/2-35, 70, 70);
    [view addSubview:self];
    [self startAnimating];
}

- (void)hideAnimationViewS{
    [self stopAnimating];
}
-(void)showAnimationViewT:(UIView *)view{
    NSMutableArray *imArr=[[NSMutableArray alloc]init];
    for (int i=0; i<12; i++) {
        
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"sprites_anim%d",i]];
        [imArr addObject:image];
    }
    self.animationImages=imArr;
    self.animationRepeatCount = 0;
    self.animationDuration=1.5;
    self.frame=CGRectMake(SCREENWIDTH/2-25, SCREENHEIGHT-50, 50, 50);
    [view addSubview:self];
    [self startAnimating];

}
-(void)showAnimationViewF:(UIView *)view{
    NSMutableArray *imArr=[[NSMutableArray alloc]init];
    for (int i=0; i<4; i++) {
        
        UIImage *image=[UIImage imageNamed:[NSString stringWithFormat:@"loading%d",i+1]];
        [imArr addObject:image];
    }
    self.animationImages=imArr;
    self.animationRepeatCount = 0;
    self.animationDuration=1.5;
    self.frame=CGRectMake(SCREENWIDTH/2-35, SCREENHEIGHT/2-35, 70, 70);
    [view addSubview:self];
    [self startAnimating];
    
}
@end
