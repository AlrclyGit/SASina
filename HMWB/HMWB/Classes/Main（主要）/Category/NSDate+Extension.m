//
//  NSDate+Extension.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/27.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //获得date的时间
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    //获得当前的时间
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    //对年份进行比较
    return dateCmps.year == nowCmps.year;
}


/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday
{
    //创建一个时间对象
    NSDate *now = [NSDate date];
    
    //创建一个时间格式对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    
    //Thu Oct 16 17:06:25 +0800 2014
    //EEE MMM dd HH:mm:ss Z yyyy];
    //星期 月份 几号 时 分 秒 时区 年
    fmt.dateFormat = @"yyyy-MM-dd";
    
    //时间转成字符串
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    //字符串转成时间
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    
    //创建一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //想要获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday
{
    //创建一个时间对象
    NSDate *now = [NSDate date];
    //创建一个时间格式对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    //Thu Oct 16 17:06:25 +0800 2014
    //EEE MMM dd HH:mm:ss Z yyyy];
    //星期 月份 几号 时 分 秒 时区 年
    fmt.dateFormat = @"yyyy-MM-dd";
    
    //时间转成字符串
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    
    //字符串进行比较
    return [dateStr isEqualToString:nowStr];
}

@end
