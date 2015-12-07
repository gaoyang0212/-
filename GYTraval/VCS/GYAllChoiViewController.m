//
//  GYAllChoiViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYAllChoiViewController.h"

@interface GYAllChoiViewController ()
@property (weak, nonatomic) IBOutlet UILabel *ttitleLb;

@end

@implementation GYAllChoiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.ttitleLb.text=self.strName;
}

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
