//
//  SAUser.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/23.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAUser.h"

@implementation SAUser
- (void)setMbtype:(int)mbtype{
    _mbrank = mbtype;
    self.vip = mbtype > 2 ;
}
@end
