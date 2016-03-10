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
#import "SAEmotionTool.h"

@interface SAEmotionPageView ()
/** 点击表情后弹出的放大镜*/
@property (nonatomic , strong) SAEmotionPopView *popView;
@property (nonatomic , weak) UIButton * deleteButton;
@end


@implementation SAEmotionPageView

- (SAEmotionPopView *)popView {
    if (_popView == nil) {
        _popView = [SAEmotionPopView popView];
    }
    return _popView;
}

/**
 * 初始化时创建删除按钮
 */
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        //删除按钮
        UIButton *deleteButton = [[UIButton alloc] init];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete"] forState:UIControlStateNormal];
        [deleteButton setImage:[UIImage imageNamed:@"compose_emotion_delete_highlighted"] forState:UIControlStateHighlighted];
        [self addSubview:deleteButton];
        [deleteButton addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
        _deleteButton = deleteButton;
        
        //添加长按手势
        [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressPageView:)]];
    }
    return self;
}


- (SAEmotionButton *)emotionButtonWithLocation:(CGPoint)location {
    NSUInteger coutn = self.emotions.count;
    for (int i = 0; i < coutn; i++) {
        // 创建按钮
        SAEmotionButton *btn = self.subviews[i + 1];
        if (CGRectContainsPoint(btn.frame, location)) {
            [self.popView showFrom:btn];
            return btn;
        }
    }
    return nil;
}

/**
 * 在这个方法中处理长按手势
 */
- (void)longPressPageView:(UILongPressGestureRecognizer *)recognizer {
    
    CGPoint location =  [recognizer locationInView:recognizer.view];
    SAEmotionButton *btn =  [self emotionButtonWithLocation:location];
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateCancelled://强制结束
        case UIGestureRecognizerStateEnded:{//结束
            [self.popView removeFromSuperview];
            if (btn) {
                [self selectEmotion:btn.emotion];
            }
            break;
        }
        case UIGestureRecognizerStateChanged://改变
        case UIGestureRecognizerStateBegan: {//开始
            [self.popView showFrom:btn];
            break;
        }
        default:
            break;
    }
}

/**
 * 删除按钮点击
 */
- (void)deleteClick {
     [SANotificationCenter postNotificationName:@"SAEmotionDidDeleteNotification" object:nil];
}

/**
 *  根据数据创建表情按钮的方法
 */
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    NSUInteger coutn = emotions.count;
    for (int i = 0; i < coutn; i++) {
        // 创建按钮
        SAEmotionButton *btn = [[SAEmotionButton alloc] init];
        // 添加按钮
        [self addSubview:btn];
        // 设置表情数据
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
    
    [self.popView showFrom:btn];
    
    //等会让popView自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.popView removeFromSuperview];
    });
    
    [self selectEmotion:btn.emotion];
   }


/**
 * 选中某个表情发出通知
 */
- (void) selectEmotion:(SAEmotion *)emotion{
    
    // 将这个表情存进沙盒
    [SAEmotionTool addRecentEmotion:emotion];
    
    //发出表情按钮被点击通知
    NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
    userInfo[@"selectedEmotion"] = emotion;
    [SANotificationCenter postNotificationName:@"SAEmotionDidSelectNotification" object:nil userInfo:userInfo];
}

/**
 * 子控件的位置
 */
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //内边距
    CGFloat inset = 10;
    NSUInteger coutn = self.emotions.count;
    CGFloat btnW = (self.width - 2 * inset) / SAEmotionMacCols;
    CGFloat btnH = (self.height - inset) / SAEmotionMacRows;
    for (int i = 0; i < coutn; i++) {
        UIButton *btn = self.subviews[i + 1];
        btn.width = btnW;
        btn.height = btnH;
        btn.x = inset + (i % SAEmotionMacCols) * btnW;
        btn.y = inset + (i / SAEmotionMacCols) * btnH;
    }
    
    //删除按钮
    self.deleteButton.width = btnW;
    self.deleteButton.height = btnH;
    self.deleteButton.x = self.width - btnW - inset;
    self.deleteButton.y = self.height - btnH;
 
}

@end
