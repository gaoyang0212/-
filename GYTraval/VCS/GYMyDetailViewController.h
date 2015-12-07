//
//  GYMyDetailViewController.h
//  GYTraval
//
//  Created by qianfeng on 15/11/17.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYBaseViewController.h"

@interface GYMyDetailViewController : GYBaseViewController
- (IBAction)backAction:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property(nonatomic,copy)NSString * string;

@property(nonatomic,copy)NSString * strName;


@end
