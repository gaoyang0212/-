//
//  GYHotCell.m
//  GYTraval
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYHotCell.h"
#import "UIImageView+WebCache.h"
@implementation GYHotCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithDic:(NSDictionary *)d{
    NSDictionary *dic=d[@"selection"];
    [self.headerImg sd_setImageWithURL:[NSURL URLWithString:dic[@"bg_pic"]]];
    self.headerImg.layer.cornerRadius=5.f;
    self.headerImg.layer.masksToBounds=YES;
    self.fLb.text=[NSString stringWithFormat:@"%@%%",d[@"hotness"]];
    self.fLb.textColor=[UIColor redColor];
    self.sLb.text=[NSString stringWithFormat:@"%@-%@",dic[@"title"],dic[@"sub_title"]];

}

@end
