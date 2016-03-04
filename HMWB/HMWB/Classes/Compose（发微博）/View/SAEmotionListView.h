//
//  SAEmotionListView.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/3.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  表情键盘上部的表情

#import <UIKit/UIKit.h>

@interface SAEmotionListView : UIView
/** 表情（里面存放的SAEmotion模型）*/
@property (nonatomic, strong) NSArray *emotions;
@end
