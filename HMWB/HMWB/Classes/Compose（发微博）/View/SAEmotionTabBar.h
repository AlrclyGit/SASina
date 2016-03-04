//
//  SAEmotionTabBar.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/3.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  表情键盘底部的选项卡

#import <UIKit/UIKit.h>

typedef enum {
    SAEmotionTabBarButtonTypeRecent,//最近
    SAEmotionTabBarButtonTypeDegfault,//默认
    SAEmotionTabBarButtonTypeEmoji,//emoji
    SAEmotionTabBarButtonTypeLXH,//浪小花
}SAEmotionTabBarButtonType;

@class SAEmotionTabBar;

@protocol SAEmotionTabBarDelegate <NSObject>
@optional
- (void)emotionTabBar:(SAEmotionTabBar *)tabBar didSelectButton:(SAEmotionTabBarButtonType)buttonType;
@end

@interface SAEmotionTabBar : UIView
@property (nonatomic , weak) id<SAEmotionTabBarDelegate> delegate;
@end
