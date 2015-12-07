//
//  GYDetail3Cell.h
//  GYTraval
//
//  Created by qianfeng on 15/11/14.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYDetail3Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fLb;

@property (weak, nonatomic) IBOutlet UILabel *sLb;

@property(nonatomic,copy)void(^block)(void);

@end
