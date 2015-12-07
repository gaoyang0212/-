//
//  GYCeoCell.h
//  GYTraval
//
//  Created by qianfeng on 15/11/19.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYCeoCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *fLb;
@property (weak, nonatomic) IBOutlet UILabel *sLb;
@property (weak, nonatomic) IBOutlet UILabel *tLb;

@property (weak, nonatomic) IBOutlet UILabel *fouLb;
@end
