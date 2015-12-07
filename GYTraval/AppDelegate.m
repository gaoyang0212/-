//
//  AppDelegate.m
//  GYTraval
//
//  Created by qianfeng on 15/11/9.
//  Copyright (c) 2015年 qianfeng. All rights reserved.
//

#import "AppDelegate.h"
#import "GYChoiceViewController.h"
#import "GYFindViewController.h"
#import "GYdestinationViewController.h"
#import "GYMineViewController.h"
#import "GYTab.h"
#import "GYCollectViewController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "UMSocialWechatHandler.h"
#import "User.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self createWindow];
    [self setNav];
    [self createTab];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self createUM];
    return YES;
   
}

//友盟分享初始化
- (void)createUM{
    //友盟分享的初始化
    [UMSocialData setAppKey:@"565bee0767e58eb178001a72"];
    
    //设置微信AppId，设置分享url，默认使用友盟的网址
    [UMSocialWechatHandler setWXAppId:@"wxe6b5b748cdcff60f" appSecret:@"d4624c36b6795d1d99dcf0547af5443d" url:@"http://www.umeng.com/social"];
    
    //设置分享到QQ空间的应用Id，和分享url 链接
//    [UMSocialQQHandler setQQWithAppId:@"1104908293" appKey:@"MnGtpPN5AiB6MNvj" url:@"http://www.umeng.com/social"];
    
    //对未安装客户端平台进行隐藏，在设置QQ、微信AppID之后调用下面的方法，
    [UMSocialConfig hiddenNotInstallPlatforms:@[UMShareToQQ,UMShareToQzone,UMShareToWechatSession,UMShareToWechatTimeline]];

}


- (void)createWindow{
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    
    self.window.backgroundColor=[UIColor whiteColor];
    
    [self.window makeKeyAndVisible];

}

- (void)setNav{
    
    UINavigationBar *bar=[UINavigationBar appearance];
    
    bar.barStyle=UIBarStyleBlack;
    
    bar.barTintColor=[UIColor whiteColor];
}

- (void)createTab{
    
    GYTab *tab=[[GYTab alloc]init];
    
    //精选
    GYChoiceViewController *choice=[[GYChoiceViewController alloc]init];
    choice.title=@"出去旅行";
    [tab addViewController:choice Title:@"精选" ImageN:@"tabbar_item_home" ImageS:@"tabbar_item_home_sel"];
    
    
    //发现
    GYFindViewController *find=[[GYFindViewController alloc]init];
    [tab addViewController:find Title:@"发现" ImageN:@"tabbar_item_discover" ImageS:@"tabbar_item_discover_sel"];
    
    //目的地
    GYdestinationViewController *des=[[GYdestinationViewController alloc]init];
    [tab addViewController:des Title:@"目的地" ImageN:@"tabbar_item_des@2x" ImageS:@"tabbar_item_des_sel"];
    
    //我的
    
    GYMineViewController *mine=[[GYMineViewController alloc]init];
    User *user=[[User currentUser] decodeUser];
    
    if (user) {
        GYCollectViewController *collect=[[GYCollectViewController alloc]init];
        collect.text=user.userName;
        [tab addViewController:collect Title:@"我的" ImageN:@"tabbar_item_my" ImageS:@"tabbar_item_my_sel"];
        [[User currentUser] encodeUser:user];
    }
    else{
    
    [tab addViewController:mine Title:@"我的" ImageN:@"tabbar_item_my" ImageS:@"tabbar_item_my_sel"];
    }
    
    tab.tabBar.tintColor=[UIColor redColor];
    
    self.window.rootViewController=tab;
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
