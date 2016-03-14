//
//  SADropdownMenu.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/18.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//  自定义下拉菜单

#import "SADropdownMenu.h"


@interface SADropdownMenu()
//将来用来显示具体内容的容器
@property (nonatomic ,weak) UIImageView *containerView;
@end



@implementation SADropdownMenu

//创建一个下拉菜单，其实只改变了蒙板的颜色
+ (instancetype)menu{
    return [[self alloc] init];
}

//创建一个下拉菜单，其实只改变蒙板的颜色
- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //消除颜色
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

//灰色图片的懒加载
- (UIImageView *)containerView{
    if (!_containerView) {
        //添加一个灰色图片控件
        UIImageView *contentView = [[UIImageView alloc]init];
        //设置View图片
        contentView.image = [UIImage imageNamed:@"popover_background"];
        //开启交互功能
        contentView.userInteractionEnabled = YES;
        //设置View大小
        contentView.width = 217;
        contentView.height = 217;
        //添加到当前View
        [self addSubview:contentView];
        //赋值给成员属性
        _containerView= contentView;
        
    }
    return  _containerView;
}

//对传进来的View进行设置
- (void)setContent:(UIView *)content{
    _content = content;
    
    //调整内容的位置
    content.x = 10;
    content.y = 15;
    
    //设置内容的宽度
    //content.width = self.containerView.width - 2 * content.x;
    
    //设置菜单的尺寸
    self.containerView.width = CGRectGetMaxX(content.frame) + 11;
    self.containerView.height = CGRectGetMaxY(content.frame) + 10;
    
    //添加内容到灰色图片中
    [self.containerView addSubview:content];
    
}

//对传进来的ViewController进行设置
- (void)setContentController:(UIViewController *)contentController{
    _contentController = contentController;
    self.content = contentController.view;
}

//
- (void)showFrom:(UIView *)from{
    //1.获得最上面的窗口
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    
    //2.设置蒙板尺寸
    self.frame = window.bounds;
    
    //默认情况下，frame是以父控件左上角为坐标原点
    //可以转换坐标系原点，改变frame的参照点
    //获得传入按钮在Window中的坐标
    CGRect newFrame = [from.superview convertRect:from.frame toView:window];
 
    //3.调整灰色图片的位置
    self.containerView.centerX = CGRectGetMidX(newFrame);
    self.containerView.y = CGRectGetMaxY(newFrame);
    
    //3.添加自己到最上面的窗口
    [window addSubview:self];
    
    //通知外界，自己被创建了
    if ([self.delegate respondsToSelector:@selector(DropdownMenuDidShow:)]) {
        [self.delegate DropdownMenuDidShow:self];
    }
    
}

//
- (void)dismiss{
    //从父控件移除
    [self removeFromSuperview];
    //通知外界，自己被销毁了
    if ([self.delegate respondsToSelector:@selector(DropdownMenuDidDismiss:)]) {
        [self.delegate  DropdownMenuDidDismiss:self];
    }
}

//
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];

}

@end
