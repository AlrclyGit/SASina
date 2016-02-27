//
//  SAStatusToolBar.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/26.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAStatus;

@interface SAStatusToolBar : UIView
+ (instancetype)toolbar;
@property (nonatomic, strong) SAStatus *status;
@end
