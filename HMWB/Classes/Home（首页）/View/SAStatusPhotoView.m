//
//  SAStatusPhotoView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/29.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAStatusPhotoView.h"
#import "SAPhoto.h"
#import "UIImageView+WebCache.h"

@interface SAStatusPhotoView ()
@property (nonatomic , weak) UIImageView * gifView;
@end

@implementation SAStatusPhotoView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        /*
        UIViewContentModeScaleToFill,       //拉伸并充满屏幕
        UIViewContentModeScaleAspectFit,    //拉伸等比适合于屏幕
        UIViewContentModeScaleAspectFill,   //拉伸等比充满屏幕
        UIViewContentModeRedraw,            //调用了(calls -setNeedsDisplay)方法时，就会将图片重新渲染
        UIViewContentModeCenter,            //居中显示
        UIViewContentModeTop,               //上
        UIViewContentModeBottom,            //下
        UIViewContentModeLeft,              //左
        UIViewContentModeRight,             //右
        UIViewContentModeTopLeft,           //左上
        UIViewContentModeTopRight,          //右上
        UIViewContentModeBottomLeft,        //左下
        UIViewContentModeBottomRight,       //右下
         */
        self.contentMode = UIViewContentModeScaleAspectFill;
        self.clipsToBounds = YES;
    }
    return self;
}

- (UIImageView *)gifView{
    if (_gifView == nil) {
        UIImage *image = [UIImage imageNamed:@"timeline_image_gif"];
        UIImageView *gifView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return _gifView;
}

- (void)setPhoto:(SAPhoto *)photo{
    _photo = photo;
    
    //设置图片
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //显示、隐藏Gif图片
    self.gifView.hidden = ![photo.thumbnail_pic.lowercaseString hasSuffix:@"gif"];//lowercaseString变成小写
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
