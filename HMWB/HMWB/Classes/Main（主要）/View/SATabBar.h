//
//  SATabBar.h
//  HMWB
//
//  Created by SuzukiAlrcly on 16/2/19.
//  Copyright © 2016年 SuzukiAlrcly. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SATabBar;

@protocol SATabBarDelegate <UITabBarDelegate>
@optional
- (void)tabBarDidClickPlusButton:(SATabBar *)tabBar;
@end


@interface SATabBar : UITabBar
@property (nonatomic , weak) id<SATabBarDelegate> delegate;
@end
