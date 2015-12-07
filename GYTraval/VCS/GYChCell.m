//
//  GYChCell.m
//  GYTraval
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYChCell.h"
#import "UIImageView+WebCache.h"
@implementation GYChCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)cellWithDic:(NSDictionary *)d{
    NSArray *a=d[@"bg_pic"];
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:a.firstObject]];
    self.imageV.layer.cornerRadius=5.f;
    self.imageV.layer.masksToBounds=YES;
    self.lb.text=d[@"title"];
}

@end
