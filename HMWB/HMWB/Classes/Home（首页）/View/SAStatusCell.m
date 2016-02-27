//
//  SAStatusCell.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/24.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAStatusCell.h"
#import "SAStatus.h"
#import "SAStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "SAUser.h"
#import "SAPhoto.h"
#import "SAStatusToolBar.h"

@interface SAStatusCell()

/** 原创微博整体 */
@property (nonatomic , weak) UIView *orginalView;
/** 头像*/
@property (nonatomic , weak) UIImageView * iconView;
/** 配图*/
@property (nonatomic , weak) UIImageView * photoView;
/** 会员图标*/
@property (nonatomic , weak) UIImageView * vipView;
/** 名字*/
@property (nonatomic , weak) UILabel * nameLabel;
/** 时间*/
@property (nonatomic , weak) UILabel * tiemLabel;
/** 来源*/
@property (nonatomic , weak) UILabel * sourceLabel;
/** 正文*/
@property (nonatomic , weak) UILabel * contentLabel;


/** 转发微博整体*/
@property (nonatomic , weak) UIView * retweetView;
/** 转发微博正方 + 昵称*/
@property (nonatomic , weak) UILabel * retweetContentLabel;
/** 转发配图*/
@property (nonatomic , weak) UIImageView * retweetPhotoView;


/** 工具条*/
@property (nonatomic , weak) SAStatusToolBar * toolbar;


@end

@implementation SAStatusCell

/**
 * Cell的创建方法，设置了标识符ID
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *CellIdentifier = @"status";
    
    SAStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell =  [[SAStatusCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    return cell;
}

/**
 * cell的初始化方法
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //点击后不要变色
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
//        //点击后的背景
//        UIView *bg = [[UIView alloc]init];
//        bg.backgroundColor = [UIColor blueColor];
//        self.selectedBackgroundView = bg;
        
        
        self.backgroundColor = [UIColor colorWithRGBARed:211 Green:211 Blue:211 Alpha:1];
        //初始化原创微博
        [self setupOringial];
        //初始化转发微博
        [self setupRetweet];
        //工具条
        [self setupToolbar];
    }
    return self;
}

/**
 * 初始化原创微博
 */
- (void)setupOringial{
    
    //1.原创微博整体
    
    /** 原创微博整体 */
    UIView *orginalView = [[UIView alloc]init];
    orginalView.backgroundColor = [UIColor whiteColor];
    self.orginalView = orginalView;
    [self.contentView addSubview:orginalView];
    
    /** 头像*/
    UIImageView * iconView = [[UIImageView alloc]init];
    self.iconView = iconView;
    [self.orginalView addSubview:iconView];
    
    /** 配图*/
    UIImageView * photoView = [[UIImageView alloc]init];
    self.photoView = photoView;
    [self.orginalView addSubview:photoView];
    
    /** 会员图标*/
    UIImageView * vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    self.vipView = vipView;
    [self.orginalView addSubview:vipView];
    
    /** 名字*/
    UILabel * nameLabel = [[UILabel alloc]init];
    nameLabel.font = SAStatusCellNameFont;
    self.nameLabel = nameLabel;
    [self.orginalView addSubview:nameLabel];
    
    /** 时间*/
    UILabel * tiemLabel = [[UILabel alloc]init];
    tiemLabel.font = SAStatusCellTimeFont;
    tiemLabel.textColor = [UIColor orangeColor];
    self.tiemLabel =tiemLabel;
    [self.orginalView addSubview:tiemLabel];
    
    /** 来源*/
    UILabel * sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = SAStatusCellSourceFont;
    self.sourceLabel = sourceLabel;
    [self.orginalView addSubview:sourceLabel];
    
    /** 正文*/
    UILabel * contentLabel = [[UILabel alloc]init];
    self.contentLabel =contentLabel;
    contentLabel.font = SAStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [self.orginalView addSubview:contentLabel];
}

/**
 * 初始化转发微博
 */
