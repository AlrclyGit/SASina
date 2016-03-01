//
//  AppDelegate.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/16.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "AppDelegate.h"
#import "SAOAuthViewController.h"
#import "SAAccountTool.h"
#import "SDWebImageManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //1.创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    
    //2.显示窗口
    [self.window makeKeyAndVisible];
    
    //3.设置根控制器
    
    //判断授权是否过期，没过期返回SAACCount，过期返回Nil.
    //判断是否授权过，没授权过SAACCount为空，授权过SAACCount有值
    SAAccount *account = [SAAccountTool account];
    
    if (account) {//说明之前已经登录成功过
        [self.window switchRootViewController];
    }
    else{//说明之前已经末登入过
        self.window.rootViewController = [[SAOAuthViewController alloc]init];
    }

    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



/**
 * 当APP进入后台时调用
 */
- (void)applicationDidEnterBackground:(UIApplication *)application {
    //在Info.plst中设置后台模式：Required background modes = App plays audio or streams audio/video using AirPlay
    //搞一个0kb的MP3文件，没有声音
    //循环播放
    
    
    //向操作系统申请后台运行的资格，能维持多久，是不确定的
    __block UIBackgroundTaskIdentifier task =  [application beginBackgroundTaskWithExpirationHandler:^{
        //当申请的后台运行时间已经结束（过期），就会调用这个Block
        
        //赶紧结束任务
        [application endBackgroundTask:task];
    }];
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

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application{
    SDWebImageManager *mgr = [SDWebImageManager sharedManager];
    //1.取消下载
    [mgr cancelAll];
    //2.消除内存中的所有图片
    [mgr.imageCache clearMemory];
}

@end
