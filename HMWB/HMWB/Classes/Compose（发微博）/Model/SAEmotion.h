//
//  SAEmotion.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/4.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAEmotion : NSObject
/** 表情的文字描述*/
@property (nonatomic , copy) NSString *chs;
/** 表情的png图片名*/
@property (nonatomic , copy) NSString *png;
/** emoji表情的16进制编码*/
@property (nonatomic , copy) NSString *code;
@end
