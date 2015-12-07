//
//  GYView.m
//  GYTraval
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYView.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "GYHeader.h"
@interface GYView ()<UIScrollViewDelegate>
@property (nonatomic, strong)UIScrollView *scrollView;
@property (nonatomic, strong)NSTimer *timer;
@property (nonatomic, strong)NSArray *array;
@end

@implementation GYView
- (instancetype)initHeaderView:(NSString *)urlStr And:(NSInteger)index{
    
    
    if (self=[super init]) {
        
        
        
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary *dic=responseObject[index];
            [self createHeader:dic];
            if (self.array.count>1) {
//               NSLog(@"计时器开启");
                 [self.timer  setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.5]];
            }
            [[NSNotificationCenter defaultCenter] addObserverForName:@"timer" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
                [self.timer invalidate];
            }];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
        }];
        
}
    
    return self;

}

- (void)createHeader:(NSDictionary *)dic{
     float width= (SCREENWIDTH-40-30)/6.f;
     NSArray *imArr=dic[@"bg_pic"];
    self.array=imArr;
    UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 190+width)];
    [self addSubview:view];
    
    self.scrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREENWIDTH , 180)];
    UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(self.scrollView.frame)-50, SCREENWIDTH, 20)];
    lb.text=dic[@"title"];
    lb.textColor=[UIColor whiteColor];
    lb.font=[UIFont systemFontOfSize:15];
    UILabel *lb2=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetHeight(self.scrollView.frame)-25, SCREENWIDTH, 20)];
    lb2.text=dic[@"sub_title"];
    lb2.textColor=[UIColor whiteColor];
    lb2.font=[UIFont systemFontOfSize:13];
    if (imArr.count==1) {
         UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 180)];
        [im sd_setImageWithURL:[NSURL URLWithString:imArr.firstObject]];
        [view addSubview:im];
    }
    else{
    for (int i=0; i<imArr.count+2; i++) {
        UIImageView *im=[[UIImageView alloc]initWithFrame:CGRectMake(i*SCREENWIDTH, 0, SCREENWIDTH, 180)];
        if (i==0) {
            [im sd_setImageWithURL:[NSURL URLWithString:imArr[imArr.count-1]]];
        }
        else if (i==imArr.count+1){
            [im sd_setImageWithURL:[NSURL URLWithString:imArr[0]]];
        }
        else{
            [im sd_setImageWithURL:[NSURL URLWithString:imArr[i-1]]];
        }
        
        [self.scrollView addSubview:im];
        
        self.scrollView.contentSize=CGSizeMake(CGRectGetMaxX(im.frame),0 );
       }
        [view addSubview:self.scrollView];
        self.scrollView.delegate=self;
        self.scrollView.showsHorizontalScrollIndicator=NO;
        self.scrollView.pagingEnabled=YES;
        self.scrollView.contentOffset=CGPointMake(SCREENWIDTH, 0);
    }
    
    [view addSubview:lb];
    [view addSubview:lb2];
    
    UIView *smallView=[[UIView alloc]initWithFrame:CGRectMake(0, 180, SCREENWIDTH, width)];
    [view addSubview:smallView];

    UIImageView *imageView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 40, 40)];
    
    imageView.image=[UIImage imageNamed:@"activity_btnUnLike_red"];
    [smallView addSubview:imageView];
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(5, 30, 30, 20)];
    label.text=[dic[@"like_count"] stringValue];
    label.font=[UIFont systemFontOfSize:13];
    label.textAlignment=NSTextAlignmentCenter;
    [smallView addSubview:label];
    
    NSArray *arr=dic[@"like_user"];
   
    if (arr.count>5) {
        for (int i=0; i<6; i++) {
            NSDictionary *dicto=arr[i];
            
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(40+(5+width)*i, 5, width, width)];
            imageV.layer.cornerRadius=width/2;
            imageV.layer.masksToBounds=YES;
            if (i==5) {
                imageV.image=[UIImage imageNamed:@"activity_moreP"];
            }
            else{
            [imageV sd_setImageWithURL:[NSURL URLWithString:dicto[@"avatar"]]];
            }
            [smallView addSubview:imageV];
            
        }
    }
    else{
        for (int i=0; i<arr.count; i++) {
            NSDictionary *dicto=arr[i];
            UIImageView *imageV=[[UIImageView alloc]initWithFrame:CGRectMake(40+(5+width)*i, 5, width, width)];
            imageV.layer.cornerRadius=width/2;
            imageV.layer.masksToBounds=YES;
                [imageV sd_setImageWithURL:[NSURL URLWithString:dicto[@"avatar"]]];
               [smallView addSubview:imageV];
            
        }

        
    }
}


- (void)timerAction{
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x+SCREENWIDTH, 0) animated:YES];
    if (self.scrollView.contentOffset.x/SCREENWIDTH==0) {
        self.scrollView.contentOffset=CGPointMake(SCREENWIDTH*self.array.count, 0);
    }
    if (self.scrollView.contentOffset.x/SCREENWIDTH==self.array.count+1) {
        self.scrollView.contentOffset=CGPointMake(SCREENWIDTH, 0);
    }
}


- (NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}









@end
