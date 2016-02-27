//
//  SAStatusFrame.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/24.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAStatusFrame.h"
#import "SAStatus.h"
#import "SAUser.h"

//cell的边框宽度
#define SAStatusCellBorderW 10

@implementation SAStatusFrame

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    //[text sizeWithAttributes:attrs]
    CGSize maxSize = CGSizeMake(maxW , MAXFLOAT);
    return [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithText:(NSString *)text font:(UIFont *)font{
    
    return [self sizeWithText:text font:font maxW:MAXFLOAT];
}

- (void)setStatus:(SAStatus *)status{
    
    _status = status;
    SAUser *user = status.user;

    //1.原创微博~~~~~~~~~~~~~~~~
    
    /** 系统宽度*/
    CGFloat cellW = [UIScreen mainScreen].bounds.size.width;
    
    //
    /** 头像*/
    CGFloat iconWH = 43;
    CGFloat iconX = SAStatusCellBorderW;
    CGFloat iconY = SAStatusCellBorderW;
    self.iconViewF = CGRectMake(iconX, iconY, iconWH, iconWH);
    
    /** 昵称*/
    CGFloat nameX = CGRectGetMaxX(self.iconViewF) + SAStatusCellBorderW;
    CGFloat nameY = iconY;
    CGSize nameSize = [self sizeWithText:user.name font:SAStatusCellNameFont];
    self.nameLabelF = (CGRect){{nameX,nameY},nameSize};
    
    /** 会员图片*/
    if  (user.isVip ){
        CGFloat vipX = CGRectGetMaxX(self.nameLabelF) + SAStatusCellBorderW;
        CGFloat vipY = iconY;
        CGFloat vipW = nameSize.height;
        CGFloat vipH = nameSize.height;
        self.vipViewF = CGRectMake(vipX, vipY, vipW, vipH);
    }
    
    /** 时间*/
    CGFloat timeX = nameX;
    CGFloat timeY = CGRectGetMaxY(self.nameLabelF) + SAStatusCellBorderW;
    CGSize timeSize = [self sizeWithText:status.created_at font:SAStatusCellTimeFont];
     self.tiemLabelF = (CGRect){{timeX,timeY},timeSize};
    
    /** 来源*/
    CGFloat sourceX = CGRectGetMaxX(self.tiemLabelF) + SAStatusCellBorderW;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [self sizeWithText:status.source font:SAStatusCellSourceFont];
    self.sourceLabelF = (CGRect){{sourceX,sourceY},sourceSize};

    /** 正文*/
    CGFloat contentX = iconX;
    CGFloat contentY = MAX(CGRectGetMaxY(self.iconViewF), CGRectGetMaxY(self.tiemLabelF)) + SAStatusCellBorderW;
    CGFloat maxW = cellW - 2 * contentX;
    CGSize contentSize = [self sizeWithText:status.text font:SAStatusCellContentFont maxW:maxW];
    self.contentLabelF = (CGRect){{contentX,contentY},contentSize};
    
    /** 配图*/
    CGFloat orginalViewH = 0;
    if (status.pic_urls.count) {//有配图
        CGFloat photoWH = 100;
        CGFloat photoX = contentX;
        CGFloat photoY = CGRectGetMaxY(self.contentLabelF) + SAStatusCellBorderW;
        self.photoViewF = CGRectMake(photoX, photoY, photoWH, photoWH);
        orginalViewH = CGRectGetMaxY(self.photoViewF) + SAStatusCellBorderW;
    }
    else{
        orginalViewH = CGRectGetMaxY(self.contentLabelF) + SAStatusCellBorderW;
    }
    
    /** 原创微博整体*/
    CGFloat orginalViewX = 0;
    CGFloat orginalViewY = SAStatusCellMargin;
    CGFloat orginalViewW = cellW;
    self.orginalViewF = CGRectMake(orginalViewX, orginalViewY, orginalViewW, orginalViewH);
    
    
    //2.被转发的微博~~~~~~~~~~
    
    /** 被转发微博正文*/
    
    /** 被转发微博配图*/
    
    /** 被转发微博*/
    
    //2.被转发的微博~~~~~~~~~~
      CGFloat toolbarY = 0;
    if (status.retweeted_status) {//有转发
        
        /** 被转发的微博正方*/
        //获取文字范围
        SAStatus *retweeted_status = status.retweeted_status;
        SAUser *retweeted_status_user = retweeted_status.user;
        NSString *retweetContent = [NSString stringWithFormat:@"@%@ : %@",retweeted_status_user.name,status.retweeted_status.text];
        //设置大小文字
        CGFloat retweetContentX = SAStatusCellBorderW;
        CGFloat retweetContentY = SAStatusCellBorderW;
        CGFloat retweetContentW = cellW - 2 * contentX;
        CGSize retweetContentSize = [self sizeWithText:retweetContent font:SARetweetStatusCellContentFont maxW:retweetContentW];
        self.retweetContentLabelF = (CGRect){{retweetContentX,retweetContentY},retweetContentSize};
        
        /** 被转发的微博配图*/
        CGFloat retweetH = 0 ;
      
        
        if (retweeted_status.pic_urls.count) {//有图片
            CGFloat retweetPhotoWH = 100;
            CGFloat  retweetphotoX = retweetContentX;
            CGFloat  retweetphotoY = CGRectGetMaxY(self.retweetContentLabelF) + SAStatusCellBorderW;
            self.retweetPhotoViewF = CGRectMake( retweetphotoX, retweetphotoY, retweetPhotoWH, retweetPhotoWH);
            retweetH = CGRectGetMaxY(self.retweetPhotoViewF) +SAStatusCellBorderW;
        }
        else{//没有配图
            retweetH = CGRectGetMaxY(self.retweetContentLabelF) +SAStatusCellBorderW;
        }
        
        /** 被转发的微博整体*/
        CGFloat retweetX = 0;
        CGFloat retweetY = CGRectGetMaxY(self.orginalViewF);
        CGFloat retweetW = cellW;
        self.retweetViewF = CGRectMake(retweetX, retweetY, retweetW, retweetH);
        
        toolbarY = CGRectGetMaxY(self.retweetViewF);
    }
    else{
        toolbarY = CGRectGetMaxY(self.orginalViewF);

    }
    
    
    /** 底部工具条*/
    CGFloat toolbarX = 0;
    CGFloat toolbarW = cellW;
    CGFloat toolbarH = 35;
    self.toolbarF = CGRectMake(toolbarX, toolbarY, toolbarW, toolbarH);
    
    /** cell高度*/
    self.cellHeight = CGRectGetMaxY(self.toolbarF);
}

@end
