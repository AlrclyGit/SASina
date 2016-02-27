//
//  SAMessageCenterViewController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/16.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SAMessageCenterViewController.h"
#import "SATest1ViewController.h"

@interface SAMessageCenterViewController ()

@end

@implementation SAMessageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID =@"ID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.textLabel.text  = [NSString stringWithFormat:@"我爱柠檬酸%ld",(long)indexPath.row];
    return cell;
}

#pragma mark - 代理方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SATest1ViewController *test1 = [[SATest1ViewController alloc] init];
    test1.title = @"my";
    
    //当test1控制器被Push的时候，test1所在的tabbarcontroller的tabbar会自动隐藏
    //当test1控制器被Pop的时候，test1所在的tabbarcontroller的tabbar会自动显示
    [self.navigationController pushViewController:test1 animated:YES];

}
@end
