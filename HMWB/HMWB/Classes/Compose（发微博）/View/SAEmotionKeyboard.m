//
//  SAEmotionKeyboard.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/3.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAEmotionKeyboard.h"
#import "SAEmotionTabBar.h"
#import "SAEmotionListView.h"
#import "SAEmotion.h"
#import "MJExtension.h"

@interface SAEmotionKeyboard() <SAEmotionTabBarDelegate>
/** 容纳表情内容的控件*/
@property (nonatomic , weak) UIView * contentView;
/** 表情键盘上部的表情*/
@property (nonatomic , strong) SAEmotionListView *recentListView;
@property (nonatomic , strong) SAEmotionListView *defauListView;
@property (nonatomic , strong) SAEmotionListView *emojiListView;
@property (nonatomic , strong) SAEmotionListView *lxhListView;
/** 表情键盘底部的选项卡*/
@property (nonatomic , weak) SAEmotionTabBar * tabBar;
@end


@implementation SAEmotionKeyboard
#pragma mark - 懒加载
- (SAEmotionListView *)recentListView{
    if (_recentListView == nil) {
        _recentListView = [[SAEmotionListView alloc]init];
    }
    return _recentListView;
}

- (SAEmotionListView *)defauListView{
    if (_defauListView == nil) {
        _defauListView = [[SAEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/default/info.plist" ofType:nil];
        _defauListView.emotions = [SAEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _defauListView;
}

- (SAEmotionListView *)emojiListView{
    if (_emojiListView == nil) {
        _emojiListView = [[SAEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/emoji/info.plist" ofType:nil];
        _emojiListView.emotions = [SAEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _emojiListView;
}

- (SAEmotionListView *)lxhListView{
    if (_lxhListView == nil) {
        _lxhListView = [[SAEmotionListView alloc]init];
        NSString *path = [[NSBundle mainBundle] pathForResource:@"EmotionIcons/lxh/info.plist" ofType:nil];
        _lxhListView.emotions = [SAEmotion objectArrayWithKeyValuesArray:[NSArray arrayWithContentsOfFile:path]];
    }
    return _lxhListView;
}


#pragma mark - 初始化

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //1.表情上部
        UIView *contenView = [[UIView alloc] init];
        [self addSubview:contenView];
        self.contentView = contenView;
        
        //2.表情底部
        SAEmotionTabBar *tabBar = [[SAEmotionTabBar alloc] init];
        tabBar.delegate = self;
        [self addSubview:tabBar];
        _tabBar =tabBar;
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    //2.表情底部
    self.tabBar.x = 0;
    self.tabBar.y = self.height - self.tabBar.height;
    self.tabBar.height = 37;
    self.tabBar.width = self.width;
   
    //1.表情内容
    self.contentView.x = 0;
    self.contentView.y = 0;
    self.contentView.width = self.width;
    self.contentView.height = self.tabBar.y;
    
    UIView *child =  [self.contentView.subviews  lastObject];
    child.frame = self.contentView.bounds;

}

//按钮点击代理
- (void)emotionTabBar:(SAEmotionTabBar *)tabBar didSelectButton:(SAEmotionTabBarButtonType)buttonType{
    
    [self.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    switch (buttonType) {
        case SAEmotionTabBarButtonTypeRecent:{//最近
            [self.contentView addSubview:self.recentListView];
            
            SALog(@"最近");
            break;
        }
            
        case SAEmotionTabBarButtonTypeDegfault:{//默认
              [self.contentView addSubview:self.defauListView];
            SALog(@"默认");
            break;
        }

        case SAEmotionTabBarButtonTypeEmoji:{//Emoji
            [self.contentView addSubview:self.emojiListView];
            SALog(@"Emoji");
            break;
        }
  
        case SAEmotionTabBarButtonTypeLXH:{//浪小花
            [self.contentView addSubview:self.lxhListView];
            SALog(@"浪小花");
            break;
        }
    }
    
    //重新调用layoutSubView
    [self setNeedsLayout];
}




@end
