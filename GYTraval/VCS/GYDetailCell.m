//
//  GYDetailCell.m
//  GYTraval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYDetailCell.h"
#import "DetailModel.h"
#import "UIImageView+WebCache.h"
@implementation GYDetailCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setModel:(DetailModel *)model{
    
    _model=model;
    NSString *str=model.bg_pic.firstObject;
    [self.headerImage sd_setImageWithURL:[NSURL URLWithString:str]];
    self.fLb.text=model.title;
    self.sLb.text=model.sub_title;
    self.tLb.text=model.destination;
    NSString *string1=[model.start_date substringWithRange:NSMakeRange(5, 2)];
    NSString *string2=[model.start_date substringWithRange:NSMakeRange(8, 2)];
    NSString *string3=[model.end_date substringWithRange:NSMakeRange(5, 2)];
    NSString *string4=[model.end_date substringWithRange:NSMakeRange(8, 2)];
    self.fouLb.text=[NSString stringWithFormat:@"%@月%@日-%@月%@日",string1,string2,string3,string4];
    self.friLb.text=model.short_desc;
}

@end
