//
//  DetailModel.h
//  GYTraval
//
//  Created by qianfeng on 15/11/11.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface DetailModel : JSONModel
@property(nonatomic,copy)NSArray * bg_pic;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * sub_title;
@property(nonatomic,copy)NSString * destination;
@property(nonatomic,copy)NSString * start_date;
@property(nonatomic,copy)NSString * end_date;
@property(nonatomic,assign)NSInteger  like_count;
@property(nonatomic,copy)NSString<Optional> * short_desc;
@end
