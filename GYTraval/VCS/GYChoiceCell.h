//
//  GYChoiceCell.h
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYChoiceCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UIView *view1;

@property(nonatomic,copy)void (^block)(NSString *strTitle,NSInteger ID);
@property (nonatomic, strong) NSTimer *timer;
- (void)cellWithDic:(NSDictionary *)dictionary;

@end
