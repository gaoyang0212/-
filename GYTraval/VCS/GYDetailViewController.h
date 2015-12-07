//
//  GYDetailViewController.h
//  GYTraval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYDetailViewController : UIViewController

@property(nonatomic,copy)NSString * string;

@property(nonatomic,copy)NSString * strName;

@property (weak, nonatomic) IBOutlet UILabel *titleLb;

@end
