//
//  SAHomeViewController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/16.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAHomeViewController.h"
#import "SADropdownMenu.h"
#import "SATitleMenuViewController.h"
#import "SAHttpTool.h"
#import "SAAccountTool.h"
#import "SATitleButton.h"
#import "UIImageView+WebCache.h"
#import "SAUser.h"
#import "SAStatus.h"
#import "MJExtension.h"
#import "SALoadMoreFooter.h"
#import "SAStatusCell.h"
#import "SAStatusFrame.h"
#import "MJRefresh.h"


@interface SAHomeViewController ()<SADropdownMenuDelegate>
/**
 * 微博数组（里面放的都是stautsesFrame模型，一个stautsesFrame模型就代表一条微博）
 */
@property (nonatomic, strong) NSMutableArray *stautsesFrame;
@end


@implementation SAHomeViewController

/**
 * 懒加载微博数组
 */
- (NSMutableArray *)stautsesFrame{
    if (_stautsesFrame == nil) {
        _stautsesFrame = [[NSMutableArray alloc]init];
    }
    return _stautsesFrame;
}

/**
 * 将SAStatus模型转为SAStatusFrame模型
 */
- (NSArray *)stausFramesWithStatuses:(NSArray *)statuses{
    NSMutableArray *frames = [NSMutableArray array];
    for (SAStatus *status in statuses) {
        SAStatusFrame *f = [[SAStatusFrame alloc]init];
        f.status = status;
        [frames addObject:f];
    }
    return frames;
}

/**
 * 初始化方法
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置tabeView颜色
    self.tableView.backgroundColor = [UIColor colorWithRGBARed:211 Green:211 Blue:211 Alpha:1];
    
    //设置导航栏内容
    [self setupNav];
    
    //获得用户信息（昵称）
    [self setupUserInfo];
    
    //集成下拉刷新控件
    [self setupDownRefresh];
    
     //集成上拉刷新控件
    [self setupUPRefresh];
    
//    //获得未读数
//    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(setupUnredadCount) userInfo:nil repeats:YES];
//    //主线程也会抽时间优先处理下timer（不管主线程是否正在处理其他事件）
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 * 左按钮
 */
- (void)friendSearch{
    
}

/**
 * 右按钮
 */
- (void)pop{
    
}

/**
 * 设置导航栏内容
 */
- (void)setupNav{
    //设置左右按钮的样式
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(friendSearch) Image:@"navigationbar_friendsearch" Highimage:@"navigationbar_friendsearch_highlighted"];
    
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTarget:self Action:@selector(pop) Image:@"navigationbar_pop" Highimage:@"navigationbar_pop_highlighted"];
    
    //中间的标题按钮
    SATitleButton *titleButton = [[SATitleButton alloc] init];
    
    //设置中间的标题按钮图片和文字
    NSString *name = [SAAccountTool account].name;
    [titleButton setTitle:name ? name:@"首页" forState:UIControlStateNormal];
    
    //监听首页中间标题点击
    [titleButton addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.titleView = titleButton;
    
}

/**
 * 获得用户信息（昵称）
 */
- (void)setupUserInfo{
    
    //2.拼接请求参数
    SAAccount *accout = [SAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = accout.access_token;
    params[@"uid"] = accout.uid;
    
    [SAHttpTool get:@"https://api.weibo.com/2/users/show.json" params:params success:^(id json) {
        SALog(@"获取用户名称请求成功");
        //标题按钮
        UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
        
        //设置名字
        SAUser *user = [SAUser objectWithKeyValues:json];
        [titleButton setTitle:user.name forState:UIControlStateNormal];
        
        //存储昵称到沙盒中
        accout.name = user.name;
        [SAAccountTool saveAccount:accout];
    } failure:^(NSError *error) {
        SALog(@"获取用户名称请求失败——%@",error);

    }];
}

/**
 * 集成下拉刷新控件
 */
- (void)setupDownRefresh{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        SALog(@"UIRefreshControl进入刷新状态");
        
        //1.拼接请求参数
        SAAccount *accout = [SAAccountTool account];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = accout.access_token;
        //取出最前面的微博（最新的微博，ID最大的微博）
        SAStatusFrame *firstStatusF = [self.stautsesFrame firstObject];
        //若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
        if (firstStatusF) {
            params[@"since_id"] = firstStatusF.status.idstr;
        }
        
        [SAHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
            SALog(@"未读数请求成功");
            
            //取得微博数组
            NSArray *newStatuses = [SAStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
            NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
            //添加新数据到数组最前面
            NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)];//范围参数
            [self.stautsesFrame insertObjects:newFrames atIndexes:set];//将数组插某个范围
            //刷新表格
            [self.tableView reloadData];
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            //显示最新微博的数量
            [self showNewStatusCount:(int)newFrames.count];
            
        } failure:^(NSError *error) {
            
            SALog(@"刷新请求失败——%@",error);
            //结束刷新
            [self.tableView.mj_header endRefreshing];
            
        }];

    }];
    
    //主动调用开始刷新
    [self.tableView.mj_header beginRefreshing];
}

