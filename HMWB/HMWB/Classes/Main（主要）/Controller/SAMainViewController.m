//
//  SAMainViewController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/16.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAMainViewController.h"
#import "SAHomeViewController.h"
#import "SAMessageCenterViewController.h"
#import "SADiscoverViewController.h"
#import "SAProfileViewController.h"
#import "SANavigationController.h"
#import "SATabBar.h"
#import "SAComposeViewController.h"

@interface SAMainViewController () <SATabBarDelegate>

@end

@implementation SAMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //1.设置子控制器
    SAHomeViewController *home = [[SAHomeViewController alloc]init];
    [self addChildVc:home Title:@"首页" iamge:@"tabbar_home" selctImage:@"tabbar_home_selected"];
    SAMessageCenterViewController *messageCenter = [[SAMessageCenterViewController alloc]init];
    [self addChildVc:messageCenter Title:@"消息" iamge:@"tabbar_message_center" selctImage:@"tabbar_message_center_selected"];
    SADiscoverViewController *discover = [[SADiscoverViewController alloc]init];
    [self addChildVc:discover  Title:@"发现" iamge:@"tabbar_discover" selctImage:@"tabbar_discover_selected"];
    SAProfileViewController *profile = [[SAProfileViewController alloc]init];
    [self addChildVc:profile Title:@"我" iamge:@"tabbar_profile" selctImage:@"tabbar_profile_selected"];
    
    //2.更换系统自带的TabBar
    //self.tabBar = [[SATabBar alloc]init];
    SATabBar *SAtabBar = [[SATabBar alloc] init];
    //  SAtabBar.delegate = self;
    //  系统会自动设置代码，在老版本中，下面这么代码过后，tabbar的delegate就是SATabBarViewController
    //  如果tabBar设置完delegate后，再执行这行代码修改delegate,就会报错
    [self setValue:SAtabBar forKey:@"tabBar"];
    
    
    
}


//  设置TabBar的样式，并添加到self上
- (void)addChildVc:(UIViewController *)childVc Title:(NSString *)title iamge:(NSString *)image selctImage:(NSString *)selectIamge {
    
    //  设置文字的样式
    NSMutableDictionary *textAttrs = [NSMutableDictionary dictionary];
    textAttrs [NSForegroundColorAttributeName] = [UIColor colorWithRGBARed:123 Green:123 Blue:123 Alpha:1];//文字选中颜色
    NSMutableDictionary *selectTextAttrs = [NSMutableDictionary dictionary];
    selectTextAttrs [NSForegroundColorAttributeName] = [UIColor orangeColor];//文字非先中颜色
    
    //  设置文字内容和样式
    //  childVc .tabBarItem.title = title;//设置tabbar文字
    //  childVc.navigationItem.title = title;//设置导行中间文字
    childVc.title = title;//同时设置文字
    [childVc .tabBarItem setTitleTextAttributes:textAttrs forState:UIControlStateNormal];//文字非先中颜色
    [childVc .tabBarItem setTitleTextAttributes:selectTextAttrs forState:UIControlStateSelected];//文字选中颜色
    
    //设置TabBar颜色
    childVc .tabBarItem.image = [UIImage imageNamed:image];//图片非选中颜色
    childVc .tabBarItem.selectedImage = [[UIImage imageNamed:selectIamge] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];//图片选中颜色
    
    //View颜色
    //childVc.view.backgroundColor = [UIColor SAcolorRandom];
    
    //给childVc加个一个导航控制器
    SANavigationController *nav = [[SANavigationController alloc] initWithRootViewController:childVc];
    
    //将childVc添加到sele上
    [self addChildViewController:nav];
    
    //设置子控制器的两种写法
    //self.viewControllers = @[vc1,vc2,vc3];
    //[tabbarVc addChildViewController:vc1];
    
}

#pragma mark  - SATabBarDelegate代理方法

//点击中间按钮时调用
- (void)tabBarDidClickPlusButton:(SATabBar *)tabBar{
    SAComposeViewController *compose  = [[SAComposeViewController alloc]init];
    SANavigationController *nav = [[SANavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

@end
