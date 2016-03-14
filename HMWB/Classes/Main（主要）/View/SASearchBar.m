//
//  SASearchBar.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/18.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  利用文本框自定义搜索框

#import "SASearchBar.h"

@implementation SASearchBar



- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
    
        //设置输入的文字大小
        self.font = [UIFont systemFontOfSize:15];
        //设置默认的显示
        self.placeholder = @"请输入搜索条件";
        //设置背景图片
        self.background = [UIImage imageNamed:@"searchbar_textfield_background"];
        
        //设置左边的放大镜图标
        UIImageView *searchIcon = [[UIImageView alloc] init];
        //imageVeiw内的图片
        searchIcon.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        //imageView大小
        searchIcon.width = 30;
        searchIcon.height = 30;
        //image居中
        searchIcon.contentMode = UIViewContentModeCenter;
        
        //图片添加到搜索框左视图
        self.leftView = searchIcon;
        //搜索框左视图可见
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

+ (instancetype)SAsearchBar{
    return [[self alloc] init];
}



@end
