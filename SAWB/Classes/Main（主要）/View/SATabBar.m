//
//  SATabBar.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/19.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  重写标签导航条

#import "SATabBar.h"

@interface SATabBar()
@property (nonatomic,weak) UIButton *plusBtn;
@end



@implementation SATabBar

@synthesize delegate;

//创建TabBar的方法
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //创建一个按钮
        UIButton *plusBtn = [[UIButton alloc] init];
        
        //设置按钮背景图片
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button" ]forState:UIControlStateNormal];
        [plusBtn setBackgroundImage:[UIImage imageNamed:@"tabbar_compose_button_highlighted"] forState:UIControlStateHighlighted];
        
        //设置按钮图片
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add"] forState:UIControlStateNormal];
        [plusBtn setImage:[UIImage imageNamed:@"tabbar_compose_icon_add_highlighted"] forState:UIControlStateHighlighted];
    
        //设置按钮大小
        plusBtn.size = plusBtn.currentBackgroundImage.size;
        
        //点击按键方法
        [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
        
        //添加到View
        [self addSubview:plusBtn];
        
        _plusBtn = plusBtn;

    }
    return self;
}

//点击中间正方黄色按钮的代理方法
- (void)plusClick{
    if ([self.delegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.delegate tabBarDidClickPlusButton:self];
    }
}

//重新调整按钮的位置与大小。
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //1.设置加号按钮的位置
    self.plusBtn.centerX = self.width * 0.5;
    self.plusBtn.centerY = self.height * 0.5;
    
    //2.设置其他tabbarButton的位置和尺寸
    CGFloat tabbarButtonW = self.width / 5;
    CGFloat tabbarButtonIndex = 0;
    
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            //设置宽度
            child.width = tabbarButtonW;
            //设置X
            child.x = tabbarButtonIndex * tabbarButtonW;
            //增加索引
            tabbarButtonIndex ++;
            if (tabbarButtonIndex == 2) {
                tabbarButtonIndex++;
            }
        }
    }
    
}



@end

