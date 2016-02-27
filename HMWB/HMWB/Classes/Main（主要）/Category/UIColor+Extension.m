//
//  UIColor+Tool.m
//  SA43屏幕截屏
//
//  Created by SuzukiAlrcly on 15/9/24.
//  Copyright © 2015年 SuzukiAlrcly. All rights reserved.
//

#import "UIColor+Extension.h"

@implementation UIColor (Extension)

//randomColor(随机颜色)
+ (UIColor *)colorRandom{
    CGFloat r = arc4random_uniform(256) / 255.0;
    CGFloat g = arc4random_uniform(256) / 255.0;
    CGFloat b = arc4random_uniform(256) / 255.0;
    return [UIColor colorWithRed:r green:g blue:b alpha:0.8];
}

//colorWithRGBA(通过RGBA自定义颜色)
+ (UIColor *)colorWithRGBARed:(int)r Green:(int)g Blue:(int)b Alpha:(int)a{
    CGFloat rr = (r) / 255.0;
    CGFloat gg = (g) / 255.0;
    CGFloat bb = (b) / 255.0;
    return [UIColor colorWithRed:rr green:gg blue:bb alpha:a];
}

@end
