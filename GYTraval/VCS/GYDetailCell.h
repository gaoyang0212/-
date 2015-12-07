//
//  GYDetailCell.h
//  GYTraval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DetailModel;
@interface GYDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (weak, nonatomic) IBOutlet UILabel *fLb;

@property (weak, nonatomic) IBOutlet UILabel *sLb;

@property (weak, nonatomic) IBOutlet UILabel *tLb;


@property (weak, nonatomic) IBOutlet UILabel *fouLb;

@property (weak, nonatomic) IBOutlet UILabel *friLb;

@property(nonatomic,strong)DetailModel * model;

@property (weak, nonatomic) IBOutlet UIImageView *rightIm;
@property (weak, nonatomic) IBOutlet UILabel *smallLb;

@property (weak, nonatomic) IBOutlet UIImageView *smallIm;




@end
