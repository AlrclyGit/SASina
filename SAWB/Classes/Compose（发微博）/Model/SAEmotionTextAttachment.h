//
//  SAEmotionTextAttachment.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/9.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAEmotion;

@interface SAEmotionTextAttachment : NSTextAttachment
@property (nonatomic, strong) SAEmotion *emotion;
@end
