//
//  User.m
//  HealthyFood
//
//  Created by qianfeng on 15/11/27.
//  Copyright © 2015年 HZF. All rights reserved.
//

#import "User.h"

@implementation User
+ (instancetype)currentUser {
    static User *_user = nil;
    if (!_user) {
        _user = [[User alloc] init];
    }
    
    return _user;
}

//接档
- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init]) {
        self.userName = [aDecoder decodeObjectForKey:@"username"];
        self.password = [aDecoder decodeObjectForKey:@"password"];
    }
    
    return self;
}

//归档

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.userName forKey:@"username"];
    [aCoder encodeObject:self.password forKey:@"password"];
}




- (NSString *)path {
    NSString *p = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).lastObject;
    p = [p stringByAppendingString:@"/user.src"];
    
    return p;
}

//
- (void)encodeUser:(User *)user {
    [NSKeyedArchiver archiveRootObject:user toFile:[self path]];
}

//
- (User *)decodeUser {
    return [NSKeyedUnarchiver unarchiveObjectWithFile:[self path]];
}

@end
