//
//  UIWindow+Extension.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/22.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "UIWindow+Extension.h"
#import "SAMainViewController.h"
#import "SANewfeatureViewController.h"

@implementation UIWindow (Extension)

- (void)switchRootViewController{
    //新特性版本号对比
    //版本标识符
    NSString *key = @"CFBundleVersion";
    //上次的使用版本（存储在沙盒中的版本号）
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //当前软件的版本号（从Info.plist中获得）
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[key];
    
    
    if ([lastVersion isEqualToString: currentVersion]) {//说明为旧版本
        self.rootViewController = [[SAMainViewController alloc]init];
    }
    else{//说明为新版本
        self.rootViewController = [[SANewfeatureViewController alloc] init];
        //将版本号存进沙盒
        [[NSUserDefaults standardUserDefaults] setObject:currentVersion forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];//立刻同步
    }

}
@end
