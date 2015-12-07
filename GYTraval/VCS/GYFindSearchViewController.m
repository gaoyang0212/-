//
//  GYFindSearchViewController.m
//  GYTraval
//
//  Created by qianfeng on 15/11/16.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYFindSearchViewController.h"

@interface GYFindSearchViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *seachBar;

@property (strong, nonatomic) IBOutlet UISearchDisplayController *searchDisplay;
@end

@implementation GYFindSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   self.searchDisplay=[[UISearchDisplayController alloc] initWithSearchBar:self.seachBar contentsController:self];
    
}
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


@end
