//
//  GYInterest.h
//  GYTraval
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "JSONModel.h"

@interface GYInterest : JSONModel

@property(nonatomic,copy)NSString * name;

@property(nonatomic,copy)NSString* icon;

@property(nonatomic,copy)NSString<Optional>* ID;

@end
