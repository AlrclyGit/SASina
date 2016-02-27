//
//  SAStatus.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/23.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAStatus.h"
#import "MJExtension.h"
#import "SAPhoto.h"

@implementation SAStatus

- (NSDictionary *)objectClassInArray{
    return @{@"pic_urls" : [SAPhoto class]};
}

- (NSString *)created_at{
    
    //    Thu Oct 16 17:06:25 +0800 2014
    //    EEE MMM dd HH:mm:ss Z yyyy];
    //    星期 月份 几号 时 分 秒 时区 年
    //    创建一个时间格式对象
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];//如果是真机调试，转缺钱这种欧美时间，需要设置locale
    
    // 用fmt 创建微博的创建日期
    NSDate * createDate = [fmt dateFromString:_created_at];
    
    // 获取当前时间
    NSDate * now = [NSDate date];
    //NSTimeInterval selonds = [createDate timeIntervalSinceNow] //用秒进行比较（不可取）
    
    //日历对象（方便比较两个日期之间的差距）
    //创建一个日历对象
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //想要获得哪些差值
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];

    
    if ([createDate isThisYear]) {//今年
        if ([createDate isYesterday]) {//昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }
        else if([createDate isToday]){//今天
            if (cmps.hour >= 1) {
                fmt.dateFormat = @"今天 HH:mm";
                return [fmt stringFromDate:createDate];
            }
            else if (cmps.minute >= 1){
                return [NSString stringWithFormat:@"%ld分钟前",(long)cmps.minute];
            }
            else {
                return @"刚刚";
            }
        }
        else{//今年的其他日子
            fmt.dateFormat = @"MM-DD HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }
    else{//非今年
        fmt.dateFormat = @"yyyy-MM-DD HH:mm";
        return [fmt stringFromDate:createDate];
    }
}

@end
