//
//  UIColor+Tool.h
//
//  Created by SuzukiAlrcly on 15/9/24.
//  Copyright © 2015年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Extension)

/**
 *  RandomColor(随机颜色)
 *
 *  @return 返回随机的UIColor
 */

+ (UIColor *)colorRandom;


/**
 *  colorWithRGBA(通过RGBA自定义颜色)
 *
 *  @Red：红
 *  @Green：绿
 *  @Blue：蓝
 *  @Alpha：透明度
 */
+ (UIColor *)colorWithRGBARed:(int)a Green:(int)g Blue:(int)b Alpha:(int)a;

@end
