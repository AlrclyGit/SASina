//
//  SATest1ViewController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/16.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SATest1ViewController.h"
#import "SATest2ViewController.h"

@interface SATest1ViewController ()

@end

@implementation SATest1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SALog(@"123");
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    SATest2ViewController *test2 = [[SATest2ViewController alloc] init];
    test2.title = @"真的你爱你";
    [self.navigationController pushViewController:test2 animated:YES];
    
}


@end

