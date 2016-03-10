//
//  SAEmotionTool.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/10.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

//最近表情的存储路径
#define SARecentEmotionsPath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"Emotions.data"]

#import "SAEmotionTool.h"

@implementation SAEmotionTool

/**
 * 添加
 */
+ (void)addRecentEmotion:(SAEmotion *)emotion {
    
    // 加载沙盒中的表情数据
    NSMutableArray *emotions = (NSMutableArray *)[self recentEmotions];
    if (emotions == nil) {
        emotions = [NSMutableArray array];
    }
    
    // 将表情放到数组的最前面
    [emotions insertObject:emotion atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:emotions toFile:SARecentEmotionsPath];
}

/**
 * 使用
 */
+ (NSArray *)recentEmotions {
    return  [NSKeyedUnarchiver unarchiveObjectWithFile:SARecentEmotionsPath];
}

@end
