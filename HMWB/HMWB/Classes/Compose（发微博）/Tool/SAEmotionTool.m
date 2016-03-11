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

static NSMutableArray * _recentEmotons;


+ (void)initialize {
    // 加载沙盒中的表情数据
    _recentEmotons = [NSKeyedUnarchiver unarchiveObjectWithFile:SARecentEmotionsPath];
    if (_recentEmotons == nil) {
        _recentEmotons = [NSMutableArray array];
    }

}

/**
 * 添加
 */
+ (void)addRecentEmotion:(SAEmotion *)emotion {
    
    
    //删除重复的表情.本来只能比较地址，但重写了emotons的isEqual方法，使之比较字符串
    [_recentEmotons removeObject:emotion];
    
    // 将表情放到数组的最前面
    [_recentEmotons insertObject:emotion atIndex:0];
    
    // 将所有的表情数据写入沙盒
    [NSKeyedArchiver archiveRootObject:_recentEmotons toFile:SARecentEmotionsPath];
}

/**
 * 使用
 */
+ (NSArray *)recentEmotions {
    return _recentEmotons;
}

@end
