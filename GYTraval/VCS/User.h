//
//  User.h
//  HealthyFood
//
//  Created by qianfeng on 15/11/27.
//  Copyright © 2015年 HZF. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property(nonatomic,copy)NSString * userName;
@property(nonatomic,copy)NSString * password;
+ (instancetype)currentUser;
- (void)encodeUser:(User *)user;
- (User *)decodeUser;
@end
