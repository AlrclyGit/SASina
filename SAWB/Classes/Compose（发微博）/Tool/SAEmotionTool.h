//
//  SAEmotionTool.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/10.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SAEmotion;

@interface SAEmotionTool : NSObject

+ (void)addRecentEmotion:(SAEmotion *)emotion;
+ (NSArray *)recentEmotions;

@end
