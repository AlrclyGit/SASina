//
//  SAEmotionPageView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/5.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  

#import "SAEmotionPageView.h"
#import "SAEmotion.h"



@implementation SAEmotionPageView

- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    NSUInteger coutn = emotions.count;
    for (int i = 0; i < coutn; i++) {
        UIButton *btn = [[UIButton alloc] init];
        SAEmotion *emotion = emotions[i];
        if (emotion.png) {
            [btn setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
        }
        else if (emotion.code) {
            [btn setTitle:emotion.code.emoji forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:32];
        }
        [self addSubview:btn];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //内边距
    CGFloat inset = 10;
    NSUInteger coutn = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / SAEmotionMacCols;
    CGFloat btnH = (self.height - inset) / SAEmotionMacRows;
    for (int i = 0; i < coutn; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % SAEmotionMacCols) * btnW;
        btn.y = inset + (i / SAEmotionMacCols) * btnH;
    }

}

@end
