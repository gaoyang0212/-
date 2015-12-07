//
//  GYDataManager.m
//  GYTraval
//
//  Created by qianfeng on 15/11/19.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import "GYDataManager.h"
#import "GYDataModel.h"
@implementation GYDataManager

+ (instancetype)sharedDataBase{
    
    static GYDataManager *manager=nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSString *path=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingString:@"/user.da"];
//        NSLog(@"%@",path);
        manager=[[GYDataManager alloc]initWithPath:path];
        
        [manager open];
        
        NSString *sql=@"create table if not exists GYUser (ID integer primary key, ImageStr varchar(128),Title1 varchar(128),Title2 varchar(128),Title3 varchar(128),Title4 varchar(128))";
        [manager executeUpdate:sql];
    });
    
    return manager;
}

//增加
- (BOOL)addData:(GYDataModel *)model{
   NSString *sql=@"insert into GYUser (ID,ImageStr,Title1,Title2,Title3,Title4) values (?,?,?,?,?,?)";
    
    return [self executeUpdate:sql,@(model.ID),model.imStr,model.fstr,model.sstr,model.tStr,model.foStr];
}

//delete

- (BOOL)deleteData:(NSInteger)ID{
    
    NSString *sql=@"delete from GYUser where ID=?";
    return [self executeUpdate:sql,@(ID)];
}

- (NSArray *)queryData{
    NSString *sql=@"select * from GYUser";
    FMResultSet *set=[self executeQuery:sql];
    NSMutableArray *arr=[[NSMutableArray alloc]init];
    while (set.next) {
        GYDataModel *model=[[GYDataModel alloc]init];
        model.ID=[[set objectForColumnIndex:0] integerValue];
        model.imStr=[set objectForColumnIndex:1];
        model.fstr=[set objectForColumnIndex:2];
        model.sstr=[set objectForColumnIndex:3];
        model.tStr=[set objectForColumnIndex:4];
        model.foStr=[set objectForColumnIndex:5];
        [arr addObject:model];
    }
    return arr;
    
}

- (BOOL)isexist:(NSInteger)ID{
    NSString *sql=@"select * from GYUser where ID=?";
    FMResultSet *set=[self executeQuery:sql,@(ID)];
    if (set.next) {
        return YES;
    }
    return NO;
}








@end
