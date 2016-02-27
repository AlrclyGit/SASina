//
//  SAStatusFrame.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/24.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  一个SAStatusFrame模型里面包含的信息
//  1.存放着一个Cell内部所有子控件的frame数据
//  2.存放一个Cell的高度
//  3.存放着一个数据模型SAStatus

#import <Foundation/Foundation.h>
//昵称字体
#define SAStatusCellNameFont [UIFont systemFontOfSize:15]
//时间字体
#define SAStatusCellTimeFont [UIFont systemFontOfSize:12]
//来源字体
#define SAStatusCellSourceFont [UIFont systemFontOfSize:12]
//正文字体
#define SAStatusCellContentFont [UIFont systemFontOfSize:14]
//被转发正方字体
#define SARetweetStatusCellContentFont [UIFont systemFontOfSize:13]
//cell的间距
#define SAStatusCellMargin 15
//cell的边框宽度
#define SAStatusCellBorderW 10


@class SAStatus;

@interface SAStatusFrame : NSObject

/**
 * 存放着一个数据模型SAStatus
 */
@property (nonatomic, strong) SAStatus * status;

/**
 * 存放着一个Cell内部所有子控件的frame数据
 */
/** 原创微博整体 */
@property (nonatomic , assign) CGRect orginalViewF;
/** 头像*/
@property (nonatomic , assign) CGRect iconViewF;
/** 配图*/
@property (nonatomic , assign) CGRect photoViewF;
/** 会员图标*/
@property (nonatomic , assign) CGRect vipViewF;
/** 名字*/
@property (nonatomic , assign) CGRect nameLabelF;
/** 时间*/
@property (nonatomic , assign) CGRect tiemLabelF;
/** 来源*/
@property (nonatomic , assign) CGRect sourceLabelF;
/** 正文*/
@property (nonatomic , assign) CGRect contentLabelF;


/** 转发微博整体 */
@property (nonatomic , assign) CGRect retweetViewF;
/** 转发微博正方 + 昵称*/
@property (nonatomic , assign) CGRect retweetContentLabelF;
/** 转发配图*/
@property (nonatomic , assign) CGRect retweetPhotoViewF;


/** 底部工具条*/
@property (nonatomic , assign) CGRect toolbarF;

/**
 * 存放一个Cell的高度
 */
@property (nonatomic, assign) CGFloat cellHeight;

@end
