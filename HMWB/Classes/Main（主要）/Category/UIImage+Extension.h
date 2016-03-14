//
//  UIImage+Tool.h
//  SA43屏幕截屏
//
//  Created by SuzukiAlrcly on 15/9/24.
//  Copyright © 2015年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 *  AvatarCutting（头像裁剪）
 *
 *  @param name     图片的名称
 *  @param border   圆环的宽度
 *  @param color    圆环的颜色
 *
 *  return  返回一张裁剪过的UIImage
 */
+ (instancetype)imageWithAvatarCuttingName:(NSString *)name borderBreadth:(CGFloat)border borderColor:(UIColor *)color;

/**
 *  Screenshot（对View截图）
 *
 *  @param view     传入的视图
 *  @param file     将UIImage返回到何处
 *
 *  return  返回一张视图截图的UIImage
 */
+ (instancetype)imageWithScreenshotView:(UIView *)view writeToFile:(NSString *)file;

@end
