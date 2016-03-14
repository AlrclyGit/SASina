//
//  SATitleButton.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/22.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SATitleButton.h"

@implementation SATitleButton

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"] forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];
        self.imageView.contentMode = UIViewContentModeCenter;
        self.titleLabel.contentMode = UIViewContentModeCenter;
        
     }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //1.计算titlelabel的frame
    self.titleLabel.x = self.imageView.x;
    
    //2.计算imageView的frame
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame) + 5;
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state{
    [super setImage:image forState:state];
    [self sizeToFit];
}

@end