/**
 * 显示刷新的微博数量
 */
- (void)showNewStatusCount:(int)count{
    
    self.tabBarItem.badgeValue = nil;
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    //1.创建label
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"timeline_new_status_background"]];
    label.width = [UIScreen mainScreen].bounds.size.width;
    label.height = 35;
    
    //2.设置其他属性
    if (count == 0) {
        label.text = @"没有新的微博数据，稍后再试";
    }
    else{
        label.text = [NSString stringWithFormat:@"共有%d条新的微博数据",count];
    }
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    label.textAlignment = NSTextAlignmentCenter;
    //3.添加
    label.y = 64 -label.height;
    //将label添加到导航控制器的View中，并且是盖在导航栏下面
    [self.navigationController.view insertSubview:label belowSubview:self.navigationController.navigationBar];
    
    //4.动画
    //先用1S的时间，让label往下移动一段距离
    [UIView animateWithDuration:1.0 animations:^{
        label.transform = CGAffineTransformMakeTranslation(1, label.height);
    } completion:^(BOOL finished) {
        //执行动画时间，多少秒后执行动画，动画的快慢效果，动画代码，执行完后
        //再用1S的时间，让label回到原来的地方
        [UIView animateWithDuration:1.0 delay:1.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            label.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
            [label removeFromSuperview];
        }];
    }];
}

/**
 * 集成上拉刷新控件
 */
- (void)setupUPRefresh{
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        // 2.拼接请求参数
        SAAccount *account = [SAAccountTool account];
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"access_token"] = account.access_token;
        
        // 取出最后面的微博（最新的微博，ID最大的微博）
        SAStatusFrame *lastStatusF = [self.stautsesFrame lastObject];
        if (lastStatusF) {
            // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
            // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
            long long maxId = lastStatusF.status.idstr.longLongValue -1;
            params[@"max_id"] = @(maxId);
        }
        
        [SAHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
            // 将 "微博字典"数组 转为 "微博模型"数组
            NSArray *newStatuses = [SAStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
            NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
            // 将更多的微博数据，添加到总数组的最后面
            [self.stautsesFrame addObjectsFromArray:newFrames];
            // 刷新表格
            [self.tableView reloadData];
            // 结束刷新(隐藏footer)
            [self.tableView.mj_footer endRefreshing];
        } failure:^(NSError *error) {
            SALog(@"请求失败-%@", error);
            // 结束刷新
            self.tableView.tableFooterView.hidden = YES;
        }];
    }];
}

/**
 * 获取未读数，并显示角标
 */
