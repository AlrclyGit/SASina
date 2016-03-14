//
//  SAEmotionTabBar.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/3.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAEmotionTabBar.h"
#import "SAEmotionTabBarButton.h"

@interface SAEmotionTabBar()
@property (nonatomic , weak) SAEmotionTabBarButton * selectedBtn;
@end

@implementation SAEmotionTabBar

/**
 * 初始化
 */
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBtn:@"最近" buttonType:SAEmotionTabBarButtonTypeRecent];
        [self setupBtn:@"默认" buttonType:SAEmotionTabBarButtonTypeDegfault];
        [self setupBtn:@"Emoji" buttonType:SAEmotionTabBarButtonTypeEmoji];
        [self setupBtn:@"浪小花" buttonType:SAEmotionTabBarButtonTypeLXH];
    }
    return self;
}

/**
 * 创建一个按钮
 */
- (SAEmotionTabBarButton *)setupBtn:(NSString *)title buttonType:(SAEmotionTabBarButtonType)buttonType{
    SAEmotionTabBarButton *btn = [[SAEmotionTabBarButton alloc] init];
    //监听按钮
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    //
    btn.tag = buttonType;
    //设置文字
    [btn setTitle:title forState:UIControlStateNormal];
    //选中『默认』按钮
    if (buttonType == SAEmotionTabBarButtonTypeDegfault) {
        [self btnClick:btn];
    }
    
    
    
    //设置背景图片
    NSString *image = @"compose_emotion_table_mid_normal";
    NSString *selectImage = @"compose_emotion_table_mid_selected";
    if (buttonType == SAEmotionTabBarButtonTypeRecent) {
        image = @"compose_emotion_table_left_normal";
        selectImage = @"compose_emotion_table_left_selected";
    }
    else if (buttonType == SAEmotionTabBarButtonTypeLXH){
        image = @"compose_emotion_table_right_normal";
        selectImage = @"compose_emotion_table_right_selected";
    }
    [btn setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled];
    //添加
    [self addSubview:btn];
    
    return btn;
}


- (void)setDelegate:(id<SAEmotionTabBarDelegate>)delegate{
    _delegate = delegate;
    [self btnClick:[self viewWithTag:SAEmotionTabBarButtonTypeDegfault]];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置按钮的frame
    long btncount = self.subviews.count;
    
    CGFloat btnW = self.width / btncount;
    CGFloat btnH = self.height;
    for (int i = 0; i < btncount; i++) {
        SAEmotionTabBarButton *btn = self.subviews[i];
        btn.x = btnW * i;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    
}

- (void)btnClick:(SAEmotionTabBarButton *)btn{
    self.selectedBtn.enabled = YES;
    btn.enabled = NO;
    self.selectedBtn = btn;
    
    //通知代理
    if ([self.delegate respondsToSelector:@selector(emotionTabBar:didSelectButton:)]) {
        [self.delegate emotionTabBar:self didSelectButton:(SAEmotionTabBarButtonType)btn.tag];
    }
    
}


@end
