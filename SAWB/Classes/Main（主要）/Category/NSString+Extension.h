//
//  NSString+Extension.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/27.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
- (CGSize)sizeWithFont:(UIFont *)font;
@end
