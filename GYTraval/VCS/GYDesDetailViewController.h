//
//  GYDesDetailViewController.h
//  GYTraval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYBaseViewController.h"

@interface GYDesDetailViewController : GYBaseViewController
- (IBAction)backAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITableView *tv;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,copy) NSString *imageStr;
@property(nonatomic,copy)NSString  *str;


@end
