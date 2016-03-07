//
//  SAEmotionPageView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/5.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  

#import "SAEmotionPageView.h"
#import "SAEmotion.h"
#import "SAEmotionPopView.h"
#import "SAEmotionButton.h"

@interface SAEmotionPageView ()
/** 点击表情后弹出的放大镜*/
@property (nonatomic, strong) SAEmotionPopView *popView;
@end


@implementation SAEmotionPageView

- (SAEmotionPopView *)popView{
    if (_popView == nil) {
        _popView = [SAEmotionPopView popView];
    }
    return _popView;
}


- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    NSUInteger coutn = emotions.count;
    for (int i = 0; i < coutn; i++) {
        SAEmotionButton *btn = [[SAEmotionButton alloc] init];
         [self addSubview:btn];
        
        //  设置表情数据
        btn.emotion = emotions[i];
        
        // 监听按钮点击
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
}


/**
 * 监听表情按钮点击
 *
 *  @param btn 
 */
- (void)btnClick:(SAEmotionButton *)btn {
    
    // 给popView传递数据
    self.popView.emotion = btn.emotion;
    
    //取得最上面的Window
    UIWindow *window = [[UIApplication  sharedApplication].windows lastObject];
    [window addSubview:self.popView];
    
    //计算出被点击的按钮在widnow中的frame
    CGRect bntFrame = [btn convertRect:btn.bounds toView:nil];
    self.popView.y = CGRectGetMidY(bntFrame) - self.popView.height;
    self.popView.centerX = CGRectGetMidX(bntFrame);
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    //发出通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"selectedEmotion"] = btn.emotion;
    [SANotificationCenter postNotificationName:@"SAEmotionDidSelectNotification" object:nil userInfo:userInfo];
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
