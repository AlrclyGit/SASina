//
//  SATitleMenuViewController.m
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/18.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import "SATitleMenuViewController.h"

@interface SATitleMenuViewController ()

@end

@implementation SATitleMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"id";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = @"我爱的人";
    }
    else if (indexPath.row == 1){
        cell.textLabel.text = @"爱我的人";

    }
    else if (indexPath.row == 2){
        cell.textLabel.text = @"爱无能的人";

    }
    return cell;
}
@end
