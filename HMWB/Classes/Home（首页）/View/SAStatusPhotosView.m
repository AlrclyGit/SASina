//
//  SAStatusPhotosView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/29.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAStatusPhotosView.h"
#import "SAPhoto.h"
#import "UIImageVIew+WebCache.h"
#import "SAStatusPhotoView.h"

//图片大小
#define SAStatusPhotoWH 110
//图片间隙
#define SAStatusPhotoMarginWH 10

#define SAStatusPhotoMaxCol(count) ((count == 4)?2:3)

@implementation SAStatusPhotosView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
       
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos{
    _photos = photos;
    long photosCount = photos.count;
    
    //创建足够数量的图片控件
    while (self.subviews.count < photosCount) {
        SAStatusPhotoView *photoView = [[SAStatusPhotoView alloc] init];
        [self addSubview:photoView];
    }
    
    //遍历图片控件，设置图片
    for (int i = 0; i<self.subviews.count; i++) {
        SAStatusPhotoView *photoView = self.subviews[i];
        if (i < photosCount) {//显示
            
            photoView.hidden = NO;
            //设置图片
            photoView.photo= photos[i];
            
        }
        else{
            photoView.hidden = YES;
        }
        
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    // 设置图片的尺寸各位置
    long photosCount = self.photos.count;
    int maxCol = SAStatusPhotoMaxCol(photosCount);
    for (int i = 0; i < photosCount; i++) {
        
        SAStatusPhotoView *photoView = self.subviews[i];
        
        long cols =  i % maxCol;
        photoView.x =  cols * (SAStatusPhotoWH + SAStatusPhotoMarginWH);
        
        long rows =  i / maxCol;
        photoView.y =  rows * (SAStatusPhotoWH + SAStatusPhotoMarginWH);
        
        photoView.width = SAStatusPhotoWH;
        photoView.height = SAStatusPhotoWH;
        
        
    }
    
}

+ (CGSize)sizeWithCount:(long)count{
    
    //最大列数
    int macCols = SAStatusPhotoMaxCol(count);
    //列数
    long cols = 0;
    cols = (count >= macCols) ? macCols : count;
    CGFloat photoW = cols * SAStatusPhotoWH + (cols - 1) * SAStatusPhotoMarginWH;
    //行数
    long rows = 0;
    rows = (count - 1 + macCols ) / macCols ;
    //传进来的下标从1开始，所以下标-1。加列数是为了最开始的商从1开始。
    
    CGFloat photoH = rows * SAStatusPhotoWH + (rows - 1) * SAStatusPhotoMarginWH;
    
    return CGSizeMake(photoW, photoH);
}





@end
