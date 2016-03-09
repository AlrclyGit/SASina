//
//  UITextView+Extension.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/8.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (Extension)
- (void)insertAttributedText:(NSAttributedString *)text;
- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *AttributeText))settingBlock;
@end
