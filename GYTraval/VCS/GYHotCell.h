//
//  GYHotCell.h
//  GYTraval
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYHotCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImg;

@property (weak, nonatomic) IBOutlet UILabel *fLb;


@property (weak, nonatomic) IBOutlet UILabel *sLb;


@property (weak, nonatomic) IBOutlet UIImageView *hotImg;


- (void)cellWithDic:(NSDictionary *)d;


@end
