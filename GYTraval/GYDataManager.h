//
//  GYDataManager.h
//  GYTraval
//
//  Created by qianfeng on 15/11/19.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "FMDatabase.h"
@class GYDataModel;
@interface GYDataManager : FMDatabase

+ (instancetype)sharedDataBase;

- (BOOL)addData:(GYDataModel *)model;

- (BOOL)deleteData:(NSInteger)ID;

- (NSArray *)queryData;
- (BOOL)isexist:(NSInteger )ID;
@end
