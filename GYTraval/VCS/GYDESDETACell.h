//
//  GYDESDETACell.h
//  GYTraval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GYDescDetailModel;
@interface GYDESDETACell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerIm;

@property (weak, nonatomic) IBOutlet UILabel *fLb;

@property (weak, nonatomic) IBOutlet UILabel *sLb;

@property (weak, nonatomic) IBOutlet UILabel *tLb;
@property(nonatomic,strong)GYDescDetailModel * model;

@end
