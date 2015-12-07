//
//  GYNextStopViewController.h
//  GYTraval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYBaseViewController.h"

@interface GYNextStopViewController : GYBaseViewController
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
- (IBAction)shareAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property(nonatomic,copy)NSString * titleStr;
@property(nonatomic,assign)NSInteger ID;

@property(nonatomic,strong)UIImage * imag;

@end
