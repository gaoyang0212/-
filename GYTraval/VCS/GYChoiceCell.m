//
//  GYChoiceCell.m
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYChoiceCell.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define baseTag 998
#import "UIImageView+WebCache.h"
@interface GYChoiceCell ()<UIScrollViewDelegate>
{
    UIScrollView *_scrol;
    
    NSArray *_arr;
   
    NSString *_sName;
}

@end

@implementation GYChoiceCell

- (void)awakeFromNib {
    // Initialization code
     [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.5]];
    [[NSNotificationCenter defaultCenter] addObserverForName:@"viewDisAppear" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        
        [self.timer setFireDate:[NSDate distantFuture]];
//      NSLog(@"计时器关闭");
    }];

    [[NSNotificationCenter defaultCenter] addObserverForName:@"viewAppear" object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        ///////////////////////////////////////设置成延时好像好使了
        if (_arr.count>1) {
//          NSLog(@"计时器开启");
            [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.5]];
        }
        
    }];

    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)cellWithDic:(NSDictionary *)dictionary{

    
    
    for (UIView *view in self.view1.subviews) {
        [view removeFromSuperview];
    }
    _scrol=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 200)];
    _scrol.delegate=self;
    _scrol.bounces=NO;
    
    NSArray *ar=dictionary[@"collections"];
    _arr=ar;
        for (int i=0; i<ar.count; i++) {
        UIImageView *imV=[[UIImageView alloc]initWithFrame:CGRectMake(i*SCREENWIDTH, 0, SCREENWIDTH, CGRectGetHeight(_scrol.frame))];
        
        NSDictionary *d=ar[i];
        NSInteger ID=[d[@"id"] integerValue];
        NSString *str=[d[@"bg_pic"] firstObject];
        [imV sd_setImageWithURL:[NSURL URLWithString:str]];
        [_scrol addSubview:imV];
        UILabel *Tlabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-100, _scrol.frame.size.height/2-30, 200, 30)];
        Tlabel.text=d[@"title"];
        imV.tag=baseTag +ID;
        Tlabel.tag=imV.tag+baseTag;
        _sName=d[@"title"];
        Tlabel.textAlignment=NSTextAlignmentCenter;
        Tlabel.font=[UIFont systemFontOfSize:19];
        Tlabel.textColor=[UIColor whiteColor];
        [imV addSubview:Tlabel];
        UILabel *Slabel=[[UILabel alloc]initWithFrame:CGRectMake(SCREENWIDTH/2-100,_scrol.frame.size.height/2, 200, 20)];
        Slabel.text=d[@"sub_title"];
        Slabel.textColor=[UIColor whiteColor];
        Slabel.textAlignment=NSTextAlignmentCenter;
        Slabel.font=[UIFont systemFontOfSize:16];
        [imV addSubview:Slabel];
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        imV.userInteractionEnabled=YES;
        [imV addGestureRecognizer:tap];
        _scrol.contentSize=CGSizeMake(CGRectGetMaxX(imV.frame), 0);
    }
      [self.view1 addSubview:_scrol];
    _scrol.showsHorizontalScrollIndicator=NO;
    
    _scrol.pagingEnabled=YES;
    

}

- (void)timerAction{
    
    [_scrol setContentOffset:CGPointMake(_scrol.contentOffset.x+SCREENWIDTH, 0) animated:YES];

    
    if (_scrol.contentOffset.x==SCREENWIDTH*(_arr.count-1)) {
        [_scrol setContentOffset:CGPointZero animated:YES];
    }

}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
        [self.timer setFireDate:[NSDate distantFuture]];
    
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    
        [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:2.5]];
}


- (void)tapAction:(UITapGestureRecognizer *)tap{
    
    UILabel *label=(UILabel *)[tap.view viewWithTag:tap.view.tag+baseTag];
    NSString *strName=label.text;
    NSInteger ID=tap.view.tag-baseTag;
    NSString *strID=[NSString stringWithFormat:@"%ld",ID];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"cellNoti" object:nil userInfo:@{@"q":strName,@"w":strID}];
    
}

//懒加载
- (NSTimer *)timer {
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:2.5 target:self selector:@selector(timerAction) userInfo:nil repeats:YES];
        [_timer setFireDate:[NSDate distantFuture]];
    }
    return _timer;
}

@end
