//
//  UIBarButtonItem+Tool.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/16.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Extension)

/**
 *  itemWhithtarget(设定一个快速自定义导航控制器的左右按钮)
 *
 *  Target：传入一个View，用来设置按钮响应
 *  Action：设置按钮响应方法名
 *  Image：默认图片
 *  Highimage：高亮图片
 *
 *  @return 返回一个UIBarButtonItem
 */
+ (UIBarButtonItem *)itemWithTarget:(id)target Action:(SEL)action Image:(NSString *)image Highimage:(NSString *)highimage;

@end
