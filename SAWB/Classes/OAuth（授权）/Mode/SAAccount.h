//
//  SAAccount.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/22.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAAccount : NSObject <NSCoding>

/**　string	用于调用access_token，接口获取授权后的access token。*/
@property (nonatomic, copy) NSString *access_token;

/**　string	access_token的生命周期，单位是秒数。*/
@property (nonatomic, copy) NSNumber *expires_in;

/**　string	access_token的生命周期(作废），单位是秒数。*/
@property (nonatomic , copy) NSString *remind_in;

/**　string	当前授权用户的UID。*/
@property (nonatomic, copy) NSString *uid;

/**　Date	token创建时间。*/
@property (nonatomic, strong) NSDate *created_time;

/**　string	用户的昵称。*/
@property (nonatomic , copy) NSString *name;

- (instancetype)initWithDict:(NSDictionary *)dict;//字典转模型
+ (instancetype)accountWithDict:(NSDictionary *)dict;//字典转模型

+ (NSArray *)account;//Plist转数组

@end
