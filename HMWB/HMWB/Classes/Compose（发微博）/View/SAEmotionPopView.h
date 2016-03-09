//
//  SAEmotionPopView.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/7.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAEmotion,SAEmotionButton;
@interface SAEmotionPopView : UIView
+ (instancetype)popView;
@property (nonatomic, strong) SAEmotion *emotion;
- (void)showFrom:(SAEmotionButton *)button;
@end
