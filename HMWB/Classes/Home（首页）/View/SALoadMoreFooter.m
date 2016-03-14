//
//  SALoadMoreFooter.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/23.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SALoadMoreFooter.h"

@implementation SALoadMoreFooter

+ (instancetype)footer{
    return [[[NSBundle mainBundle] loadNibNamed:@"SALoadMoreFooter" owner:nil options:nil] lastObject];
}

@end
