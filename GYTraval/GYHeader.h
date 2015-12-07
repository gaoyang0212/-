//
//  GYHeader.h
//  GYTraval
//
//  Created by qianfeng on 15/11/10.
//  Copyright © 2015年 qianfeng. All rights reserved.
//

#ifndef GYHeader_h
#define GYHeader_h

//屏幕宽度  高度
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height

//精选接口
#define CHOICE @"http://appsrv.flyxer.com/api/digest/main?did=30113&qid=0&v=2&page=%ld"
#define CHOICE_URL(page) [NSString stringWithFormat:CHOICE,page]

//第一种cell接口
#define DETAIL @"http://appsrv.flyxer.com/api/digest/collection/%@=2&page=1"
#define DETAILM_URL(i) [NSString stringWithFormat:DETAIL,i]

//发现接口
#define FINDURL @"http://appsrv.flyxer.com/api/digest/discovery?did=30113"

//广告栏接口
#define ARTICLE @"http://appsrv.flyxer.com/api/digest/article/%ld"
#define ARTICLE_URL(i) [NSString stringWithFormat:ARTICLE,i]

//我的兴趣接口
#define   INTERURL @"http://appsrv.flyxer.com/api/digest/recomm/tag/%ld?did=30113&v=2&page=1"
#define INTER_URL(ID) [NSString stringWithFormat:INTERURL,ID]

//我的兴趣第一种cell
//同精选第一种cell接口

//下一站接口
#define NEXT @"http://appsrv.flyxer.com/api/digest/article/%ld"
#define NEXT_URL(ID) [NSString stringWithFormat:NEXT,ID]


//目的地接口
#define DES_URL @"http://appsrv.flyxer.com/api/digest/recomm/dests?page=1"

//目的地详情接口
#define DESDETAIL @"http://appsrv.flyxer.com/api/digest/recomm/dest/%ld?v=2&page=%ld"
#define DESDETAIL_URL(ID,page) [NSString stringWithFormat:DESDETAIL,ID,page]



#endif /* GYHeader_h */
