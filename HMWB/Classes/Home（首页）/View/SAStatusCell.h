//
//  SAStatusCell.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/24.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SAStatusFrame;

@interface SAStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@property (nonatomic, strong) SAStatusFrame *statusFrame;

@end
