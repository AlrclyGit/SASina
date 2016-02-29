//
//  SAStatusPhotosView.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/29.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  Cell上面的配图相册（里面会显示1~9张相册，里面都是SAStatusPhotoView）

#import <UIKit/UIKit.h>

@interface SAStatusPhotosView : UIView
@property (nonatomic, strong) NSArray *photos;

/**
 * 根据图片个计算相册尺寸
 */
+ (CGSize)sizeWithCount:(long)count;
@end
