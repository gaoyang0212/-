//
//  GYDetail3Cell.m
//  GYTraval
//
//  Created by qianfeng on 15/11/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYDetail3Cell.h"

@implementation GYDetail3Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//地图
- (IBAction)mapsAction:(id)sender {
    self.block();
    
}

@end
