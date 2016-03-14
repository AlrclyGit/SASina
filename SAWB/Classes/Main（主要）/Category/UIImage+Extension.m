//
//  UIImage+Tool.m
//  SA43屏幕截屏
//
//  Created by SuzukiAlrcly on 15/9/24.
//  Copyright © 2015年 SuzukiAlrcly. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

//  AvatarCutting（头像裁剪）
+ (instancetype)imageWithAvatarCuttingName:(NSString *)name borderBreadth:(CGFloat)border borderColor:(UIColor *)color{
    //圆环的宽度
    CGFloat borderB = border;
    
    //原图片大小
    UIImage *oldimage = [UIImage imageNamed:name];
    
    //设置上下文大小
    CGFloat imageW = oldimage.size.height + 2 * borderB;
    CGFloat imageH = oldimage.size.width + 2 * borderB;
    
    CGFloat circirB = imageW > imageH ? imageH : imageW ;
    
    //创建上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(circirB, circirB), NO, 0.0);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //绘制大圆
    UIBezierPath * path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, circirB, circirB)];
    
    //把大圆添加到上下文
    CGContextAddPath(ctx, path.CGPath);
    
    //设置大圆颜色
    [color set];
    
    //渲染
    CGContextFillPath(ctx);
    
    //绘制小圆
    UIBezierPath * path1= [UIBezierPath bezierPathWithOvalInRect:CGRectMake(borderB, borderB, oldimage.size.width, oldimage.size.height)];
    
    //把小圆设成遮罩
    [path1 addClip];
    
    //加载图片到上下文
    [oldimage drawAtPoint:CGPointMake(borderB, borderB)];
    
    //输出上下文内的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

// Screenshot（对View截图）
+ (instancetype)imageWithScreenshotView:(UIView *)view writeToFile:(NSString *)file{
    
    //开启上下文
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, 0.0);
    
    //获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //渲染控制器View的图层到上下文
    //图层只能用渲染，不能用Draw
    [view.layer renderInContext:ctx];
    
    //获取截屏图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    if (file != nil) {
        NSData *data = UIImagePNGRepresentation(newImage);
        [data writeToFile:file atomically:YES];
    }

    return newImage;

}

@end
