//
//  SAEmotionListView.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/3/3.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAEmotionListView.h"
#import "SAEmotionPageView.h"

@interface SAEmotionListView () <UIScrollViewDelegate>
@property (nonatomic , weak) UIScrollView * scrollView;
@property (nonatomic , weak) UIPageControl * pageControl;
@end


@implementation SAEmotionListView


- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        //
        self.backgroundColor = [UIColor whiteColor];
        
        //1.表情上部
        UIScrollView *scrollView = [[UIScrollView alloc] init];
        scrollView.pagingEnabled = YES;//分页
        scrollView.showsHorizontalScrollIndicator = NO;//去除水平方向滚动条
        scrollView.showsVerticalScrollIndicator = NO;//去除垂直方向滚动条
        scrollView.delegate = self;
        [self addSubview:scrollView];
        _scrollView = scrollView;
        
        //2.表情页数
        UIPageControl *pageControl = [[UIPageControl alloc] init];
        pageControl.hidesForSinglePage = YES;
        pageControl.userInteractionEnabled = NO;
        //用KVC换图片
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_normal"] forKey:@"pageImage"];
        [pageControl setValue:[UIImage imageNamed:@"compose_keyboard_dot_selected"] forKey:@"currentPageImage"];
        [self addSubview:pageControl];
        _pageControl = pageControl;
        
    }
    return self;
}

/**
 * 根据emotions，创建对应个数的表情
 */
- (void)setEmotions:(NSArray *)emotions {
    _emotions = emotions;
    
    /** 页数*/
    NSInteger count  = (emotions.count - 1 + SAEmotionPageSize) / SAEmotionPageSize;
    
    //1.设置页数
    self.pageControl.numberOfPages = count;
    
    //2.创建用来显示每一页表情的控件
    for (int i = 0 ; i < count ; i++) {
        SAEmotionPageView * pageView = [[SAEmotionPageView alloc] init];
        //计算这页的表情范围
        NSRange range;
        range.location = i * SAEmotionPageSize;//截取开始的地方
        //left:剩余的表情个数（可以截取的）
        NSUInteger left = emotions.count - range.location;
        if (left >= SAEmotionPageSize) {
            range.length = SAEmotionPageSize;//截取的长度
        }
        else {
            range.length = left;//截取的长度
        }
        //设置这一页的表情，截取数组的方法哦！
        pageView.emotions = [emotions subarrayWithRange:range];
        [self.scrollView addSubview:pageView];
    }
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    //1.pageControl
    self.pageControl.width = self.width;
    self.pageControl.height = 35;
    self.pageControl.x = 0 ;
    self.pageControl.y = self.height - self.pageControl.height;
    
    //2.scrollView
    self.scrollView.width = self.width;
    self.scrollView.height = self.pageControl.y;
    self.scrollView.x = self.scrollView.y = 0;
    
    //3.设置scrollView内部每一页的尺寸
    NSUInteger count = self.scrollView.subviews.count;
    for (int i = 0; i < count; i++) {
        SAEmotionPageView *PageView = self.scrollView.subviews[i];
        PageView.height = self.scrollView.height;
        PageView.width =self.scrollView.width;
        PageView.x = PageView.width * i ;
        PageView.y = 0;
    }
    
    //4.设置scrollView的contentSize
    self.scrollView.contentSize = CGSizeMake(count * self.scrollView.width, 0);
    
}

#pragma mark - 表情滚动视图的代理方法

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    double pageNo = scrollView.contentOffset.x /scrollView.width;
    self.pageControl.currentPage = (int)(pageNo + 0.5);
}



@end
