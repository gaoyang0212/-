//
//  GYView.h
//  GYTraval
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GYView : UIView

- (instancetype)initHeaderView:(NSString *)urlStr And:(NSInteger )index;
- (void)createHeader:(NSDictionary *)dic;
@end