- (void)setupUnredadCount{
    //2.拼接请求参数
    SAAccount *accout = [SAAccountTool account];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = accout.access_token;
    params[@"uid"] = accout.uid;
    
    [SAHttpTool get:@"https://api.weibo.com/2/remind/unread_count.json" params:params success:^(id json) {
        
        SALog(@"未读数请求成功——%@",json);
        //获取设置微博末读数
        NSString *status = [json[@"status"] description];
        
        if ([status isEqualToString:@"0"]) {
            self.tabBarItem.badgeValue = nil;
            [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
        }
        else{
            self.tabBarItem.badgeValue = status;
            [UIApplication sharedApplication].applicationIconBadgeNumber = status.intValue;
        }

    } failure:^(NSError *error) {
         SALog(@"未读数请求失败——%@",error);
    }];
}

/**
 * 触发中间标题点击调用的方法
 */
- (void)titleClick:(UIButton *)titleButton{
    //创建下拉菜单
    SADropdownMenu *menu = [SADropdownMenu menu];
    
    //设置箭头代理
    menu.delegate = self;
    
    //设置内容
    SATitleMenuViewController *vc = [[SATitleMenuViewController alloc] init];
    vc.view.height = 200;
    vc.view.width = 147;
    menu.contentController = vc;
    
    //显示
    [menu showFrom:titleButton];
    
}

#pragma mark - 中间标题点击的代理方法
/**
 * 创建，箭头向上
 */
- (void)DropdownMenuDidShow:(SADropdownMenu *)menu{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
    titleButton.selected = YES;
}
/**
 * 关闭，箭头向上
 */
- (void)DropdownMenuDidDismiss:(SADropdownMenu *)menu{
    UIButton *titleButton = (UIButton *)self.navigationItem.titleView;
     titleButton.selected = NO;
}

#pragma mark - tebleView的代理方法

/**
 * 返回多少行
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.stautsesFrame.count;
}

/**
 * 每行的内容
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //获得cell
    SAStatusCell *cell = [SAStatusCell cellWithTableView:tableView];
    
    //给cell传递模型数据
    //[cell setStatusFrame:[self stautsesFrame][indexPath.row]];
    cell.statusFrame = self.stautsesFrame[indexPath.row];
    
    
    return cell;
}

/**
 * Cell 返回的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    SAStatusFrame *frame = self.stautsesFrame[indexPath.row];
    return frame.cellHeight;
    
}






#pragma mark - 重构前代码
/**
 * 集成下拉刷新
 */
//- (void)setupDownRefresh{
//    //1.添加刷新控件
//    UIRefreshControl * conrtol = [[UIRefreshControl alloc] init];
//    //只有用户通过手动下拉刷新，才会触发UIControlEvenValueChanged事件
//    [conrtol addTarget:self action:@selector(refreshStateChang:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:conrtol];
//    //2.开始刷新状态
//    [conrtol beginRefreshing];//刷新指示
//    [self refreshStateChang:conrtol];//调用刷新方法
//}

///**
// *  加载下拉最新的数据
// */
//- (void)refreshStateChang{
//    SALog(@"UIRefreshControl进入刷新状态");
//    //2.拼接请求参数
//    SAAccount *accout = [SAAccountTool account];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = accout.access_token;
//
//    //取出最前面的微博（最新的微博，ID最大的微博）
//    SAStatusFrame *firstStatusF = [self.stautsesFrame firstObject];
//    //若指定此参数，则返回ID比since_id大的微博（即比since_id时间晚的微博），默认为0。
//    if (firstStatusF) {
//        params[@"since_id"] = firstStatusF.status.idstr;
//    }
//
//    [SAHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
//        SALog(@"未读数请求成功");
//
//        //取得微博数组
//        NSArray *newStatuses = [SAStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
//        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
//
//        //添加新数据到数组最前面
//        NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, newFrames.count)];//范围参数
//        [self.stautsesFrame insertObjects:newFrames atIndexes:set];//将数组插某个范围
//        //刷新表格
//        [self.tableView reloadData];
//        //结束刷新
//        [self.tableView.mj_header endRefreshing];
//        //显示最新微博的数量
//        [self showNewStatusCount:(int)newFrames.count];
//    } failure:^(NSError *error) {
//        SALog(@"刷新请求失败——%@",error);
//        //结束刷新
//        [self.tableView.mj_header endRefreshing];
//    }];
//}



///**
// * 判断是否进入上拉刷新
// */
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
//
//    // 如果tableView还没有数据 || 上拉加加载处于显示 ，就直接返回
//    if (self.stautsesFrame.count == 0 || self.tableView.tableFooterView.isHidden == NO) return;
//
//    // 获得内容偏移值
//    CGFloat offsetY = scrollView.contentOffset.y;
//    // 当最后一个cell完全显示在眼前时，contentOffset的y值
//    CGFloat judgeOffsetY = scrollView.contentSize.height + scrollView.contentInset.bottom - scrollView.height - self.tableView.tableFooterView.height;
//    /*
//     scrollView == self.tableView == self.view
//     contentInset：除具体内容以外的边框尺寸
//     contentSize: 里面的具体内容（header、cell、footer），除掉contentInset以外的尺寸
//     contentOffset:
//     1.它可以用来判断scrollView滚动到什么位置
//     2.指scrollView的内容超出了scrollView顶部的距离（除掉contentInset以外的尺寸）
//     */
//
//    if (offsetY >= judgeOffsetY) { // 最后一个cell完全进入视野范围内
//        // 显示footer
//        self.tableView.tableFooterView.hidden = NO;
//
//        // 加载更多的微博数据
//        [self loadMoreStatus];
//    }
//}

/**
 * 集成上拉刷新控件
 */
//- (void)setupUPRefresh{
//    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreStatus)];
//    //    SALoadMoreFooter *footer = [SALoadMoreFooter footer];
//    //    footer.hidden = YES;
//    //    self.tableView.tableFooterView = footer;
//}


///**
// *  加载以前的数据
// */
//- (void)loadMoreStatus{
//    // 2.拼接请求参数
//    SAAccount *account = [SAAccountTool account];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"access_token"] = account.access_token;
//    
//    // 取出最后面的微博（最新的微博，ID最大的微博）
//    SAStatusFrame *lastStatusF = [self.stautsesFrame lastObject];
//    if (lastStatusF) {
//        // 若指定此参数，则返回ID小于或等于max_id的微博，默认为0。
//        // id这种数据一般都是比较大的，一般转成整数的话，最好是long long类型
//        long long maxId = lastStatusF.status.idstr.longLongValue -1;
//        params[@"max_id"] = @(maxId);
//    }
//    
//    [SAHttpTool get:@"https://api.weibo.com/2/statuses/friends_timeline.json" params:params success:^(id json) {
//        
//        // 将 "微博字典"数组 转为 "微博模型"数组
//        NSArray *newStatuses = [SAStatus objectArrayWithKeyValuesArray:json[@"statuses"]];
//        NSArray *newFrames = [self stausFramesWithStatuses:newStatuses];
//        // 将更多的微博数据，添加到总数组的最后面
//        [self.stautsesFrame addObjectsFromArray:newFrames];
//        // 刷新表格
//        [self.tableView reloadData];
//        // 结束刷新(隐藏footer)
//        [self.tableView.mj_footer endRefreshing];
//        
//    } failure:^(NSError *error) {
//        SALog(@"请求失败-%@", error);
//        
//        // 结束刷新
//        self.tableView.tableFooterView.hidden = YES;
//        
//    }];
//    
//}


@end
