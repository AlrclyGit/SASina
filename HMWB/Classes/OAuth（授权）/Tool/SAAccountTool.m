//
//  SAAccountTool.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/22.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

 //账号的存取路径
#define SAAccountPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

#import "SAAccountTool.h"

@implementation SAAccountTool

//存储账号信息
+ (void)saveAccount:(SAAccount *)accout{
    //自定义对象的存储必须用NSKeyedArchiver，不再用什么writeToFile方法
    [NSKeyedArchiver archiveRootObject:accout toFile:SAAccountPath];
}

//返回账号信息，OAuth是否已经授权（如果过期返回nil）
+ (SAAccount *)account{
    //取出文件
    SAAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:SAAccountPath];
    //过期的秒数
    long long expires_in = [account.expires_in longLongValue];
    //获得过期时间,时间再加的方法
    NSDate * expiresTiem = [account.created_time dateByAddingTimeInterval:expires_in];
    //获得当前时间
    NSDate *now = [NSDate date];
    //如果expiresTime <= now ,过期,时间比较方法
    NSComparisonResult result = [expiresTiem compare:now];
    if (result != NSOrderedDescending) {//过期
         return nil;
    }
    return account;
   
}
@end
