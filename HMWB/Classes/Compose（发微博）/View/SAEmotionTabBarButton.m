//
//  SAEmotionTabBarButton.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/3.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAEmotionTabBarButton.h"

@implementation SAEmotionTabBarButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //设置文字颜色
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateDisabled];
        //设置文字大小
        self.titleLabel.font = [UIFont systemFontOfSize:13];
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted{
    //按钮高亮所做的一切操作都不在了
}
@end
