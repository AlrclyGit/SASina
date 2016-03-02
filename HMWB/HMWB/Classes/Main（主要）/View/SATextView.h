//
//  SATextView.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/1.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SATextView : UITextView
/** 占位文字*/
@property (nonatomic , copy) NSString *placeholder;
/** 占位文字颜色*/
@property (nonatomic, strong) UIColor *placeholderColor;
@end