- (void)setupRetweet{
    /** 转发微博*/
    UIView * retweetView = [[UIView alloc] init];
    retweetView.backgroundColor = [UIColor colorWithRGBARed:247 Green:247 Blue:247 Alpha:1];
    self.retweetView = retweetView;
    [self.contentView addSubview:retweetView];
    
    /** 转发微博正方 + 昵称*/
    UILabel * retweetContentLabel = [[UILabel  alloc] init];
    retweetContentLabel.font = SARetweetStatusCellContentFont;
    retweetContentLabel.numberOfLines = 0;
    self.retweetContentLabel = retweetContentLabel;
    [self.retweetView addSubview:retweetContentLabel];

    
    /** 转发配图*/
    UIImageView * retweetPhotoView = [[UIImageView alloc] init];
    self.retweetPhotoView = retweetPhotoView;
    [self.retweetView addSubview:retweetPhotoView];
}

/**
 * 初始化转发微博
 */
- (void)setupToolbar{
    SAStatusToolBar *toolbar = [SAStatusToolBar toolbar];
    self.toolbar =toolbar;
    [self.contentView addSubview:toolbar];
}

/**
 * 设置了子控件的位置
 */
- (void)setStatusFrame:(SAStatusFrame *)statusFrame{
    _statusFrame = statusFrame;
    
    
    SAStatus *status = statusFrame.status;
    SAUser *user = status.user;
    
    //1.原创微博~~~~~~~~~~~~~~~~
    
    /** 原创微博整体*/
    
    self.orginalView.frame = statusFrame.orginalViewF;
    
    /** 头像*/
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString: user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
  
    /** 会员图标*/
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
         NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }
    else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /** 配图*/
    self.photoView.frame = statusFrame.photoViewF;
    if (status.pic_urls.count) {//有配图
        SAPhoto *photo =[status.pic_urls firstObject];
       [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
    }
    else{//没有配图
        self.photoView.hidden = YES;
    }

    /** 昵称*/
    self.nameLabel.frame = statusFrame.nameLabelF;
    self.nameLabel.text = user.name;

    /** 时间*/
    NSString *time = status.created_at;
    CGFloat timeX = statusFrame.nameLabelF.origin.x;
    CGFloat timeY = CGRectGetMaxY(statusFrame.nameLabelF) + SAStatusCellBorderW;
    CGSize timeSize = [time sizeWithFont:SAStatusCellContentFont];
    self.tiemLabel.frame = (CGRect){{timeX,timeY},timeSize};
    self.tiemLabel.text = time;
    
    /** 来源*/
    CGFloat sourceX = CGRectGetMaxX(statusFrame.tiemLabelF) + SAStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:SAStatusCellContentFont];
    self.sourceLabel.frame = (CGRect){{sourceX,sourceY},sourceSize};;
    self.sourceLabel.text = status.source;

    /** 正文*/
    self.contentLabel.frame = statusFrame.contentLabelF;
    self.contentLabel.text = status.text;
    
    
    //2.被转发的微博~~~~~~~~~~
    if (status.retweeted_status) {
        
        SAStatus *retweeted_status = status.retweeted_status;
        SAUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        
        /** 被转发的微博整体*/
        self.retweetView.frame = statusFrame.retweetViewF;
        
        /** 被转发的微博正文*/
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,status.retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        /** 被转发的微博配图*/
        if (retweeted_status.pic_urls.count) {//有配图
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            SAPhoto *retweeted_photo =[retweeted_status.pic_urls firstObject];
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweeted_photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
             self.retweetPhotoView.hidden = NO;
        }
        else{//没有配图
            self.retweetPhotoView.hidden = YES;
        }
    }
    
    else{
        self.retweetView.hidden = YES;
    }
    
    /** 工具条的位置和大小*/
    self.toolbar.frame = statusFrame.toolbarF;
    
    /** 将status传给ToolBar的status属性*/
    self.toolbar.status = status;
}

 

@end
