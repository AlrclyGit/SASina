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

- (void)showFrom:(SAEmotionButton *)button{
    // 给popView传递数据
    self.emotion = button.emotion;
    
    //取得最上面的Window
    UIWindow *window = [[UIApplication  sharedApplication].windows lastObject];
    [window addSubview:self];
    
    //计算出被点击的按钮在widnow中的frame
    CGRect bntFrame = [button convertRect:button.bounds toView:nil];
    self.y = CGRectGetMidY(bntFrame) - self.height;
    self.centerX = CGRectGetMidX(bntFrame);
}

@end
