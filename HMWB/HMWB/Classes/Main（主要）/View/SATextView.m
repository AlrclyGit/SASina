//
//  SATextView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/1.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  带有占位文字

#import "SATextView.h"

@implementation SATextView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [SANotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
    }
    return self;
}

- (void)dealloc{
    [SANotificationCenter  removeObserver:self];
}

/**
 * 监听文字改变
 */
- (void)textDidChange{
    //重绘,并不是立刻调用，而是在下一个消息循环时，调用drawRect
    [self setNeedsDisplay];
}

/** 重写placeholder*/
- (void)setPlaceholder:(NSString *)placeholder{
    _placeholder = [placeholder copy];
     [self setNeedsDisplay];
}

/** 重写placeholderColor*/
- (void)setPlaceholderColor:(UIColor *)placeholderColor{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

/** 重写setText*/
- (void)setText:(NSString *)text{
    [super setText:text];
    [self setNeedsDisplay];
}

/**  重写设置字体*/
- (void)setFont:(UIFont *)font{
    [super setFont:font];
    [self setNeedsDisplay];
}

/** 重写属性文字*/
- (void)setAttributedText:(NSAttributedString *)attributedText {
    [super setAttributedText:attributedText];
    [self setNeedsDisplay];
}


/**
 * 绘图方法
 */
- (void)drawRect:(CGRect)rect{
    //如果有输入文字，就直接返回，不画占位文字
    if (self.hasText)  return;
    //设置一个文字样式
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    //设置文字属性
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor grayColor];
    //画出文字，位置，大小
    //[self.placeholder drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat w = rect.size.width - 2 * x;
    CGFloat h = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, w, h);
    [self.placeholder drawInRect:placeholderRect withAttributes:attrs];
}





@end
