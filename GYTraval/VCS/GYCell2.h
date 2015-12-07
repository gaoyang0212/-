//
//  GYCell2.h
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYCell2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerIma;


@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@property (weak, nonatomic) IBOutlet UILabel *desLb;

@property (weak, nonatomic) IBOutlet UIView *celView;



@property (weak, nonatomic) IBOutlet UILabel *lastLb;

@property (weak, nonatomic) IBOutlet UILabel *xLb;


@property (weak, nonatomic) IBOutlet UILabel *dLb;

- (void)cellWithDic:(NSDictionary *)dic;








@end
