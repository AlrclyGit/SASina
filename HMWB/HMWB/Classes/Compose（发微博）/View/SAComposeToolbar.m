//
//  SAComposeToolbar.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/2.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAComposeToolbar.h"

@implementation SAComposeToolbar


/**
 * 工具条的初始化方法
 */
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"compose_toolbar_background"]];
        [self setupBtn:@"compose_camerabutton_background" highImage:@"compose_camerabutton_background_highlighted" type:SAComposeToolbarButtonTypeCamera];
        [self setupBtn:@"compose_toolbar_picture" highImage:@"compose_toolbar_picture_highlighted" type:SAComposeToolbarButtonTypePicture];
        [self setupBtn:@"compose_mentionbutton_background" highImage:@"compose_mentionbutton_background_highlighted" type:SAComposeToolbarButtonTypeMention];
        [self setupBtn:@"compose_trendbutton_background" highImage:@"compose_trendbutton_background_highlighted" type:SAComposeToolbarButtonTypeTrend];
        [self setupBtn:@"compose_emoticonbutton_background" highImage:@"compose_emoticonbutton_background_highlighted" type:SAComposeToolbarButtonTypeEmotion];
    }
    return self;
}

/**
 * 创建工具条内一个按钮的方法
 */
- (void)setupBtn:(NSString *)image highImage:(NSString *)highImage type:(SAComposeToolbarButtonType)type{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    btn.tag = type;
    [self addSubview:btn];
}

/**
 * 设置按钮功能的代理
 */
- (void)btnClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(composeToolbar:didClickButton:)]) {
        [self.delegate composeToolbar:self didClickButton:(SAComposeToolbarButtonType)btn.tag];
    }
}

/**
 * 设置工具条内按钮子控件的Frame
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置所有按钮的Frame
    NSUInteger count = self.subviews.count;
    CGFloat btnW = self.width / count;
    CGFloat btnH = self.height;
    for (NSUInteger i = 0; i < count; i++) {
        UIButton *btn = self.subviews[i];
        btn.y = 0;
        btn.x = btnW * i;
        btn.width = btnW;
        btn.height = btnH;
    }
}

@end
