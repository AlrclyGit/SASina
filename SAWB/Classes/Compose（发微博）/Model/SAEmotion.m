//
//  SAEmotion.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/4.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAEmotion.h"
#import "MJExtension.h"

@interface SAEmotion() <NSCoding>

@end

@implementation SAEmotion

MJCodingImplementation

- (BOOL)isEqual:(SAEmotion *)object {
    return [self.chs isEqualToString:object.chs] || [self.code isEqualToString: object.code];
}

@end
