//
//  SAEmotionTextView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/8.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAEmotionTextView.h"
#import "SAEmotion.h"

@implementation SAEmotionTextView

- (void)insertEmotion:(SAEmotion *)emotion {
    if (emotion.code) {
        //insertText将文字插入到光标所有的位置
        [self insertText:emotion.code.emoji];
    }
    else if (emotion.png) {
        
        //创建一个属性化字符串的附件
        NSTextAttachment *attch = [[NSTextAttachment alloc] init];
        //设置附件的图片
        attch.image = [UIImage imageNamed:emotion.png];
        //获得高行
        CGFloat attchWH = self.font.lineHeight;
        //设置附件的尺寸
        attch.bounds = CGRectMake(0, -3, attchWH, attchWH);
        //将附件装入属性化字符串
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
        //
        [self insertAttributeText:imageStr];
        
        //
        NSMutableAttributedString *abc = (NSMutableAttributedString *)self.attributedText;
        //设置属性化字符串的文字大小（和当前输入文字一样）//属性,价值，范围
        [abc addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, abc.length)];
    }
    
}




@end
