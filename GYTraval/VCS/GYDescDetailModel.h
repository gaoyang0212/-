//
//  GYDescDetailModel.h
//  GYTraval
//
//  Created by qianfeng on 15/11/13.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface GYDescDetailModel : JSONModel

@property(nonatomic,strong )NSArray *bg_pic;

@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * sub_title;
@property(nonatomic,copy)NSString * address;

@end
