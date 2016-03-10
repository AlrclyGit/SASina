//
//  UITextView+Extension.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/8.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "UITextView+Extension.h"

@implementation UITextView (Extension)

- (void)insertAttributedText:(NSAttributedString *)text {
    [self insertAttributedText:text settingBlock:nil];

}

- (void)insertAttributedText:(NSAttributedString *)text settingBlock:(void (^)(NSMutableAttributedString *))settingBlock {
    //创建一个属性化字符串
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] init];
    //将之前的文字拼接上来
    [attributedText appendAttributedString:self.attributedText];
    //获得当前光标位置
    NSUInteger loc = self.selectedRange.location;
    //用附件替换
    [attributedText replaceCharactersInRange:self.selectedRange withAttributedString:text];
//    //将附件text插入到loc
//    [attributedText insertAttributedString:text atIndex:loc];
    //调用外面传进来的方法
    if (settingBlock) {
        settingBlock(attributedText);
    }
    //设置到文本
    self.attributedText = attributedText;
    //移动光标到表情的后面
    self.selectedRange = NSMakeRange(loc + 1, 0);
}

/**
 selectedRange:
 1.本来是用来控件textViewr文字选中范围
 2.如果 ctedrange、length为0，selected拒e.location就是textView的光标位置
 
 关于textView文字的字体
 1.如果是普通文字(text)，文字大小由textView.fontr控件
 2.如果是属性文字（attributedText）,文字大小不要受textView.font控件，应该利用NSMutableAttributedString的- (void)addAttribute:(NSString *)name value:(id)value range:(NSRange)range;方法设置字体
 **/

@end
