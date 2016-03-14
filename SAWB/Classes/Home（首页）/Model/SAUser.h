//
//  SAUser.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/23.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  用户模型

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, SAUserVerifiedtype) {
    SAUserVerifiedtypeNone = -1,        //没有任何认证
    SAUserVerifiedtypePersonal = 0,     //个人认证
    SAUserVerifiedtypeEnterprice = 2,   //企业官方
    SAUserVerifiedtypeMedia =3,         //媒体官方
    SAUserVerifiedtypeWebstie = 5,      //网站官方
    SAUserVerifiedtypeDaren = 220       //达人
};

@interface SAUser : NSObject

/** string	字符串型的用户UID*/
@property (nonatomic , copy) NSString *idstr;
/** string	友好显示名称*/
@property (nonatomic , copy) NSString *name;
/** string	用户头像地址（中图），50×50像素*/
@property (nonatomic , copy) NSString *profile_image_url;
/** 会员类型 值大于2才是会员*/
@property (nonatomic , assign) NSInteger mbtype;
@property (nonatomic , assign , getter = isVip) BOOL vip;
/** 会员等级*/
@property (nonatomic , assign) NSInteger mbrank;
/** 认证类型*/
@property (nonatomic , assign) SAUserVerifiedtype verified_type;

@end
