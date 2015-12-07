//
//  GYDataModel.m
//  GYTraval
//
//  Created by qianfeng on 15/11/19.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYDataModel.h"

@implementation GYDataModel
+ (instancetype)shared{
    static GYDataModel *model=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        model=[[GYDataModel alloc]init];
        
    });
    return model;
}


- (instancetype)initDic:(NSDictionary *)dic{
    if (self=[super init]) {
        self.ID=[dic[@"id"] integerValue];
        self.imStr=[dic[@"bg_pic"] firstObject];
        self.fstr=dic[@"title"];
        self.sstr=dic[@"sub_title"];
        self.tStr=dic[@"destination"];
        NSString *string1=[dic[@"start_date"] substringWithRange:NSMakeRange(5, 2)];
        NSString *string2=[dic[@"start_date"] substringWithRange:NSMakeRange(8, 2)];
        NSString *string3=[dic[@"end_date"] substringWithRange:NSMakeRange(5, 2)];
        NSString *string4=[dic[@"end_date"]  substringWithRange:NSMakeRange(8, 2)];
        self.foStr=[NSString stringWithFormat:@"%@月%@日-%@月%@日",string1,string2,string3,string4];
    }
    return self;
}
@end
