//
//  SAAccount.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/22.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAAccount.h"

@implementation SAAccount

- (instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
        //获得账号的存储时间（accessToKen产生时间）
        NSDate *createdTime = [NSDate date];
        self.created_time = createdTime;
    }
    return self;
}//字典转模型

+ (instancetype)accountWithDict:(NSDictionary *)dict{
    return [[self alloc ] initWithDict :dict ];
}//字典转模型

+ (NSArray *)account{
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"account.plist" ofType:nil]];
    
    NSMutableArray *arrayM = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        [arrayM addObject:[self accountWithDict:dict]];
    }
    return arrayM;
}//Plist转数组



/**
 *当一个对象要归档进沙盒中时，就会调用这个方法
 */
- (void)encodeWithCoder:(NSCoder *)aCoder{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeObject:self.expires_in   forKey:@"expires_in"];
    [aCoder encodeObject:self.uid forKey:@"uid"];
    [aCoder encodeObject:self.created_time forKey:@"created_time"];
    [aCoder encodeObject:self.name forKey:@"name"];
}

/**
 *当从沙盒中解档一个对象时，就会调用这个方法
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super init]) {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeObjectForKey:@"expires_in"];
        self.uid = [aDecoder decodeObjectForKey:@"uid"];
        self.created_time = [aDecoder decodeObjectForKey:@"created_time"];
        self.name = [aDecoder decodeObjectForKey:@"name"];
    }
    return self;
}
@end
