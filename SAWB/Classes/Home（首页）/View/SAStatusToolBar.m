//
//  SAStatusToolBar.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/26.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAStatusToolBar.h"
#import "SAStatus.h"

@interface SAStatusToolBar()
/** 里面存放所有的按钮*/
@property (nonatomic, strong) NSMutableArray *btns;
/** 里面存放所有的分割线*/
@property (nonatomic, strong) NSMutableArray *dividers;

@property (nonatomic, weak) UIButton *repostBtn;
@property (nonatomic, weak) UIButton *commentBtn;
@property (nonatomic, weak) UIButton *attitudeBtn;
@end




@implementation SAStatusToolBar

- (NSMutableArray *)btns
{
    if (!_btns) {
        self.btns = [NSMutableArray array];
    }
    return _btns;
}

- (NSMutableArray *)dividers
{
    if (!_dividers) {
        self.dividers = [NSMutableArray array];
    }
    return _dividers;
}

/**
 * 初始化的构造方法
 */
+ (instancetype)toolbar{
    return [[self alloc] init];
}

/**
 * 初始化所有按钮
 */
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_card_bottom_background"]];
        
        //添加按钮
        self.repostBtn = [self setupBtn:@"转发" icon:@"timeline_icon_retweet"];
        self.commentBtn = [self setupBtn:@"评论" icon:@"timeline_icon_comment"];
        self.attitudeBtn =  [self setupBtn:@"赞" icon:@"timeline_icon_unlike"];
        
        //添加分割线
        [self setupDivider];
        [self setupDivider];
    }
    return self;
}

/**
 * 添加分割线
 */
- (void)setupDivider
{
    UIImageView *divider = [[UIImageView alloc] init];
    divider.image = [UIImage imageNamed:@"timeline_card_bottom_line"];
    [self addSubview:divider];
    [self.dividers addObject:divider];
}

/**
 * 初始化一个按钮
 * @param title : 按钮文字
 * @param icon: 按钮图标
 *
 */
- (UIButton *)setupBtn:(NSString *)title icon:(NSString *)icon{
    UIButton *btn = [[UIButton alloc] init];
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:@"timeline_card_bottom_background_highlighted"] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self addSubview:btn];
    
    [self.btns addObject:btn];
    
    return btn;
    
}

/**
 * 设置位置和大小
 */
- (void)layoutSubviews{
    [super layoutSubviews];
    
    //设置按钮的frame
    long btncount = self.btns.count;
    CGFloat btnW = self.width / btncount;
    CGFloat btnH = self.height;
    for (int i = 0; i < btncount; i++) {
        UIButton *btn = self.btns[i];
        btn.x = btnW * i;
        btn.y = 0;
        btn.width = btnW;
        btn.height = btnH;
    }
    
    //设置分割线的frame
    long dividerCount = self.dividers.count;
    for (int i = 0; i<dividerCount; i++) {
        UIImageView *divider = self.dividers[i];
        divider.width = 1;
        divider.height = btnH;
        divider.x = (i + 1) * btnW;
        divider.y = 0;
    }
}

- (void)setStatus:(SAStatus *)status{
    _status = status;
    
    //转发
    [self setupBtnCount:status.reposts_count btn:self.repostBtn title:@"转发"];
    //评论
    [self setupBtnCount:status.comments_count btn:self.commentBtn title:@"评论"];
    //赞
    [self setupBtnCount:status.attitudes_count btn:self.attitudeBtn title:@"赞"];
    
}

- (void)setupBtnCount:(int)count btn:(UIButton *)btn title:(NSString *)title{
    if (count) {
        if (count < 10000) {
            title = [NSString stringWithFormat:@"%d",count];
        }
        else{
            double wan = count / 10000;
            title = [NSString stringWithFormat:@"%.1f万",wan];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@"Love"];
        }
    }
    [btn setTitle:title forState:UIControlStateNormal];
}

@end
