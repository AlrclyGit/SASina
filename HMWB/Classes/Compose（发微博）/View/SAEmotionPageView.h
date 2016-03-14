//
//  SAEmotionPageView.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/5.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  用表示一页的表情

#import <UIKit/UIKit.h>

//一页中最多3行
#define SAEmotionMacRows 4
//一行最多是7列
#define SAEmotionMacCols 7
//每一页的表情个数
#define SAEmotionPageSize ((SAEmotionMacRows * SAEmotionMacCols) - 1)

@interface SAEmotionPageView : UIView
/** 这一页里都是这一页的表情*/
@property (nonatomic, strong) NSArray *emotions;
@end
