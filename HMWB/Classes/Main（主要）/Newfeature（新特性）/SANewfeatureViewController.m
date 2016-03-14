//
//  SANewfeatureViewController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/20.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SANewfeatureViewController.h"
#import "SAMainViewController.h"

#define SAnewfeatureCount 4

@interface SANewfeatureViewController ()<UIScrollViewDelegate>
@property (nonatomic , weak) UIPageControl *pageConerol;
@end

@implementation SANewfeatureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.创建一个scrollview:显示所有的新特性图片
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    //获得scrollView的大小
    CGFloat scrollW = scrollView.width;
    CGFloat scrollH = scrollView.height;
    //如果想要某个方向上不能滚动，那么这人方向对应的尺寸数值传0即可
    //可滚动范围
    scrollView.contentSize = CGSizeMake(SAnewfeatureCount * scrollW, 0);
    //弹簧效果
    scrollView.bounces = NO;
    //分页
    scrollView.pagingEnabled = YES;
    //水平滚动条
    scrollView.showsHorizontalScrollIndicator = NO;
    //设置代理
    scrollView.delegate = self;
    
    
    //2.
    for (int i = 0; i < SAnewfeatureCount; i++) {
        UIImageView *imageVeiw = [[UIImageView alloc]init];
        imageVeiw.width = scrollW;
        imageVeiw.height = scrollH;
        imageVeiw.x = i * scrollW;
        imageVeiw.y = 0;
        NSString *name = [NSString stringWithFormat:@"new_feature_%d",i + 1 ];
        imageVeiw.image = [UIImage imageNamed:name];
        [scrollView addSubview:(UIImageView *)imageVeiw];
        //默认情况下，scrollView里面可能会存在其他非手动添加的子控件
        if (i == SAnewfeatureCount - 1) {
            [self setupLastImageView:imageVeiw];
        }
        
    }
    [self.view addSubview:scrollView];
    
    
    
    //3.添加pageControl:分页，展示目前看到的是第几页
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.numberOfPages = SAnewfeatureCount;
//    UIPageControl就算没有设置尺寸，里面的内容还是照常显示的
//    pageControl.width = 100;
//    pageControl.height = 50;
    pageControl.centerX = self.view.width * 0.5;
    pageControl.centerY = self.view.height * 0.5 + 300;
    //高亮状态下的颜色
    pageControl.pageIndicatorTintColor = [UIColor colorWithRGBARed:189 Green:189 Blue:189 Alpha:1];
    //普通状态下的颜色
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRGBARed:253 Green:98 Blue:42 Alpha:1];
    //不可交互
    pageControl.userInteractionEnabled = NO;
    //
    _pageConerol = pageControl;
    [self.view addSubview:pageControl];
    
}


//
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    double page =  scrollView.contentOffset.x / scrollView.width;
    //四舍五入计算出页码
    self.pageConerol.currentPage = (int)(page + 0.5);
}


//初始化最后一个imageView
- (void)setupLastImageView:(UIImageView *)imageVeiw{
    
    //开启交互功能（checkbox）
    imageVeiw.userInteractionEnabled = YES;
    
    //1.分享给大家（checkbox）
    UIButton *shareBtn = [[UIButton alloc] init];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_false"] forState:UIControlStateNormal];
    [shareBtn setImage:[UIImage imageNamed:@"new_feature_share_true"] forState:UIControlStateSelected];
    [shareBtn setTitle:@"分享给大家" forState:UIControlStateNormal];
    [shareBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    shareBtn.width = 150;
    shareBtn.height = 30;
    shareBtn.centerX = imageVeiw.width * 0.5;
    shareBtn.centerY = imageVeiw.height * 0.7;
    [shareBtn addTarget:self action:@selector(shareClick:) forControlEvents:UIControlEventTouchUpInside];
    shareBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 5);
    //shareBtn.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    [imageVeiw addSubview:shareBtn];


    //2.开始微博
    UIButton *startBtn = [[UIButton alloc]init];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startBtn setBackgroundImage:[UIImage imageNamed:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    [startBtn setTitle:@"开始微博" forState:UIControlStateNormal];
    startBtn.size = startBtn.currentBackgroundImage.size;
    startBtn.centerX = shareBtn.centerX;
    startBtn.centerY = imageVeiw.height * 0.8;
    [startBtn addTarget:self action:@selector(startClick) forControlEvents:UIControlEventTouchUpInside];
    [imageVeiw addSubview:startBtn];
}

- (void)shareClick:(UIButton *)shareBtn{
    shareBtn.selected = !shareBtn.isSelected;
}

- (void)startClick{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    window.rootViewController = [[SAMainViewController alloc]init];
}



@end
