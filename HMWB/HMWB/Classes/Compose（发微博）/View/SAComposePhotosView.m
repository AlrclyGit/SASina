//
//  SAComposePhotosView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/2.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAComposePhotosView.h"

@implementation SAComposePhotosView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (void)addPhoto:(UIImage *)photo{
    UIImageView *photoView = [[UIImageView alloc] init];
    photoView.image = photo;
    [self addSubview:photoView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    // 设置图片的尺寸各位置
    long Count = self.subviews.count;
    int maxCol = 4;
    CGFloat imageWH =70;
    CGFloat imageMargin = 10;
    
    for (int i = 0; i < Count; i++) {
        
        UIImageView *photoView = self.subviews[i];
        
        long cols =  i % maxCol;
        photoView.x =  cols * (imageWH + imageMargin);
        
        long rows =  i / maxCol;
        photoView.y =  rows * (imageWH + imageMargin);
        
        photoView.width = imageWH;
        photoView.height = imageWH;
    }

}
@end
