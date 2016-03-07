//
//  SAEmotionPopView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/7.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAEmotionPopView.h"
#import "SAEmotion.h"
#import "SAEmotionButton.h"

@interface SAEmotionPopView()
@property (weak, nonatomic) IBOutlet SAEmotionButton *emotionButton;
@end

@implementation SAEmotionPopView

+ (instancetype)popView{
    return  [[[NSBundle mainBundle] loadNibNamed:@"SAEmotionPopView" owner:nil options:nil] lastObject];
}

- (void)setEmotion:(SAEmotion *)emotion{
    _emotion = emotion;
    
    self.emotionButton.emotion = emotion;
    
   
}

@end
