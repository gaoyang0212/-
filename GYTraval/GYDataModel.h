//
//  GYDataModel.h
//  GYTraval
//
//  Created by qianfeng on 15/11/19.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GYDataModel : NSObject
@property(nonatomic,assign)NSInteger ID;

@property(nonatomic,copy)NSString * imStr;

@property(nonatomic,copy)NSString * fstr;

@property(nonatomic,copy)NSString * sstr;
@property(nonatomic,assign)BOOL login;
@property(nonatomic,copy)NSString * tStr;
@property(nonatomic,copy)NSString * foStr;






+(instancetype)shared;

- (instancetype)initDic:(NSDictionary *)dic;

@end
