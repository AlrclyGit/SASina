//
//  SAUser.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/23.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

@interface SAUser : NSObject

/** string	字符串型的用户UID*/
@property (nonatomic , copy) NSString *idstr;
/** string	友好显示名称*/
@property (nonatomic , copy) NSString *name;
/** string	用户头像地址（中图），50×50像素*/
@property (nonatomic , copy) NSString *profile_image_url;
/** 会员类型 值大于2才是会员*/
@property (nonatomic , assign) int mbtype;
@property (nonatomic , assign , getter = isVip) BOOL vip;
/** 会员等级*/
@property (nonatomic , assign) int mbrank;

@end
