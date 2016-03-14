//
//  NSDate+Extension.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/27.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;
@end
