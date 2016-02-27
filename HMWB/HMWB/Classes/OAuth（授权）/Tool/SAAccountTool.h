//
//  SAAccountTool.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/22.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  处理账号相关的所有操作：存储账号、取出账号、

#import <Foundation/Foundation.h>
#import "SAAccount.h"

@class  SAAccount;

@interface SAAccountTool : NSObject

//存储账号信息
+ (void)saveAccount:(SAAccount *)accout;

//返回账号信息，OAuth是否已经授权（如果过期返回nil）
+ (SAAccount *)account;
@end
