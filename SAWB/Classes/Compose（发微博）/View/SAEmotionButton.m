//
//  SAEmotionButton.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/7.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAEmotionButton.h"
#import "SAEmotion.h"

@implementation SAEmotionButton

/**
 * 从非Xib中创建时调用
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUp];
    }
    return self;
}

/**
 * 从Xib中创建时调用
 */
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self setUp];
    }
    return self;
}

/**
 * 初始化方法
 */
- (void)setUp {
    self.titleLabel.font = [UIFont systemFontOfSize:32];
    //按钮高亮时不要去调整图片
    self.adjustsImageWhenHighlighted = NO;
    
}

/**
 * 这这方法在initWithCoder:方法后调用
 */
- (void)awakeFromNib {
    
}


- (void)setEmotion:(SAEmotion *)emotion {
    _emotion = emotion;
    // 设置表情数据
    if (emotion.png) {// 图片
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    }
    else if (emotion.code) {// 是emoji表情
        [self setTitle:emotion.code.emoji forState:UIControlStateNormal];
        
    }
}


@end
