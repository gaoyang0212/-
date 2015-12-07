//
//  GYDESDETACell.m
//  GYTraval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYDESDETACell.h"
#import "GYDescDetailModel.h"
#import "UIImageView+WebCache.h"
@implementation GYDESDETACell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(GYDescDetailModel *)model{
    _model=model;
    [self.headerIm sd_setImageWithURL:[NSURL URLWithString:model.bg_pic.firstObject]];
    self.headerIm.layer.cornerRadius=5.f;
    self.headerIm.layer.masksToBounds=YES;
    self.fLb.text=model.title;
    self.sLb.text=model.sub_title;
    self.tLb.text=model.address;
    
}


@end
