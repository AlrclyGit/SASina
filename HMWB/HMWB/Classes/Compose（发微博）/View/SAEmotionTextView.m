//
//  SAEmotionTextView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/8.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAEmotionTextView.h"
#import "SAEmotion.h"
#import "SAEmotionTextAttachment.h"

@implementation SAEmotionTextView

- (void)insertEmotion:(SAEmotion *)emotion {
    if (emotion.code) {
        //insertText将文字插入到光标所有的位置
        [self insertText:emotion.code.emoji];
    }
    else if (emotion.png) {
        
        //创建一个属性化字符串的附件
        SAEmotionTextAttachment *attch = [[SAEmotionTextAttachment alloc] init];
        
        attch.emotion = emotion;
        
        //
        attch.image = [UIImage imageNamed:emotion.png];
        //获得高行
        CGFloat attchWH = self.font.lineHeight;
        //设置附件的尺寸
        attch.bounds = CGRectMake(0, -3, attchWH, attchWH);
        //将附件装入属性化字符串
        NSAttributedString *imageStr = [NSAttributedString attributedStringWithAttachment:attch];
 
        [self insertAttributedText:imageStr settingBlock:^(NSMutableAttributedString *AttributeText) {
            //设置属性化字符串的文字大小（和当前输入文字一样）//(key,值)，范围
            [AttributeText addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, AttributeText.length)];
        }];
        
        
//        /** 不可实现的不明Bug*/
//        NSMutableAttributedString *aaa = (NSMutableAttributedString *)self.attributedText;
//        //设置属性化字符串的文字大小（和当前输入文字一样）//属性,价值，范围
//        [aaa addAttribute:NSFontAttributeName value:self.font range:NSMakeRange(0, aaa.length)];
    }
    
}

- (NSString *)fullText {
    
    NSMutableString *fullText = [NSMutableString string];
    
    //遍历所有的属性文字
    [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary<NSString *,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
        
        //如果是图片表情
        SAEmotionTextAttachment *attch = attrs[@"NSAttachment"];
        if (attch) {//图片
            NSString *chs = attch.emotion.chs;
            [fullText appendString:chs ];
        }
        else {//非图片
            NSAttributedString *str = [self.attributedText attributedSubstringFromRange:range];
            [fullText appendString:str.string];
        }
        
    }];
    return fullText;
    
    SALog(@"%@",fullText);
}




@end
