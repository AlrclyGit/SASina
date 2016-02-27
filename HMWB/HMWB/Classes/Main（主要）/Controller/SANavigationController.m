//
//  SANavigationController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/16.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SANavigationController.h"

@interface SANavigationController ()

@end

@implementation SANavigationController

+ (void)initialize{
//    //设置整个项目所有item的主题样式
//    UIBarButtonItem *item = [UIBarButtonItem appearance];
//    
//    //设置普通状态
//    //key：NS****AttributeName
//    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
//    textAttrs [NSForegroundColorAttributeName] = [UIColor orangeColor];
//    //textAttrs [NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    [item setTitleTextAttributes:textAttrs forState:UIControlStateNormal];
//    
//    //设置高亮状态
//    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
//    selectTextAttrs [NSForegroundColorAttributeName] = [UIColor blackColor];
//    //textAttrs [NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    [item setTitleTextAttributes:selectTextAttrs forState:UIControlStateHighlighted];
//    
//    //设置不可用状态
//    NSMutableDictionary *disableTextAttrs = [NSMutableDictionary dictionary];
//    disableTextAttrs [NSForegroundColorAttributeName] = [UIColor grayColor];
//    //textAttrs [NSFontAttributeName] = [UIFont systemFontOfSize:13];
//    [item setTitleTextAttributes:disableTextAttrs forState:UIControlStateDisabled];
    
    //统一Navigationbar的颜色样式
    [[UINavigationBar appearance] setTintColor:[UIColor orangeColor]];
    
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
    if (self.viewControllers.count > 0) {
        
       
        
        viewController.navigationItem.leftBarButtonItem =  [UIBarButtonItem itemWithTarget:self Action:@selector(back) Image:@"navigationbar_back" Highimage:@"navigationbar_back_highlighted"];
        
        viewController.navigationItem.rightBarButtonItem = [UIBarButtonItem  itemWithTarget:self Action:@selector(more) Image:@"navigationbar_more" Highimage:@"navigationbar_more_highlighted"];
        
        viewController.hidesBottomBarWhenPushed = YES; //在推时隐藏下栏
        
    }
    
    [super pushViewController:viewController animated:animated];
    
}

- (void)back{
    [self popViewControllerAnimated:YES];
}

- (void)more{
    [self  popToRootViewControllerAnimated:YES];
    
}

@end
