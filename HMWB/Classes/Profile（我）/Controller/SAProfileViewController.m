//
//  SAProfileViewController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/16.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAProfileViewController.h"
#import "SATest1ViewController.h"

@interface SAProfileViewController ()

@end

@implementation SAProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:0 target:self  action:@selector(setting)];
    
    //self.navigationItem.rightBarButtonItem.enabled = NO;
    //[[UINavigationBar appearance] setTintColor:[UIColor redColor]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setting{
    SATest1ViewController *test1 = [[SATest1ViewController alloc] init];
    test1.title = @"test1dd";
    [self.navigationController pushViewController:test1 animated:YES];
    
}


@end
