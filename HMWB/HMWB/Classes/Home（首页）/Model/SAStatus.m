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
    
    //NSString --> NSDate
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    //    Thu Oct 16 17:06:25 +0800 2014
    //    EEE MMM DD HH:mm:ss Z yyyy];
    //    星期 月份 几号 时 分 秒 时区 年
    fmt.dateFormat = @"EEE MMM DD HH:mm:ss Z yyyy";
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];//如果是真机调试，转缺钱这种欧美时间，需要设置locale
    // 微博的创建日期
    NSDate * createDate = [fmt dateFromString:_created_at];
    //    当前时间
    NSDate * now = [NSDate date];
    //    NSTimeInterval selonds = [createDate timeIntervalSinceNow];
    //用秒进行比较不可取
    
    //日历对象（方便比较两个日期之间的差距）
    NSCalendar *calendar = [NSCalendar currentCalendar];//创建一个日历对象
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMinute | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;//想要获得哪些差值
    
    //计算两个日期之间的差值
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:now options:0];
    
    //获得某个时间的年月日时分秒
    NSDateComponents *createDateCmps = [calendar components:unit fromDate:createDate];
    
    SALog(@"%@",createDate);
    
    
    return @"一首歌的时间";
}
@end
