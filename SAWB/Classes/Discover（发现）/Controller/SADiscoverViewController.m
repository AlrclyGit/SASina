//
//  SADiscoverViewController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/16.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SADiscoverViewController.h"
#import "SASearchBar.h"
@interface SADiscoverViewController ()

@end

@implementation SADiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //创建搜索框，设置大小，并添加到titleVeiw
    SASearchBar *searchBar = [[SASearchBar alloc] init];
    searchBar.width = 350;
    searchBar.height = 34;
    self.navigationItem.titleView = searchBar;
    
}

@end
