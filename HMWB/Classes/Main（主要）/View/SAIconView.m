//
//  SAIconView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/1.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAIconView.h"
#import "SAUser.h"
#import "UIImageView+WebCache.h"


@interface SAIconView ()
@property (nonatomic , weak) UIImageView *verifideView;
@end

@implementation SAIconView

- (UIImageView *)verifideView{
    if (_verifideView == nil) {
        UIImageView *verifideView = [[UIImageView alloc]init];
        [self addSubview:verifideView];
        _verifideView = verifideView;
    }
    return _verifideView;
}


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (void)setUser:(SAUser *)user{
    _user = user;
    
    //下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    //设置加V图片
    switch (user.verified_type) {
            
        case SAUserVerifiedtypePersonal: //个人认证
            self.verifideView.hidden = NO;
            self.verifideView.image = [UIImage imageNamed:@"avatar_vip"];
            break;
            
        case SAUserVerifiedtypeEnterprice: //官方认证
        case SAUserVerifiedtypeMedia:
        case SAUserVerifiedtypeWebstie:
            self.verifideView.hidden = NO;
             self.verifideView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];
            break;
            
        case SAUserVerifiedtypeDaren: //NO博达人
            self.verifideView.hidden = YES;
             self.verifideView.image = [UIImage imageNamed:@"avatar_grassroot"];
            break;
    
        default:
                self.verifideView.hidden = YES;  //没有任何认证
            break;
    }
}


- (void)layoutSubviews{
    [super layoutSubviews];
    self.verifideView.size = self.verifideView.image.size;
    CGFloat scale = 0.6;
    self.verifideView.x = self.width - self.verifideView.width * scale;
    self.verifideView.y = self.height - self.verifideView.height * scale;
}



@end
