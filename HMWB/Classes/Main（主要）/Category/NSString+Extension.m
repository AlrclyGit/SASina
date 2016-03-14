//
//  NSString+Extension.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/27.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "NSString+Extension.h"

@implementation NSString (Extension)

- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    //[text sizeWithAttributes:attrs]
    CGSize maxSize = CGSizeMake(maxW , MAXFLOAT);
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

- (CGSize)sizeWithFont:(UIFont *)font{
    
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

@end
