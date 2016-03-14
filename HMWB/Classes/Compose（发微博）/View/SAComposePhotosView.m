//
//  SAComposePhotosView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/2.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAComposePhotosView.h"

@interface SAComposePhotosView()
@property (nonatomic, strong) NSMutableArray *addedPhotos;
@end


@implementation SAComposePhotosView

- (NSMutableArray *)addedPhotos{
    if (_addedPhotos == nil) {
        _addedPhotos = [[NSMutableArray alloc]init];
    }
    return _addedPhotos;
}


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
    
    //存储图片
    [self.addedPhotos addObject:photo];
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
        photoView.x =  imageMargin + cols * (imageWH + imageMargin);
        
        long rows =  i / maxCol;
        photoView.y =  imageMargin + rows * (imageWH + imageMargin);
        
        photoView.width = imageWH;
        photoView.height = imageWH;
    }

}

- (NSArray *)photos{
//    NSMutableArray *photos = [NSMutableArray array];
//    for (UIImageView *imageView in self.subviews) {
//        [photos addObject:imageView.image];
//    }
    return self.addedPhotos;
}


@end
