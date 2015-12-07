//
//  GYCell2.m
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYCell2.h"
#import "UIImageView+WebCache.h"
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
@implementation GYCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithDic:(NSDictionary *)dic{
    
    NSDictionary *dictionary=dic[@"referrer"];
    for (UIView *view in self.celView.subviews) {
        [view removeFromSuperview];
    }
    [self.headerIma sd_setImageWithURL:[NSURL URLWithString:dictionary[@"photo_url"]]];
    self.titleLb.text=dictionary[@"username"];
    self.desLb.text=dictionary[@"intro"];
    NSArray *a=dic[@"bg_pic"];
    UIImageView *imV=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH, CGRectGetHeight(self.celView.frame))];
    [imV sd_setImageWithURL:[NSURL URLWithString:a.firstObject]];
    UILabel *label1=[[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetHeight(imV.frame)-50, 200, 20)];
    label1.text=dic[@"title"];
    label1.textColor=[UIColor whiteColor];
    label1.font=[UIFont systemFontOfSize:13];
    [imV addSubview:label1];
    UILabel *label2=[[UILabel alloc]initWithFrame:CGRectMake(8, CGRectGetHeight(imV.frame)-30, 300, 20)];
    label2.text=dic[@"sub_title"];
    label2.textColor=[UIColor whiteColor];
    label2.font=[UIFont systemFontOfSize:13];
    [imV addSubview:label2];
    [self.celView addSubview:imV];
    self.headerIma.layer.cornerRadius=20;
    self.headerIma.layer.masksToBounds=YES;
    self.lastLb.text=dic[@"short_desc"];
    self.lastLb.numberOfLines=0;
    // NSString *xstr=[NSString stringWithFormat:@"%@",dic[@"like_count"]];
    self.xLb.text=[dic[@"like_count"] stringValue];
    self.dLb.text=dic[@"address"];

}

@end
